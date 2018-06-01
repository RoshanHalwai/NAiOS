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
    
    //expecting package arrival VC
    func expectingPackageArrivalVC() -> ExpectingPackageArrivalViewController {
        return storyBoard.instantiateViewController(withIdentifier: "expectingPackageArrivalVC") as! ExpectingPackageArrivalViewController
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
    
    func myVisitorListVC() -> MyVisitorListViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myVisitorListVC") as! MyVisitorListViewController
    }
    
    func myDailyServicesVC() -> MyDailyServicesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myDailyServicesVC") as! MyDailyServicesViewController
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
    
    //edit My Daily Services VC
    
    func editMyDailyServices() -> EditMyServicesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "editMyServicesVc") as! EditMyServicesViewController
    }
    
    //reschedule my visitor list
    func rescheduleMyVisitorVC() -> RescheduleMyVisitorListViewController {
        return storyBoard.instantiateViewController(withIdentifier: "rescheduleMyVisitorVC") as! RescheduleMyVisitorListViewController
    }
    
    func mainScreenVCID() -> String {
        return String("mainScreenVC")
    }
    
    
}
