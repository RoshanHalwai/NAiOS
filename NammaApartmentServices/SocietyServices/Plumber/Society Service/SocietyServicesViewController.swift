//
//  SocietyServicesViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/2/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SocietyServicesViewController: NANavigationViewController {
    
    @IBOutlet weak var txt_SelectAny: UITextField!
    @IBOutlet weak var txt_Others: UITextField!
    @IBOutlet weak var btn_Immediately : UIButton!
    @IBOutlet weak var btn_9AMto12PM : UIButton!
    @IBOutlet weak var btn_12PMto3PM : UIButton!
    @IBOutlet weak var btn_3PMto5PM : UIButton!
    @IBOutlet weak var btn_DryWaste : UIButton!
    @IBOutlet weak var btn_WetWaste : UIButton!
    @IBOutlet weak var btn_requestPlumber : UIButton!
    
    @IBOutlet weak var lbl_SelectProblem: UILabel!
    @IBOutlet weak var lbl_SelectSlot: UILabel!
    @IBOutlet weak var lbl_ErrorValidation_Message: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_CheckList_SelectProblem: UILabel!
    @IBOutlet weak var lbl_CheckList_SelectSlot: UILabel!
    @IBOutlet weak var lbl_CheckList_RequestService: UILabel!
    @IBOutlet weak var lbl_CheckList_FreeService: UILabel!
    @IBOutlet weak var lbl_DescrptionErrorValidation_Message: UILabel!
    
    @IBOutlet weak var lbl_Garbage_Type_Error_Validation: UILabel!
    @IBOutlet weak var checkList_CardView: UIView!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var garbageStackView: UIStackView!
    @IBOutlet weak var othersStackView: UIStackView!
    @IBOutlet weak var societyStackView: UIStackView!
    @IBOutlet weak var availableStackView: UIStackView!
    
    @IBOutlet weak var lbl_available: UILabel!
    @IBOutlet weak var lbl_unAvailable: UILabel!
    
    var nammaApartmentsSocietyServices = [NASocietyServices]()
    var notificationUID = String()
    var problem = String()
    
    //Select slot array of buttons for color changing purpose
    var selectSlotbuttons : [UIButton] = []
    var isValidSelectSlotButtonClicked: [Bool] = []
    
    //To set navigation title & Screen title
    var navTitle : String?
    var getButtonHour_Text = String()
    var selectedProblem = String()
    var getButtonGarbage_Problem_Text = String()
    
    //Garbage array of buttons for color changing purpose
    var garbageButtons : [UIButton] = []
    var isValidgarbageButtonClicked: [Bool] = []
    
    //A boolean variable to indicate if previous screen was Expecting.
    var fromSocietyServiceVC = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NAShadowEffect().shadowEffectForView(view: checkList_CardView)
        
        //Create textfield first letter capital
        txt_Others.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        if (navTitle == NAString().scrapCollection()) {
            getButtonHour_Text = NAString()._0_5Kg()
        } else {
            getButtonHour_Text = NAString().immediately()
        }
        
        self.txt_SelectAny.text = selectedProblem
        
        self.view.layoutIfNeeded()
        txt_SelectAny.underlined()
        txt_Others.underlined()
        txt_SelectAny.delegate = self
        txt_Others.delegate = self
        txt_SelectAny.font = NAFont().textFieldFont()
        txt_Others.font = NAFont().textFieldFont()
        
        lbl_DescrptionErrorValidation_Message.text = NAString().please_enter_your_problem()
        lbl_unAvailable.text = NAString().unavailable()
        lbl_available.text = NAString().available()
        
        lbl_available.font = NAFont().descriptionFont()
        lbl_unAvailable.font = NAFont().descriptionFont()
        lbl_ErrorValidation_Message.font = NAFont().descriptionFont()
        lbl_DescrptionErrorValidation_Message.font = NAFont().descriptionFont()
        lbl_Garbage_Type_Error_Validation.font = NAFont().descriptionFont()
        lbl_ErrorValidation_Message.isHidden = true
        lbl_DescrptionErrorValidation_Message.isHidden = true
        lbl_Garbage_Type_Error_Validation.isHidden = true
        
        //Hiding the StackView
        garbageStackView.isHidden = true
        othersStackView.isHidden = true
        
        //Passing NavigationBar Title
        super.ConfigureNavBarTitle(title: navTitle!)        
        
        //lbl_Title.font = NAFont().headerFont()
        lbl_SelectProblem.font = NAFont().headerFont()
        lbl_SelectSlot.font = NAFont().headerFont()
        
        //for changing Select Slot buttons color
        selectSlotbuttons.removeAll()
        selectSlotbuttons.append(btn_Immediately)
        selectSlotbuttons.append(btn_9AMto12PM)
        selectSlotbuttons.append(btn_12PMto3PM)
        selectSlotbuttons.append(btn_3PMto5PM)
        
        //for changing Garbage buttons color
        garbageButtons.removeAll()
        garbageButtons.append(btn_DryWaste)
        garbageButtons.append(btn_WetWaste)
        
        btn_DryWaste.setTitle(NAString().dryWaste(), for: .normal)
        btn_WetWaste.setTitle(NAString().wetWaste(), for: .normal)
        
        //color set on selected
        btn_Immediately.setTitleColor(UIColor.black, for: .selected)
        btn_9AMto12PM.setTitleColor(UIColor.black, for: .selected)
        btn_12PMto3PM.setTitleColor(UIColor.black, for: .selected)
        btn_3PMto5PM.setTitleColor(UIColor.black, for: .selected)
        btn_DryWaste.setTitleColor(UIColor.black, for: .selected)
        btn_WetWaste.setTitleColor(UIColor.black, for: .selected)
        
        //Button Formatting & settings
        btn_requestPlumber?.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_requestPlumber?.backgroundColor = NAColor().buttonBgColor()
        btn_requestPlumber?.titleLabel?.font = NAFont().buttonFont()
        
        //set tag values to buttons
        btn_Immediately.tag = 1
        btn_9AMto12PM.tag = 2
        btn_12PMto3PM.tag = 3
        btn_3PMto5PM.tag = 4
        btn_DryWaste.tag = 5
        btn_WetWaste.tag = 6
        
        //make buttons rounded corner
        btn_Immediately.layer.cornerRadius = 15.0
        btn_9AMto12PM.layer.cornerRadius = 15.0
        btn_12PMto3PM.layer.cornerRadius = 15.0
        btn_3PMto5PM.layer.cornerRadius = 15.0
        btn_DryWaste.layer.cornerRadius = 15.0
        btn_WetWaste.layer.cornerRadius = 15.0
        
        //setting border width for buttons
        btn_Immediately.layer.borderWidth = 1
        btn_9AMto12PM.layer.borderWidth = 1
        btn_12PMto3PM.layer.borderWidth = 1
        btn_3PMto5PM.layer.borderWidth = 1
        btn_DryWaste.layer.borderWidth = 1
        btn_WetWaste.layer.borderWidth = 1
        
        //cardUIView
        cardView.layer.cornerRadius = 3
        cardView.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView.layer.shadowRadius = 1.7
        cardView.layer.shadowOpacity = 0.45
        
        //Calling Button Color Function
        self.selectedColor(tag: btn_Immediately.tag)
        
        //Calling Button Titles Functions
        self.changingButtonTitles()
        self.changingSelectAnyButtonTitles()
        self.changingLabelSelectProblemTitles()
        
        //Calling Label Titles Functions
        self.changingButtonsText()
        self.changingSelectLabelText()
        self.changingChecklistLabelText()
        self.changingLabelValidationMessageText()
        
        //Creating History icon on Navigation bar
        let historyButton = UIButton(type: .system)
        historyButton.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        historyButton.addTarget(self, action: #selector(gotoSocietyServiceHistoryVC), for: .touchUpInside)
        let history = UIBarButtonItem(customView: historyButton)
        //Creating info icon on Navigation bar
        let infoButton = UIButton(type: .system)
        infoButton.setImage(#imageLiteral(resourceName: "infoButton"), for: .normal)
        infoButton.addTarget(self, action: #selector(gotofrequentlyAskedQuestionsVC), for: .touchUpInside)
        let info = UIBarButtonItem(customView: infoButton)
        
        //created Array for history and info button icons
        self.navigationItem.setRightBarButtonItems([info,history], animated: true)
        
        //Checking current time and Disabling time slot buttons based on Current time.
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if navTitle != NAString().scrapCollection() {
            if hour >= 12 {
                btn_9AMto12PM.isUserInteractionEnabled = false
                btn_9AMto12PM.setTitleColor(UIColor.lightGray, for: .normal)
            }
            if hour >= 15 {
                btn_12PMto3PM.isUserInteractionEnabled = false
                btn_12PMto3PM.setTitleColor(UIColor.lightGray, for: .normal)
            }
            if hour >= 18 {
                btn_3PMto5PM.isUserInteractionEnabled = false
                btn_3PMto5PM.setTitleColor(UIColor.lightGray, for: .normal)
            }
        }
        
        //created custom back button for goto My DigiGate
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToDigitGate))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //Navigating Back to digi gate according to Screen coming from
    @objc func goBackToDigitGate() {
        if fromSocietyServiceVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-4]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // Navigate to FAQ's WebSite
    @objc override func gotofrequentlyAskedQuestionsVC() {
        UIApplication.shared.open(URL(string: NAString().faqWebsiteLink())!, options: [:], completionHandler: nil)
    }
    
    //To Navigate to Society Service History VC
    @objc func gotoSocietyServiceHistoryVC() {
        let dv = NAViewPresenter().societyServiceHistoryVC()
        dv.titleName = NAString().history().capitalized
        if navTitle == NAString().garbage_Collection() {
            dv.navigationTitle = NAString().garbageCollection()
        } else if navTitle == NAString().scrapCollection() {
            dv.navigationTitle = NAString().scrap_Collection()
        } else {
            dv.navigationTitle = navTitle!.lowercased()
        }
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    //Create Changing the Label Validation Message Text Function
    func changingLabelValidationMessageText() {
        if (navTitle == NAString().scrapCollection()) {
            lbl_ErrorValidation_Message.text = NAString().please_enter_your_scrapType()
        } else {
            lbl_ErrorValidation_Message.text = NAString().please_select_your_problem()
        }
    }
    
    //Create Changing the Checklist Label Text Function
    func changingChecklistLabelText() {
        if (navTitle == NAString().scrapCollection()) {
            lbl_CheckList_SelectProblem.text = NAString().selectScrapType()
            lbl_CheckList_SelectSlot.text = NAString().selectQuantity()
        } else {
            lbl_CheckList_SelectProblem.text = NAString().selectProblem()
            lbl_CheckList_SelectSlot.text = NAString().selectSlot()
            lbl_CheckList_RequestService.text = NAString().requestService()
            lbl_CheckList_FreeService.text = NAString().enjoyService()
        }
        
    }
    
    //Create Changing the Label Text Function
    func changingSelectLabelText() {
        if (navTitle == NAString().scrapCollection()) {
            availableStackView.isHidden = true
            lbl_SelectSlot.text = NAString().totalQuantity()
        } else {
            lbl_SelectSlot.text = NAString().selectSlot()
        }
    }
    
    //Create Changing the Buttons Text Function
    func changingButtonsText() {
        if (navTitle == NAString().scrapCollection()) {
            btn_Immediately.setTitle(NAString()._0_5Kg(), for: .normal)
            btn_9AMto12PM.setTitle(NAString()._5_10Kg(), for: .normal)
            btn_12PMto3PM.setTitle(NAString()._10_15Kg(), for: .normal)
            btn_3PMto5PM.setTitle(NAString()._15Plus(), for: .normal)
        } else {
            btn_Immediately.setTitle(NAString().immediately(), for: .normal)
            btn_9AMto12PM.setTitle(NAString()._9AM_12PM(), for: .normal)
            btn_12PMto3PM.setTitle(NAString()._12PM_3PM(), for: .normal)
            btn_3PMto5PM.setTitle(NAString()._3PM_5PM(), for: .normal)
        }
    }
    
    //Create Changing the Button Titles Function
    func changingButtonTitles() {
        if (navTitle == NAString().plumber()) {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: NAString().plumber().uppercased()), for: .normal)
        } else if (navTitle == NAString().carpenter()) {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: NAString().carpenter().uppercased()), for: .normal)
        } else if (navTitle == NAString().electrician()) {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: NAString().electrician().uppercased()), for: .normal)
        } else {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: ""), for: .normal)
        }
    }
    
    //Create Changing the SelectAny Button Titles Function
    func changingSelectAnyButtonTitles() {
        if (navTitle == NAString().garbage_Collection()) {
            txt_SelectAny.isHidden = true
            lbl_ErrorValidation_Message.isHidden = true
            garbageStackView.isHidden = false
        } else {
            garbageStackView.isHidden = true
        }
    }
    
    //Create Changing the Label Select Problem Titles Function
    func changingLabelSelectProblemTitles() {
        if (navTitle == NAString().plumber()) {
            lbl_SelectProblem.text = NAString().selectProblem()
        } else if (navTitle == NAString().carpenter()) {
            lbl_SelectProblem.text = NAString().selectProblem()
        } else if (navTitle == NAString().electrician()) {
            lbl_SelectProblem.text = NAString().selectProblem()
        } else if (navTitle == NAString().garbage_Collection()) {
            lbl_SelectProblem.text = NAString().collectGarbage()
        } else {
            lbl_SelectProblem.text = NAString().selectScrapType()
        }
    }
    
    //creating function to highlight select slot button color
    func selectedColor(tag: Int) {
        for button in selectSlotbuttons as [UIButton] {
            isValidSelectSlotButtonClicked = [true]
            if button.tag == tag {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
            let color = button.isSelected ? NAColor().buttonFontColor() : UIColor.white
            button.backgroundColor = color
            button.tintColor = color
        }
    }
    
    //creating function to highlight garbage button color
    func selectedGarbageColor(tag: Int) {
        for button in garbageButtons as [UIButton] {
            isValidgarbageButtonClicked = [true]
            if button.tag == tag {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
            let color = button.isSelected ? NAColor().buttonFontColor() : UIColor.white
            button.backgroundColor = color
            button.tintColor = color
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if selectedProblem.isEmpty {
            self.txt_SelectAny.text = ""
        } else {
            self.txt_SelectAny.text = selectedProblem
            selectedProblem = ""
            if (self.txt_SelectAny.text == NAString().others()) {
                othersStackView.isHidden = false
            } else {
                othersStackView.isHidden = true
            }
        }
    }
    
    //MARK : Create Button Actions
    
    //Create Button SelectSlot Function
    @IBAction func btnSelectSlotFunction(_ sender: UIButton) {
        getButtonHour_Text = (sender.titleLabel?.text)!
        selectedColor(tag: sender.tag)
    }
    //Create Button garbage Function
    @IBAction func btnSelectGarbageFunction(_ sender: UIButton) {
        getButtonGarbage_Problem_Text = (sender.titleLabel?.text)!
        lbl_Garbage_Type_Error_Validation.isHidden = true
        selectedGarbageColor(tag: sender.tag)
    }
    //Calling SelectAny Button Function
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if othersStackView.isHidden == true || !(txt_SelectAny.text?.isEmpty)! {
            if textField == txt_SelectAny {
                txt_SelectAny.inputView = UIView()
                lbl_ErrorValidation_Message.isHidden = true
                txt_SelectAny.underlined()
                let searchVC = NAViewPresenter().societyServiceTableVC()
                let nav : UINavigationController = UINavigationController(rootViewController: searchVC)
                searchVC.navigationTitle = NAString().selectAnyProblem()
                if (navTitle == NAString().plumber()) {
                    searchVC.titleString = NAString().plumber()
                } else if (navTitle == NAString().carpenter()) {
                    searchVC.titleString = NAString().carpenter()
                } else if (navTitle == NAString().electrician()) {
                    searchVC.titleString = NAString().electrician()
                } else {
                    searchVC.titleString = NAString().scrapCollection()
                }
                searchVC.societyServiceVC = self
                self.navigationController?.present(nav, animated: true, completion: nil)
                return true
            }
        } else {
            txt_Others.underlined()
            lbl_DescrptionErrorValidation_Message.isHidden = true
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txt_Others {
            txt_Others.underlined()
            lbl_DescrptionErrorValidation_Message.isHidden = true
        }
        return true
    }
    
    //Create textfield first letter capital function
    @objc func valueChanged(sender: UITextField) {
        sender.text = sender.text?.capitalized
    }
    
    //Create request Plumber Button Action
    @IBAction func btn_requestPlumberAction() {
        if navTitle == NAString().garbage_Collection() {
            if getButtonGarbage_Problem_Text.isEmpty {
                lbl_Garbage_Type_Error_Validation.isHidden = false
            } else {
                storeSocietyServiceDetails()
            }
        } else {
            if (txt_SelectAny.text?.isEmpty)! {
                txt_SelectAny.redunderlined()
                lbl_ErrorValidation_Message.isHidden = false
            } else {
                lbl_ErrorValidation_Message.isHidden = true
                txt_SelectAny.underlined()
            }
            if (txt_Others.text?.isEmpty)! {
                txt_Others.redunderlined()
                lbl_DescrptionErrorValidation_Message.isHidden = false
            } else {
                txt_Others.underlined()
                lbl_DescrptionErrorValidation_Message.isHidden = true
            }
            
            if othersStackView.isHidden == true {
                if !(txt_SelectAny.text?.isEmpty)! {
                    storeSocietyServiceDetails()
                }
            } else {
                if !(txt_Others.text?.isEmpty)! && !(txt_SelectAny.text?.isEmpty)! {
                    storeSocietyServiceDetails()
                }
            }
        }
    }
    
    //AlertView For navigation
    func inviteAlertView() {
        //creating alert controller
        let alert = UIAlertController(title: NAString().requestRaised() , message: NAString().scrapCollectionHistoryAlertTitle(), preferredStyle: .alert)
        //creating Accept alert actions
        let okAction = UIAlertAction(title:NAString().ok(), style: .default) { (action) in
            let scrapHistoryVC = NAViewPresenter().societyServiceHistoryVC()
            scrapHistoryVC.titleName = NAString().history()
            scrapHistoryVC.navigationTitle = NAString().scrap_Collection()
            self.navigationController?.pushViewController(scrapHistoryVC, animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension SocietyServicesViewController {
    
    //Storing User requests of Society service Problems
    func storeSocietyServiceDetails() {
        
       
        var serviceType = String()
        if (navTitle == NAString().garbage_Collection()) {
            problem = getButtonGarbage_Problem_Text
            serviceType = NAString().garbageCollection()
        } else if (navTitle == NAString().scrapCollection()) {
            problem = selectedProblem
            serviceType = NAString().scrap_Collection()
        } else {
            if (self.txt_SelectAny.text == NAString().others()) {
                problem = self.txt_Others.text!
            } else  {
                problem = txt_SelectAny.text!
            }
            serviceType = (navTitle?.lowercased())!
        }
        let societyServiceNotificationRef = Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL
        notificationUID = societyServiceNotificationRef.childByAutoId().key!
        let userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION)
        userDataRef.child(serviceType).child(notificationUID).setValue(NAString().gettrue())
        
        var problemOrScrapType = String()
        var timeSlotOrQuantity = String()
        var uidOrNotificationUID = String()
        
        if navTitle == NAString().scrapCollection() {
            problemOrScrapType = NASocietyServicesFBKeys.scrapType.key
            timeSlotOrQuantity = NASocietyServicesFBKeys.quantity.key
            uidOrNotificationUID = NASocietyServicesFBKeys.uid.key
        } else {
            problemOrScrapType = NASocietyServicesFBKeys.problem.key
            timeSlotOrQuantity = NASocietyServicesFBKeys.timeSlot.key
            uidOrNotificationUID = NASocietyServicesFBKeys.notificationUID.key
        }
        
        let societyServiceNotificationData = [
            problemOrScrapType : self.txt_SelectAny.text as Any,
            timeSlotOrQuantity : getButtonHour_Text,
            NASocietyServicesFBKeys.userUID.key: userUID,
            NASocietyServicesFBKeys.societyServiceType.key : serviceType,
            uidOrNotificationUID : notificationUID,
            NASocietyServicesFBKeys.status.key : NAString().in_Progress()] as [String : Any]
        
        societyServiceNotificationRef.child(notificationUID).setValue(societyServiceNotificationData) { (error, snapshot) in
            //Storing Current System time in milli seconds for time stamp.
            societyServiceNotificationRef.child(self.notificationUID).child(Constants.FIREBASE_CHILD_TIMESTAMP).setValue(Int64(Date().timeIntervalSince1970 * 1000), withCompletionBlock: { (error, snapshot) in
                self.callAwaitingResponseViewController()
            })
        }
    }
    
    func callAwaitingResponseViewController() {
        let lv = NAViewPresenter().societyServiceDataVC()
        lv.navTitle = NAString().societyService()
        lv.notificationUID = notificationUID
        if (navTitle == NAString().plumber()) {
            lv.serviceType = NAString().plumber()
            self.navigationController?.pushViewController(lv, animated: true)
        } else if (navTitle == NAString().carpenter()) {
            lv.serviceType = NAString().carpenter()
            self.navigationController?.pushViewController(lv, animated: true)
        } else if (navTitle == NAString().electrician()) {
            lv.serviceType = NAString().electrician()
            self.navigationController?.pushViewController(lv, animated: true)
        } else if (navTitle == NAString().garbage_Collection()) {
            lv.serviceType = NAString().garbage_Collection()
            self.navigationController?.pushViewController(lv, animated: true)
        } else {
            self.inviteAlertView()
            lv.serviceType = NAString().scrapCollection()
        }
    }
}
