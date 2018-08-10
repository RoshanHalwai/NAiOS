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
    
    @IBOutlet weak var btn_SelectAny : UIButton?
    @IBOutlet weak var btn_Immediately : UIButton!
    @IBOutlet weak var btn_9AMto12PM : UIButton!
    @IBOutlet weak var btn_12PMto3PM : UIButton!
    @IBOutlet weak var btn_3PMto5PM : UIButton!
    @IBOutlet weak var btn_DryWaste : UIButton!
    @IBOutlet weak var btn_WetWaste : UIButton!
    @IBOutlet weak var btn_requestPlumber : UIButton!
    
    @IBOutlet weak var lbl_SelectProblem: UILabel!
    @IBOutlet weak var lbl_SelectSlot: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var garbageStackView: UIStackView!
    
    var nammaApartmentsSocietyServices = [NASocietyServices]()
    
    //Select slot array of buttons for color changing purpose
    var selectSlotbuttons : [UIButton] = []
    var isValidSelectSlotButtonClicked: [Bool] = []
    
    //To set navigation title & Screen title
    var navTitle : String?
    var plumberString : String?
    var carpenterString : String?
    var electricianString : String?
    var garbageString : String?
    var btn_Hour_String = String()
    var btn_problem = String()
    
    
    //Garbage array of buttons for color changing purpose
    var garbageButtons : [UIButton] = []
    var isValidgarbageButtonClicked: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_SelectAny?.titleLabel?.text = btn_problem
        
        //Hiding the StackView
        garbageStackView.isHidden = true
        
        //Adding Screen Titles
        plumberString = NAString().plumber()
        carpenterString = NAString().carpenter()
        electricianString = NAString().electrician()
        garbageString = NAString().garbage_management()
        
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
        historyButton.frame = CGRect(x: 0, y: 0, width: 34, height: 30)
        historyButton.addTarget(self, action: #selector(gotoSocietyServiceHistoryVC), for: .touchUpInside)
        let history = UIBarButtonItem(customView: historyButton)
        self.navigationItem.setRightBarButtonItems([history], animated: true)
    }
    
    //To Navigate to Society Service History VC
    @objc func gotoSocietyServiceHistoryVC() {
        let dv = NAViewPresenter().societyServiceHistoryVC()
        dv.titleName = NAString().history().capitalized
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    //Create Changing the Button Titles Function
    func changingButtonTitles() {
        if (navTitle == plumberString) {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: "PLUMBER"), for: .normal)
        } else if (navTitle == carpenterString) {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: "CARPENTER"), for: .normal)
        } else if (navTitle == electricianString) {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: "ELECTRICIAN"), for: .normal)
        } else {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: "GARBAGE"), for: .normal)
        }
    }
    
    //Create Changing the SelectAny Button Titles Function
    func changingSelectAnyButtonTitles() {
        if (navTitle == garbageString) {
            btn_SelectAny?.isHidden = true
            garbageStackView.isHidden = false
        } else {
            garbageStackView.isHidden = true
        }
    }
    
    //Create Changing the Label Select Problem Titles Function
    func changingLabelSelectProblemTitles() {
        if (navTitle == plumberString) {
            lbl_SelectProblem.text = NAString().selectProblem()
        } else if (navTitle == carpenterString) {
            lbl_SelectProblem.text = NAString().selectProblem()
        } else if (navTitle == electricianString) {
            lbl_SelectProblem.text = NAString().selectProblem()
        } else {
            lbl_SelectProblem.text = NAString().collectGarbage(name: "Select")
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
        self.btn_SelectAny?.titleLabel?.text = btn_problem
    }
    
    //MARK : Create Button Actions
    
    //Create Button SelectSlot Function
    @IBAction func btnSelectSlotFunction(_ sender: UIButton) {
        btn_Hour_String = (sender.titleLabel?.text)!
        selectedColor(tag: sender.tag)
    }
    //Create Button garbage Function
    @IBAction func btnSelectGarbageFunction(_ sender: UIButton) {
        selectedGarbageColor(tag: sender.tag)
    }
    //Calling SelectAny Button Function
    @IBAction func btn_selectAnyOneAction() {
        let searchVC = self.storyboard!.instantiateViewController(withIdentifier: "societyServiceTableVC") as! SocietyTableViewController
        let nav : UINavigationController = UINavigationController(rootViewController: searchVC)
        searchVC.navigationTitle = NAString().selectAnyProblem()
        if (navTitle == plumberString) {
            searchVC.titleString = plumberString
        } else if (navTitle == carpenterString) {
            searchVC.titleString = carpenterString
        } else {
            searchVC.titleString = electricianString
        }
        searchVC.societyServiceVC = self
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }
    //Create request Plumber Button Action
    @IBAction func btn_requestPlumberAction() {
        storeSocietyServiceDetails()
        let lv = NAViewPresenter().societyServiceDataVC()
        lv.navTitle = NAString().societyService()
        if (navTitle == plumberString) {
            lv.titleString = plumberString
        } else if (navTitle == carpenterString) {
            lv.titleString = carpenterString
        } else if (navTitle == electricianString) {
            lv.titleString = electricianString
        } else {
            lv.titleString = garbageString
        }
        self.navigationController?.pushViewController(lv, animated: true)
    }
}

extension SocietyServicesViewController {
    
    //Storing User requests of Society service Problems
    func storeSocietyServiceDetails() {
        let societyServiceNotificationRef = Database.database().reference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION).child(Constants.FIREBASE_USER_CHILD_ALL)
        let notificationUID: String
        notificationUID = societyServiceNotificationRef.childByAutoId().key
        let userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION)
        userDataRef.child((navTitle?.lowercased())!).child(notificationUID).setValue(NAString().gettrue())
        
        let societyServiceNotificationData = [
            NASocietyServicesFBKeys.problem.key : btn_problem,
            NASocietyServicesFBKeys.timeSlot.key : btn_Hour_String,
            NASocietyServicesFBKeys.userUID.key: userUID,
            NASocietyServicesFBKeys.societyServiceType.key : navTitle?.lowercased(),
            NASocietyServicesFBKeys.notificationUID.key : notificationUID,
            NASocietyServicesFBKeys.status.key : NAString().in_Progress()]
        
        societyServiceNotificationRef.child(notificationUID).setValue(societyServiceNotificationData)
        
        //Storing Current System time in milli seconds for time stamp.
        societyServiceNotificationRef.child(notificationUID).child(Constants.FIREBASE_CHILD_TIMESTAMP).setValue(Int64(Date().timeIntervalSince1970 * 1000))
    }
}
