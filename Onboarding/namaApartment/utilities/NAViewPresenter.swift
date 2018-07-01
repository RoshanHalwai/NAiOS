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
    func expectingCabArrivalVC() -> ExpectingCabArrivalViewController {
        return storyBoard.instantiateViewController(withIdentifier: "expectingCabArrivalVC") as! ExpectingCabArrivalViewController
    }
    
    //Invite Visitor VC
    func inviteVisitorVC() -> InviteVisitorViewController {
        return storyBoard.instantiateViewController(withIdentifier: "inviteVisitorVC") as! InviteVisitorViewController
    }
    
    //Handed Things to my guest VC
    func handedThingsToMyGuestVC() -> HandedThingsToGuestViewController {
        return storyBoard.instantiateViewController(withIdentifier: "handedThingsToGuestVC") as! HandedThingsToGuestViewController
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
    func cabArrivalListVC() -> CabArrivalViewController {
        return storyBoard.instantiateViewController(withIdentifier: "cabArrivalsVC") as! CabArrivalViewController
    }
    func packageArrivalListVC() -> PackageArrivalViewController {
        return storyBoard.instantiateViewController(withIdentifier: "packageArrivalVC") as! PackageArrivalViewController
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
    //Digi Gate Vc
    func digiGateVC() -> DigitalGateViewController {
        return storyBoard.instantiateViewController(withIdentifier: "digiGateVC") as! DigitalGateViewController
    }
    //Add My Services VC
    func addMySerivesVC() -> AddMyServicesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyServicesViewController
    }
    //signup vc
    func signupVC() -> signupViewController {
        return storyBoard.instantiateViewController(withIdentifier: "signupVC") as! signupViewController
    }
}
