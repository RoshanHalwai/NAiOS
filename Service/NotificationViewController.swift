//
//  NotificationViewController.swift
//  NotificationServiceExtension
//
//  Created by Vikas Nayak on 30/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase

class NotificationViewController: NANavigationViewController {

    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    var guestType = String()
    var guestUID = String()
    var profilePhoto = String()
    var mobileNumber = String()
    var message = String()
    var useruid = String()
    var visitorType = String()
    var gateNotificationRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guestPref = UserDefaults.standard
        guestType = guestPref.object(forKey: Constants.NOTIFICATION_GUEST_TYPE) as! String
        guestUID = guestPref.object(forKey: Constants.NOTIFICATION_GUEST_UID) as! String
        profilePhoto = guestPref.object(forKey: Constants.NOTIFICATION_GUEST_PROFILE_PHOTO) as! String
        mobileNumber = guestPref.object(forKey: Constants.NOTIFICATION_GUEST_MOBILE_NUMBER) as! String
        message = guestPref.object(forKey: Constants.NOTIFICATION_GUEST_MESSAGE) as! String
        useruid = guestPref.object(forKey: Constants.FIREBASE_USERUID) as! String
        guestPref.synchronize()
        
        //assigning & setting UILabel
        self.msgLabel.font = NAFont().textFieldFont()
        self.msgLabel.text = message
        
        //creating image round
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2
        imageView.clipsToBounds = true
        
        //cardview
        NAShadowEffect().shadowEffectForView(view: self.cardView)
        
        //Settimg & formatting buttons
        self.btnAccept.setTitle(NAString().accept().uppercased(), for: .normal)
        self.btnReject.setTitle(NAString().reject().uppercased(), for: .normal)
        
        self.btnAccept.titleLabel?.font = NAFont().buttonFont()
        self.btnAccept.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btnAccept.backgroundColor = NAColor().buttonBgColor()
        
        self.btnReject.titleLabel?.font = NAFont().buttonFont()
        self.btnReject.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btnReject.backgroundColor = NAColor().buttonBgColor()
       
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setIndicatorStyle(.gray)
        
