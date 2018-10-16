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
    
    func welcomeVC() -> String {
        return String("activationVC")
    }
    
    func welcomeRootVC() -> String {
        return String("activationRootVC")
    }
    
    func noticeBoardScreen() -> String {
        return String("noticeBoard")
    }
    
    func rootVC() -> String {
        return String("RootVC")
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
    func settingVC() -> SettingViewController {
        return storyBoard.instantiateViewController(withIdentifier: "settingVC") as! SettingViewController
    }
    //My Profile Screen
    func myProfileVC() -> EditMyProfileViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myProfileVC") as! EditMyProfileViewController
    }
    //Notice Board Screen
    func noticeBoardVC() -> NoticeBoardViewController {
        return storyBoard.instantiateViewController(withIdentifier: "noticeBoardVC") as! NoticeBoardViewController
    }
    
    //Create Society Service Plumber Screen
    func societyServiceVC() -> SocietyServicesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "societyServiceVC") as! SocietyServicesViewController
    }
    
    //Create Society Service TableView Screen
    func societyServiceTableVC() -> SocietyTableViewController {
        return storyBoard.instantiateViewController(withIdentifier: "societyServiceTableVC") as! SocietyTableViewController
    }
    
    //Create Society Service History Screen
    func societyServiceHistoryVC() -> SocietyHistoryViewController {
        return storyBoard.instantiateViewController(withIdentifier: "societyServiceHistoryVC") as! SocietyHistoryViewController
    }
    
    //Create Society Service Data Screen
    func societyServiceDataVC() -> AwaitingResponseViewController {
        return storyBoard.instantiateViewController(withIdentifier: "awaitingResponseVC") as! AwaitingResponseViewController
    }
    
    //Create Apartment Service Cook Screen
    func apartmentServiceCookVC() -> ApartmentServicesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "apartmentServiceCookVC") as! ApartmentServicesViewController
    }
    
    //Create My Vehicles Screen
    func myVehiclesVC() -> MyVehiclesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myVehiclesVC") as! MyVehiclesViewController
    }
    
    //Create My Guards Screen
    func myGuardsVC() -> MyGuardsViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myGuardsVC") as! MyGuardsViewController
    }
    
    //Create Add My Vehicles Screen
    func addMyVehiclesVC() -> AddMyVehiclesViewController {
        return storyBoard.instantiateViewController(withIdentifier: "addMyVehiclesVC") as! AddMyVehiclesViewController
    }
    
    //Create Event Mnagement Screen
    func addEventManagementVC() -> EventManagementViewController {
        return storyBoard.instantiateViewController(withIdentifier: "addEventManagementVC") as! EventManagementViewController
    }
    
    func showEventManagementVC() -> EventManagementCardViewController {
        return storyBoard.instantiateViewController(withIdentifier: "showEventManagementVC") as! EventManagementCardViewController
    }
    
    //Create My Wallet screen
    func myWalletVC() -> MyWalletViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myWalletVC") as! MyWalletViewController
    }
    
    func activationRequiredVC() -> ActivationRequired {
        return storyBoard.instantiateViewController(withIdentifier: "activationVC") as! ActivationRequired
    }
    
    func contactUs() -> ContactUsViewController {
        return storyBoard.instantiateViewController(withIdentifier: "ContactUs") as! ContactUsViewController
    }
    
    func myTransactionVC() -> MyTransactionsViewController {
        return storyBoard.instantiateViewController(withIdentifier: "MyTransactionsVC") as! MyTransactionsViewController
    }
    
    func contactUsHistoryVC() -> ContactUsHistoryViewController {
        return storyBoard.instantiateViewController(withIdentifier: "contactUsHistoryVC") as! ContactUsHistoryViewController
    }
    
    //Create My Food screen
    func myFoodVC() -> MyFoodViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myFoodVC") as! MyFoodViewController
    }
    
    //Create Donate Food History screen
    func donateFoodHistoryVC() -> DonateFoodHistoryViewController {
        return storyBoard.instantiateViewController(withIdentifier: "donateFoodHistoryVC") as! DonateFoodHistoryViewController
    }
    
    //Create Event Management History screen
    func eventManagementHistoryVC() -> EventManagementHistoryViewController {
        return storyBoard.instantiateViewController(withIdentifier: "eventManagementHistoryVC") as! EventManagementHistoryViewController
    }
    
    //Create My Neighbours screen
    func myNeighboursVC() -> MyNeighboursViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myNeighboursVC") as! MyNeighboursViewController
    }
    
    //Create My Gate Pass screen
    func myGatePassVC() -> MyGatePassViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myGatePassVC") as! MyGatePassViewController
    }
    
    func sendMessageVC() -> SendMessageViewController {
        return storyBoard.instantiateViewController(withIdentifier: "sendMessageVC") as! SendMessageViewController
    }
    
    func transactionSummaryVC() -> TransactionSummaryViewController {
        return storyBoard.instantiateViewController(withIdentifier: "transactionSummaryVC") as! TransactionSummaryViewController
    }
    
    func myProfileDataVC() -> MyProfileDataViewController {
        return storyBoard.instantiateViewController(withIdentifier: "myProfileDataVC") as! MyProfileDataViewController
    }
}
