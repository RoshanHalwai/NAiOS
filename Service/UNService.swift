//
//  UNService.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 24/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseDatabase

class UNService: NSObject {
    
    private override init() {}
    
    static let shared = UNService()
    let unCenter = UNUserNotificationCenter.current()
    
    var window: UIWindow?
    let storyboard = UIStoryboard(name: NAViewPresenter().main(), bundle: nil)
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "There is no UN Authorization Error")
            guard granted else { return }
            DispatchQueue.main.async {
                self.configure()
            }
        }
    }
    
    func configure() {
        unCenter.delegate = self
        let application = UIApplication.shared
        application.registerForRemoteNotifications()
    }
}

extension UNService: UNUserNotificationCenterDelegate {
    
    //This is for Performing Action, when user clicks on notification view.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        //On click of particular Notification it will navigate to that particular screen.
        //Created varibale to get Notification Type from UserInfo
        let notificationType = userInfo[Constants.FIREBASE_NOTIFICATION_TYPE] as? String
        
        if notificationType == Constants.FIREBASE_NOTIFICATION_TYPE_NOTICE_BOARD {
            let dest = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().noticeBoardScreen())
            window?.rootViewController = dest
            window?.makeKeyAndVisible()
            
        } else {
            let launchVC = storyboard.instantiateViewController(withIdentifier: NAViewPresenter().rootVC())
            window?.rootViewController = launchVC
            window?.makeKeyAndVisible()
        }
        
        //Getting guestUID & guestType from UserInfo & using it for setting values in firebase.
        let guestType = userInfo[Constants.FIREBASE_CHILD_VISITOR_TYPE] as? String
        let guestUID = userInfo[Constants.FIREBASE_CHILD_NOTIFICATION_UID] as? String
        let profilePhoto = userInfo[NAString()._profile_photo()] as? String
        let message = userInfo[NAString()._message_()] as? String
        let mobileNumber = userInfo[NAString().mobile_Number()] as? String
        
        //Here we are performing Action on Notification Buttons & We created this buttons in  "setActionCategories" function.
        if response.notification.request.content.categoryIdentifier == NAString().notificationActionCategory() {
            
            //Created Firebase reference to get currently invited visitor by E-Intercom
            var gateNotificationRef : DatabaseReference?
            gateNotificationRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_GATE_NOTIFICATION).child(userUID).child(guestType!).child(guestUID!)
            
            //Performing accept & reject on click of recently invited visitor by E-Intercom from Notification view.
            switch response.actionIdentifier {
                
            //If Accept button will pressed
            case NAString().notificationAcceptIdentifier():
                gateNotificationRef?.child(NAString().status()).setValue(NAString().accepted())
                var visitorType = String()
                if guestType == Constants.FIREBASE_CHILD_GUESTS {
                    visitorType = Constants.FIREBASE_CHILD_VISITORS
                } else if guestType == Constants.FIREBASE_CHILD_CABS {
                    visitorType = Constants.FIREBASE_CHILD_CABS
                } else {
                    visitorType = Constants.FIREBASE_CHILD_DELIVERIES
                }
                let postApprovedRef = Database.database().reference().child(visitorType).child(Constants.FIREBASE_CHILD_PRIVATE).child(guestUID!)
                
                //Getting Current Date and Time when User clicked on Accept
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = NAString().current_Date_Format()
                let currentDate = formatter.string(from: date)
                
                if visitorType == Constants.FIREBASE_CHILD_VISITORS {
                    
                    //Mapping GuestUID with true
                    let userDataGuestRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_VISITORS).child(userUID)
                    userDataGuestRef.child(guestUID!).setValue(NAString().gettrue())
                    
                    let guestMobileRef = Constants.FIREBASE_VISITORS_ALL.child(mobileNumber!)
                    guestMobileRef.setValue(guestUID)
                    //Storing Post Approved Guests
                    let replacedMessage = message?.replacingOccurrences(of: NAString().your_Guest(), with: "")
                    let visitorRef = replacedMessage?.replacingOccurrences(of: NAString().wants_to_enter_Society(), with: "")
                    let postApprovedGuestsData = [
                        VisitorListFBKeys.approvalType.key : Constants.FIREBASE_CHILD_POST_APPROVED,
                        VisitorListFBKeys.uid.key : guestUID,
                        VisitorListFBKeys.dateAndTimeOfVisit.key : currentDate,
                        VisitorListFBKeys.status.key : NAString().entered(),
                        VisitorListFBKeys.fullName.key : visitorRef,
                        VisitorListFBKeys.inviterUID.key : userUID,
                        VisitorListFBKeys.profilePhoto.key : profilePhoto,
                        VisitorListFBKeys.mobileNumber.key : mobileNumber
                    ]
                    postApprovedRef.setValue(postApprovedGuestsData)
                } else if visitorType == Constants.FIREBASE_CHILD_CABS {
                    
                    //Mapping CabUID with true
                    let userDataCabRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_CABS).child(userUID)
                    userDataCabRef.child(guestUID!).setValue(NAString().gettrue())
                    
                    //Storing PostApproved Cabs
                    let replacedMessage = message?.replacingOccurrences(of: NAString().your_Cab_Numbered(), with: "")
                    let visitorRef = replacedMessage?.replacingOccurrences(of: NAString().wants_to_enter_Society(), with: "")
                    let cabNUmberRef = Constants.FIREBASE_CABS_ALL.child(visitorRef!)
                    cabNUmberRef.setValue(guestUID)
                    let postApprovedCabs = [
                        ArrivalListFBKeys.approvalType.key : Constants.FIREBASE_CHILD_POST_APPROVED,
                        ArrivalListFBKeys.dateAndTimeOfArrival.key : currentDate,
                        ArrivalListFBKeys.inviterUID.key : userUID,
                        ArrivalListFBKeys.reference.key : visitorRef,
                        ArrivalListFBKeys.status.key :NAString().entered(),
                        ArrivalListFBKeys.validFor.key : NAString()._2_hrs()
                    ]
                    postApprovedRef.setValue(postApprovedCabs)
                } else {
                    
                    //Mapping PackageUID with true
                    let userDataPackageRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_DELIVERIES).child(userUID)
                    userDataPackageRef.child(guestUID!).setValue(NAString().gettrue())
                    
                    //Storing PostApproved Packages
                    let replacedMessage = message?.replacingOccurrences(of: NAString().your_package_vendor(), with: "")
                    let visitorRef = replacedMessage?.replacingOccurrences(of: NAString().wants_to_enter_Society(), with: "")
                    let postApprovedPackages = [
                        ArrivalListFBKeys.approvalType.key : Constants.FIREBASE_CHILD_POST_APPROVED,
                        ArrivalListFBKeys.dateAndTimeOfArrival.key : currentDate,
                        ArrivalListFBKeys.inviterUID.key : userUID,
                        ArrivalListFBKeys.reference.key : visitorRef,
                        ArrivalListFBKeys.status.key :NAString().entered(),
                        ArrivalListFBKeys.validFor.key : NAString()._2_hrs()
                    ]
                    postApprovedRef.setValue(postApprovedPackages)
                }
                break
                
            //If Reject button will pressed
            case NAString().notificationRejectIdentifier():
                gateNotificationRef?.child(NAString().status()).setValue(NAString().rejected())
                break
                
            default:
                break
            }
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler()
    }
    
    //Notification action button function
    func setActionCategories(){
        let acceptAction = UNNotificationAction(
            identifier: NAString().notificationAcceptIdentifier(),
            title: NAString().accept().capitalized,
            options: [.init(rawValue: 0)])
        
        let rejectAction = UNNotificationAction(
            identifier: NAString().notificationRejectIdentifier(),
            title: NAString().reject().capitalized,
            options: [.init(rawValue: 0)])
        
        let actionCategory = UNNotificationCategory(
            identifier: NAString().notificationActionCategory(),
            actions: [acceptAction,rejectAction],
            intentIdentifiers: [],
            options: [.customDismissAction])
        
        UNUserNotificationCenter.current().setNotificationCategories(
            [actionCategory])
    }
    
    //Created delay function, so we can call our function after specific time.
    func delay(_ delay: Double, closure: @escaping() -> ()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    //This method will call when notification will recieved by the device.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        let userInfo = notification.request.content.userInfo
        
        //Getting guestUID & guestType from UserInfo & using it for setting values in firebase.
        let guestType = userInfo[Constants.FIREBASE_CHILD_VISITOR_TYPE] as? String
        let guestUID = userInfo[Constants.FIREBASE_CHILD_NOTIFICATION_UID] as? String
        
        //retrieving user’sFlat Details
        let userFlatDetails = Constants.FIREBASE_USERS_PRIVATE.child(userUID).child(Constants.FIREBASE_CHILD_FLATDETAILS)
        userFlatDetails.observeSingleEvent(of: .value) { (flatSnapshot) in
            
            //Getting Data Form Firebase & Adding into Model Class
            let userFlatData = flatSnapshot.value as? [String: AnyObject]
            
            let apartmentName = userFlatData?[UserFlatListFBKeys.apartmentName.key] as! String
            let city = userFlatData?[UserFlatListFBKeys.city.key] as! String
            let flatNumber = userFlatData?[UserFlatListFBKeys.flatNumber.key] as! String
            let societyName = userFlatData?[UserFlatListFBKeys.societyName.key] as! String
            
            if (guestUID != nil) && guestType != nil {
                
                let gateNotificationUserRef = Constants.FIREBASE_USERDATA_PRIVATE.child(city).child(societyName).child(apartmentName).child(flatNumber).child(Constants.FIREBASE_CHILD_GATE_NOTIFICATION).child(userUID)
                
                let gateNotificationRef = gateNotificationUserRef.child(guestType!).child(guestUID!)
                let gateNotificationStatusRef = gateNotificationUserRef.child(guestType!).child(guestUID!).child(Constants.FIREBASE_STATUS)
                
                //This deplay function we are calling to set ignored value in firebase, if user not accept & reject the E-Intercom Visitor.
                self.delay(30) {
                    
                   gateNotificationStatusRef.observeSingleEvent(of: .value, with: { (statusSnapshot) in
                        if !statusSnapshot.exists() {
                            center.removeAllDeliveredNotifications()
                            gateNotificationRef.child(NAString().status()).setValue(NAString().ignored())
                        }
                    })
                }
            }
        }
        
        //Calling Notification action button function
        setActionCategories()
        
        completionHandler(options)
    }
}
