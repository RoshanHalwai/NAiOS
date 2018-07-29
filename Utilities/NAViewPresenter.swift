//
//  NAViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 23/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAViewPresenter: NSObject {
    
    var storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    //OTP VC
    func otpViewController() -> OTPViewController {
        return storyBoard.instantiateViewController(withIdentifier: "otpVC") as! OTPViewController
    }
    
    //expecting cab arrival VC
    func expectingCabArrivalVC() -> ExpectingArrivalViewController {
        return storyBoard.instantiateViewController(withIdentifier: "expectingCabArrivalVC") as! ExpectingArrivalViewController
    }
    
    //Invite Visitor VC
    func inviteVisitorVC() -> InviteVisitorViewController {
        return storyBoard.instantiateViewController(withIdentifier: "inviteVisitorVC") as! InviteVisitorViewController
    }
    
    //Handed Things to my guest VC
    func handedThingsToMyGuestVC() -> HandedThingsToGuestViewController {
        return storyBoard.instantiateViewController(withIdentifier: "handedThingsToGuestVC") as! HandedThingsToGuestViewController
    }
    
    //Handed Things to my Daily services
    func handedThingsToMyDailyServiceVC() -> HandedThingsToDailyServicesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "handedThingsToServiceVC") as! HandedThingsToDailyServicesViewController
    }
    
    //Emeregency VC
    func raiseAlarmVC() -> RaiseAlarmViewController {
        return storyBoard.instantiateViewController(withIdentifier: "raiseEmergencyVC") as! RaiseAlarmViewController
    }
    
    //digi gate Vc
    func myVisitorsListVC() -> MyVisitorsListViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myVisitorsListVC") as! MyVisitorsListViewController
    }
    
    func myDailyServicesVC() -> MyDailyServicesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myDailyServicesVC") as! MyDailyServicesViewController
    }
    
    func myFamilyMembers() -> AddMyFamilyMembersViewController {
        return storyBoard.instantiateViewController(withIdentifier: "addMyFamilyMembers") as! AddMyFamilyMembersViewController
    }
    
    func notifyDigiGateVC() -> NotifyDigiGateViewController {
        return storyBoard.instantiateViewController(withIdentifier: "notifyDigiGateVC") as! NotifyDigiGateViewController
    }
    
    func mySweetHomeVC() -> MySweetHomeViewController {
        return storyBoard.instantiateViewController(withIdentifier: "mySweetHomeVC") as! MySweetHomeViewController
    }
    
    func emergencyVC() -> EmergencyViewController {
        return storyBoard.instantiateViewController(withIdentifier: "emergencyVC") as! EmergencyViewController
    }
    
    //my Visitors VC
    func myGuestListVC() -> MyGuestListViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myGuestListVC") as! MyGuestListViewController
    }
    
    //Cab and Package Arrival Card List VC
    func cabAndPackageArrivalListVC() -> CabAndPackageArrivalCardListViewController {
        return storyBoard.instantiateViewController(withIdentifier: "Cab&PackageCardListVC") as! CabAndPackageArrivalCardListViewController
    }
    
    //edit My Daily Services VC
    func editMyDailyServices() -> EditMyServicesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "editMyServicesVc") as! EditMyServicesViewController
    }
    
    //reschedule my visitor list
    func rescheduleMyVisitorVC() -> RescheduleMyGuestListViewController {
        return storyBoard.instantiateViewController(withIdentifier: "rescheduleMyVisitorVC") as! RescheduleMyGuestListViewController
    }
    
    func mainScreenVCID() -> String {
        return String("mainScreenVC")
    }
    
    func digiGateVCID() -> String {
        return String("digiGateVC")
    }
    
    func homeVCID() -> String {
        return String("homeVC")
    }
    
    func main() -> String {
        return String("Main")
    }
    
    func handedThingsHistoryVCID() -> String {
        return String("historyVC")
    }
    func loginNavigation() -> String {
        return String("NavLogin")
    }
    func mainNavigation() -> String {
        return String("NavMain")
    }
    
    func splashScreenRootVC() -> String {
        return String("rootVC")
    }
    
    //Digi Gate Vc
    func digiGateVC() -> DigitalGateViewController {
        return storyBoard.instantiateViewController(withIdentifier: "digiGateVC") as! DigitalGateViewController
    }
    
    //Add My Services VC
    func addMySerivesVC() -> AddMyServicesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyServicesViewController
    }
    
    //signup vc
    func signupVC() -> SignupViewController {
        return storyBoard.instantiateViewController(withIdentifier: "signupVC") as! SignupViewController
    }
    
    //myFlatDetailsVC
    func myFlatDEtailsVC() -> MyFlatDetailsViewController {
        return storyBoard.instantiateViewController(withIdentifier: "flatDetailsVC") as! MyFlatDetailsViewController
    }
    
    //Login VC
    func loginVC() -> LoginViewController {
        return storyBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
    }
    
    //Namma Apartments Home Screen
    func mainScreenVC() -> MainScreenViewController {
        return storyBoard.instantiateViewController(withIdentifier: "mainScreenVC") as! MainScreenViewController
    }
    
    //Guest History VC
    func handedThingsGuestHistoryVC() -> HandedThingsGuestHistoryViewController {
        return storyBoard.instantiateViewController(withIdentifier: "GuestHistoryVC") as! HandedThingsGuestHistoryViewController
    }
    
    //My Daily Service History VC
    func handedThingsServiceHistoryVC() -> HandedThingsDailyServicesHistoryViewController {
        return storyBoard.instantiateViewController(withIdentifier: "DailyServiceHistoryVC") as! HandedThingsDailyServicesHistoryViewController
    }
    //Navigation Menu Help Screen
    func helpVC() -> HelpViewController {
        return storyBoard.instantiateViewController(withIdentifier: "helpVC") as! HelpViewController
    }
    //Navigation Menu Settings Screen
    func settingsVC() -> SettingsViewController {
        return storyBoard.instantiateViewController(withIdentifier: "settingsVC") as! SettingsViewController
    }
    //Navigation Menu Notifications settings Screen
    func notificationSettingsVC() -> NotificationSettingsViewController {
        return storyBoard.instantiateViewController(withIdentifier: "notificationSettingsVC") as! NotificationSettingsViewController
    }
    //Navigation Menu General settings Screen
    func generalSettingsVC() -> GeneralSettingsViewController {
        return storyBoard.instantiateViewController(withIdentifier: "generalSettingsVC") as! GeneralSettingsViewController
    }
    //My Profile Screen
    func myProfileVC() -> EditMyProfileViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myProfileVC") as! EditMyProfileViewController
    }
    //Notice Board Screen
    func noticeBoardVC() -> NoticeBoardViewController {
        return storyBoard.instantiateViewController(withIdentifier: "noticeBoardVC") as! NoticeBoardViewController
    }
}