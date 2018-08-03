//
//  SocietyServicesViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/2/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SocietyServicesViewController: NANavigationViewController,SelectProblemDelegate {
    
    @IBOutlet weak var btn_SelectAny : UIButton!
    @IBOutlet weak var btn_Immediately : UIButton!
    @IBOutlet weak var btn_9AMto12PM : UIButton!
    @IBOutlet weak var btn_12PMto3PM : UIButton!
    @IBOutlet weak var btn_3PMto5PM : UIButton!
    @IBOutlet weak var btn_requestPlumber : UIButton!
    
    @IBOutlet weak var lbl_SelectProblem: UILabel!
    @IBOutlet weak var lbl_SelectSlot: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    
    //array of buttons for color changing purpose
    var buttons : [UIButton] = []
    var isValidButtonClicked: [Bool] = []
    
    //To set navigation title & Screen title
    var navTitle : String?
    var plumberString : String?
    var carpenterString : String?
    var electricianString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding Screen Titles
        plumberString = NAString().plumber()
        carpenterString = NAString().carpenter()
        electricianString = NAString().electrician()
        
        //Passing NavigationBar Title
        super.ConfigureNavBarTitle(title: navTitle!)        
        
        //Label formatting & setting
        lbl_SelectProblem.text = NAString().selectProblem()
        lbl_SelectSlot.text = NAString().selectSlot()
        
        //lbl_Title.font = NAFont().headerFont()
        lbl_SelectProblem.font = NAFont().headerFont()
        lbl_SelectSlot.font = NAFont().headerFont()
        
        //for changing button color
        buttons.removeAll()
        buttons.append(btn_Immediately)
        buttons.append(btn_9AMto12PM)
        buttons.append(btn_12PMto3PM)
        buttons.append(btn_3PMto5PM)
        
        //button Formatting & setting
        btn_Immediately.setTitle(NAString().immediately(), for: .normal)
        btn_9AMto12PM.setTitle(NAString()._9AM_12PM(), for: .normal)
        btn_12PMto3PM.setTitle(NAString()._12PM_3PM(), for: .normal)
        btn_3PMto5PM.setTitle(NAString()._3PM_5PM(), for: .normal)
        
        //color set on selected
        btn_Immediately.setTitleColor(UIColor.black, for: .selected)
        btn_9AMto12PM.setTitleColor(UIColor.black, for: .selected)
        btn_12PMto3PM.setTitleColor(UIColor.black, for: .selected)
        btn_3PMto5PM.setTitleColor(UIColor.black, for: .selected)
        
        //Button Formatting & settings
        btn_requestPlumber?.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_requestPlumber?.backgroundColor = NAColor().buttonBgColor()
        btn_requestPlumber?.titleLabel?.font = NAFont().buttonFont()
        
        //set tag values to buttons
        btn_Immediately.tag = 1
        btn_9AMto12PM.tag = 2
        btn_12PMto3PM.tag = 3
        btn_3PMto5PM.tag = 4
        
        //make buttons rounded corner
        btn_Immediately.layer.cornerRadius = 15.0
        btn_9AMto12PM.layer.cornerRadius = 15.0
        btn_12PMto3PM.layer.cornerRadius = 15.0
        btn_3PMto5PM.layer.cornerRadius = 15.0
        
        //setting border width for buttons
        btn_Immediately.layer.borderWidth = 1
        btn_9AMto12PM.layer.borderWidth = 1
        btn_12PMto3PM.layer.borderWidth = 1
        btn_3PMto5PM.layer.borderWidth = 1
        
        //cardUIView
        cardView.layer.cornerRadius = 3
        cardView.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView.layer.shadowRadius = 1.7
        cardView.layer.shadowOpacity = 0.45
        
        //Calling Button Color Function
        self.selectedColor(tag: btn_Immediately.tag)
        
        //Calling Button Titles Function
        self.changingButtonTitles()
    }
    
    //Create Changing the Button Titles Function
    func changingButtonTitles() {
        if (navTitle == plumberString) {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: "PLUMBER"), for: .normal)
        } else if (navTitle == carpenterString) {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: "CARPENTER"), for: .normal)
        } else {
            btn_requestPlumber.setTitle(NAString().requestPlumber(name: "ELECTRICIAN"), for: .normal)
        }
    }
    
    //creating function to highlight select button color
    func selectedColor(tag: Int) {
        for button in buttons as [UIButton] {
            isValidButtonClicked = [true]
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
    
    //Calling SelectProblem Delegate Function
    func passingSelectString(name: String?) {
        btn_SelectAny.titleLabel?.text = name
    }
    
    //MARK : Create Button Actions
    //Create Button SelectSlot Function
    @IBAction func btnSelectSlotFunction(_ sender: UIButton) {
        selectedColor(tag: sender.tag)
    }
    //Calling SelectAny Button Function
    @IBAction func btn_selectAnyOneAction() {
        if (navTitle == plumberString) {
            let lv = NAViewPresenter().societyServiceTableVC()
            lv.navTitle = NAString().selectAnyProblem()
            lv.delegate = self
            lv.titleString = plumberString
            self.navigationController?.pushViewController(lv, animated: true)
        } else if (navTitle == carpenterString) {
            let lv = NAViewPresenter().societyServiceTableVC()
            lv.navTitle = NAString().selectAnyProblem()
            lv.delegate = self
            lv.titleString = carpenterString
            self.navigationController?.pushViewController(lv, animated: true)
        } else {
            let lv = NAViewPresenter().societyServiceTableVC()
            lv.navTitle = NAString().selectAnyProblem()
            lv.delegate = self
            self.navigationController?.pushViewController(lv, animated: true)
        }
    }
    //TODO : Need to add Functionality in future
    @IBAction func btn_requestPlumberAction() {
        
    }
}
