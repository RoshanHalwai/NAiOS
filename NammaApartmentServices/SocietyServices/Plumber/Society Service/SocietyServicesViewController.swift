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
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var garbageStackView: UIStackView!
    
    var nammaApartmentsSocietyServices = [NASocietyServices]()
    var notificationUID = String()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getButtonHour_Text = NAString().immediately()
        getButtonGarbage_Problem_Text = NAString().dryWaste()
        
        self.txt_SelectAny.text = selectedProblem
        txt_SelectAny.underlined()
        txt_SelectAny.inputView = UIView()
        txt_SelectAny.delegate = self
        txt_SelectAny.font = NAFont().textFieldFont()
        
        lbl_ErrorValidation_Message.font = NAFont().descriptionFont()
        lbl_ErrorValidation_Message.isHidden = true
        
        //Hiding the StackView
        garbageStackView.isHidden = true
        
        //Passing NavigationBar Title
        super.ConfigureNavBarTitle(title: navTitle!)        
        
        //Label formatting & setting
        lbl_SelectSlot.text = NAString().selectSlot()
        
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
        
        //button Formatting & setting
        btn_Immediately.setTitle(NAString().immediately(), for: .normal)
        btn_9AMto12PM.setTitle(NAString()._9AM_12PM(), for: .normal)
        btn_12PMto3PM.setTitle(NAString()._12PM_3PM(), for: .normal)
        btn_3PMto5PM.setTitle(NAString()._3PM_5PM(), for: .normal)
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
        self.selectedGarbageColor(tag: btn_DryWaste.tag)
        
        //Calling Button Titles Functions
        self.changingButtonTitles()
        self.changingSelectAnyButtonTitles()
        self.changingLabelSelectProblemTitles()
        
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

    }
    
    // Navigate to FAQ's VC
    @objc override func gotofrequentlyAskedQuestionsVC() {
        let faqVC = NAViewPresenter().frequentlyAskedHelpVC()
        faqVC.navTitle = NAString().faqs()
        switch navTitle {
        case NAString().plumber():
            faqVC.plumberScreen = true
        case NAString().carpenter():
            faqVC.carpenterScreen = true
        case NAString().electrician():
            faqVC.electricianScreen = true
        case NAString().garbage_management():
            faqVC.garbageManagementScreen = true
        default:
            break
        }
        self.navigationController?.pushViewController(faqVC, animated: true)
    }
    
    //To Navigate to Society Service History VC
    @objc func gotoSocietyServiceHistoryVC() {
        let dv = NAViewPresenter().societyServiceHistoryVC()
        dv.titleName = NAString().history().capitalized
        if navTitle == NAString().garbage_management() {
            dv.navigationTitle = NAString().garbageManagement()
        } else {
            dv.navigationTitle = navTitle!.lowercased()
        }
        self.navigationController?.pushViewController(dv, animated: true)
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
        if (navTitle == NAString().garbage_management()) {
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
        } else {
            lbl_SelectProblem.text = NAString().collectGarbage()
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
        self.txt_SelectAny.text = selectedProblem
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
        selectedGarbageColor(tag: sender.tag)
    }
    //Calling SelectAny Button Function
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        lbl_ErrorValidation_Message.isHidden = true
        txt_SelectAny.underlined()
        let searchVC = NAViewPresenter().societyServiceTableVC()
        let nav : UINavigationController = UINavigationController(rootViewController: searchVC)
        searchVC.navigationTitle = NAString().selectAnyProblem()
        if (navTitle == NAString().plumber()) {
            searchVC.titleString = NAString().plumber()
        } else if (navTitle == NAString().carpenter()) {
            searchVC.titleString = NAString().carpenter()
        } else {
            searchVC.titleString = NAString().electrician()
        }
        searchVC.societyServiceVC = self
        self.navigationController?.present(nav, animated: true, completion: nil)
        return true
    }
    
    //Create request Plumber Button Action
    @IBAction func btn_requestPlumberAction() {
        if navTitle == NAString().garbage_management() {
            storeSocietyServiceDetails()
        } else {
            if (txt_SelectAny.text?.isEmpty)! {
                txt_SelectAny.redunderlined()
                lbl_ErrorValidation_Message.isHidden = false
            } else {
                lbl_ErrorValidation_Message.isHidden = true
                storeSocietyServiceDetails()
            }
        }
    }
}

extension SocietyServicesViewController {
    
    //Storing User requests of Society service Problems
    func storeSocietyServiceDetails() {
        
        var problem = String()
        var serviceType = String()
        if (navTitle == NAString().garbage_management()) {
            problem = getButtonGarbage_Problem_Text
            serviceType = NAString().garbageManagement()
        } else {
            problem = selectedProblem
            serviceType = (navTitle?.lowercased())!
        }
        let societyServiceNotificationRef = Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL
        notificationUID = societyServiceNotificationRef.childByAutoId().key
        let userDataRef = Constants.FIREBASE_USERDATA_SOCIETY_SERVICES_NOTIFICATION
        userDataRef.child(serviceType).child(notificationUID).setValue(NAString().gettrue())
        
        let societyServiceNotificationData = [
            NASocietyServicesFBKeys.problem.key : problem,
            NASocietyServicesFBKeys.timeSlot.key : getButtonHour_Text,
            NASocietyServicesFBKeys.userUID.key: userUID,
            NASocietyServicesFBKeys.societyServiceType.key : serviceType,
            NASocietyServicesFBKeys.notificationUID.key : notificationUID,
            NASocietyServicesFBKeys.status.key : NAString().in_Progress()]
        
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
            lv.titleString = NAString().plumber()
        } else if (navTitle == NAString().carpenter()) {
            lv.titleString = NAString().carpenter()
        } else if (navTitle == NAString().electrician()) {
            lv.titleString = NAString().electrician()
        } else {
            lv.titleString = NAString().garbage_management()
        }
        self.navigationController?.pushViewController(lv, animated: true)
    }
}