        guestPref.removeObject(forKey: Constants.NOTIFICATION_GUEST_TYPE)
        guestPref.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Checking Users UID in Firebase under Users ->Private
        let usersPrivateRef = Constants.FIREBASE_USERS_PRIVATE.child(useruid)
        //Checking userData inside Users/Private
        usersPrivateRef.observe(.value, with: { (snapshot) in
            //If usersUID is Exists then retrievd all the data of user.
            if snapshot.exists() {
                let userData = snapshot.value as? NSDictionary
                
                //Retrieving & Adding data in Flat Detail Class
                let flatdetails_data = userData![Constants.FIREBASE_CHILD_FLATDETAILS] as? [String :Any]
                let userFlatDetails = UserFlatDetails.init(
                    apartmentName: flatdetails_data![Constants.FIREBASE_CHILD_APARTMENT_NAME] as? String,
                    city: (flatdetails_data![Constants.FIREBASE_CHILD_CITY] as! String),
                    flatNumber: flatdetails_data![Constants.FIREBASE_CHILD_FLATNUMBER] as? String,
                    societyName: flatdetails_data![Constants.FIREBASE_CHILD_SOCIETY_NAME] as? String,
                    tenantType: flatdetails_data![Constants.FIREBASE_CHILD_TENANT_TYPE] as? String)
                flatDetailsFB.append(userFlatDetails)
                GlobalUserData.shared.flatDetails_Items = flatDetailsFB
                
                //Created Firebase reference to get currently invited visitor by E-Intercom
                self.gateNotificationRef = GlobalUserData.shared.getUserDataReference()
                    .child(Constants.FIREBASE_CHILD_GATE_NOTIFICATION)
                    .child(self.useruid).child(self.guestType).child(self.guestUID)
                
                switch self.guestType {
                case Constants.FIREBASE_CHILD_GUESTS:
                    //Retrieving Image
                    self.imageView.sd_setImage(with: URL(string: self.profilePhoto), completed: nil)
                    self.visitorType = Constants.FIREBASE_CHILD_VISITORS
                    break
                case Constants.FIREBASE_CHILD_CABS:
                    self.visitorType = Constants.FIREBASE_CHILD_CABS
                    self.imageView.image = UIImage(named: "ExpectingCabs")
                    break
                default:
                    self.visitorType = Constants.FIREBASE_CHILD_DELIVERIES
                    self.imageView.image = UIImage(named: "ExpectingPackage")
                    break
                }
            }
        })
    }
    
    @IBAction func btnAccepted(_ sender: UIButton) {
        gateNotificationRef?.child(NAString().status()).setValue(NAString().accepted())
        storingDataInFirebase()
        navigateBackToHomeScreen()
    }
    
    func storingDataInFirebase() {
        let postApprovedRef = Constants.FIREBASE_DATABASE_REFERENCE
            .child(visitorType).child(Constants.FIREBASE_CHILD_PRIVATE)
            .child(guestUID)
        
        //Getting Current Date and Time when User clicked on Accept
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = NAString().current_Date_Format()
        let currentDate = formatter.string(from: date)
        
        switch visitorType {
        case Constants.FIREBASE_CHILD_VISITORS:
            //Mapping GuestUID with true
            let userDataGuestRef = GlobalUserData.shared.getUserDataReference()
                .child(Constants.FIREBASE_CHILD_VISITORS).child(useruid)
            userDataGuestRef.child(guestUID).setValue(NAString().gettrue())
            
            let guestMobileRef = Constants.FIREBASE_VISITORS_ALL.child(mobileNumber)
            guestMobileRef.setValue(guestUID)
            //Storing Post Approved Guests
            let replacedMessage = message.replacingOccurrences(of: NAString().your_Guest(), with: "")
            let visitorRef = replacedMessage.replacingOccurrences(of: NAString().wants_to_enter_Society(), with: "")
            let postApprovedGuestsData = [
                VisitorListFBKeys.approvalType.key : Constants.FIREBASE_CHILD_POST_APPROVED,
                VisitorListFBKeys.uid.key : guestUID,
                VisitorListFBKeys.dateAndTimeOfVisit.key : currentDate,
                VisitorListFBKeys.status.key : NAString().entered(),
                VisitorListFBKeys.fullName.key : visitorRef,
                VisitorListFBKeys.inviterUID.key : useruid,
                VisitorListFBKeys.profilePhoto.key : profilePhoto,
                VisitorListFBKeys.mobileNumber.key : mobileNumber
            ]
            postApprovedRef.setValue(postApprovedGuestsData)
            break
            
        case Constants.FIREBASE_CHILD_CABS:
            
            //Mapping CabUID with true
            let userDataCabRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_CABS).child(useruid)
            userDataCabRef.child(guestUID).setValue(NAString().gettrue())
            
            //Storing PostApproved Cabs
            let replacedMessage = message.replacingOccurrences(of: NAString().your_Cab_Numbered(), with: "")
            let visitorRef = replacedMessage.replacingOccurrences(of: NAString().wants_to_enter_Society(), with: "")
            let cabNUmberRef = Constants.FIREBASE_CABS_ALL.child(visitorRef)
            cabNUmberRef.setValue(guestUID)
            let postApprovedCabs = [
                ArrivalListFBKeys.approvalType.key : Constants.FIREBASE_CHILD_POST_APPROVED,
                ArrivalListFBKeys.dateAndTimeOfArrival.key : currentDate,
                ArrivalListFBKeys.inviterUID.key : useruid,
                ArrivalListFBKeys.reference.key : visitorRef,
                ArrivalListFBKeys.status.key :NAString().entered(),
                ArrivalListFBKeys.validFor.key : NAString()._2_hrs()
            ]
            postApprovedRef.setValue(postApprovedCabs)
            break
        default:
            //Mapping PackageUID with true
            let userDataPackageRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_DELIVERIES).child(useruid)
            userDataPackageRef.child(guestUID).setValue(NAString().gettrue())
            
            //Storing PostApproved Packages
            let replacedMessage = message.replacingOccurrences(of: NAString().your_package_vendor(), with: "")
            let visitorRef = replacedMessage.replacingOccurrences(of: NAString().wants_to_enter_Society(), with: "")
            let postApprovedPackages = [
                ArrivalListFBKeys.approvalType.key : Constants.FIREBASE_CHILD_POST_APPROVED,
                ArrivalListFBKeys.dateAndTimeOfArrival.key : currentDate,
                ArrivalListFBKeys.inviterUID.key : useruid,
                ArrivalListFBKeys.reference.key : visitorRef,
                ArrivalListFBKeys.status.key :NAString().entered(),
                ArrivalListFBKeys.validFor.key : NAString()._2_hrs()
            ]
            postApprovedRef.setValue(postApprovedPackages)
        }
    }
    
    @IBAction func btnReject(_ sender: UIButton) {
        gateNotificationRef?.child(NAString().status())
            .setValue(NAString().rejected())
        navigateBackToHomeScreen()
    }
    
    func navigateBackToHomeScreen() {
        let notificationVC = self.storyboard?.instantiateViewController(withIdentifier: NAViewPresenter().mainNavigation())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = notificationVC
        appDelegate.window?.makeKeyAndVisible()
    }
}
