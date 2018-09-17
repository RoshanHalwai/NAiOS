//
//  MyFoodViewController.swift
//  nammaApartment
//
//  Created by kalpana on 9/15/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyFoodViewController: NANavigationViewController {
    
    @IBOutlet weak var btn_CollectFood : UIButton!
    @IBOutlet weak var btn_Less : UIButton!
    @IBOutlet weak var btn_More : UIButton!
    
    @IBOutlet weak var lbl_FoodType: UILabel!
    @IBOutlet weak var lbl_FoodQuantity: UILabel!
    @IBOutlet weak var lbl_FoodType_Validation: UILabel!
    @IBOutlet weak var lbl_FoodQuantity_Validation: UILabel!
    
    @IBOutlet weak var txt_FoodType: UITextField!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var checkList_CardView: UIView!

    //Vehicle array of buttons for color changing purpose
    var foodButtons : [UIButton] = []
    var isValidFoodButtonClicked: [Bool] = []
    var navTitle = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        //Button Formatting & settings
        btn_CollectFood.setTitle(NAString().collectFood(), for: .normal)
        btn_CollectFood.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_CollectFood.backgroundColor = NAColor().buttonBgColor()
        btn_CollectFood.titleLabel?.font = NAFont().buttonFont()
        
        //Label and TextField formatting & setting
        lbl_FoodType.font = NAFont().headerFont()
        lbl_FoodQuantity.font = NAFont().headerFont()
        txt_FoodType.font = NAFont().textFieldFont()
        
        //setting Label & Button Text
        lbl_FoodType.text = NAString().foodType()
        lbl_FoodQuantity.text = NAString().foodQuantity()
        btn_Less.titleLabel?.text = NAString().less()
        btn_More.titleLabel?.text = NAString().more()
        
        self.view.layoutIfNeeded()
        //putting black bottom line on textFields
        txt_FoodType.underlined()
        
        //set tag values to buttons
        btn_Less.tag = 1
        btn_More.tag = 2
        
        //make buttons rounded corner
        btn_Less.layer.cornerRadius = 15.0
        btn_More.layer.cornerRadius = 15.0
        
        //setting border width for buttons
        btn_Less.layer.borderWidth = 1
        btn_More.layer.borderWidth = 1
        
        //hiding error Label
        lbl_FoodType_Validation.isHidden = true
        lbl_FoodQuantity_Validation.isHidden = true
        
        NAShadowEffect().shadowEffectForView(view: checkList_CardView)
        NAShadowEffect().shadowEffectForView(view: cardView)
    }
    
    //creating function to highlight garbage button color
    func selectedFoodButtonColor(tag: Int) {
        for button in foodButtons as [UIButton] {
            isValidFoodButtonClicked = [true]
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
    
     @IBAction func collectFoodButtonAction() {
        if (txt_FoodType.text?.isEmpty)! {
            lbl_FoodType_Validation.isHidden = false
            lbl_FoodType_Validation.text = NAString().foodTypeErrorMessage()
            txt_FoodType.redunderlined()
        } else {
            txt_FoodType.underlined()
            lbl_FoodType_Validation.isHidden = true
        }
        if (isValidFoodButtonClicked.index(of: true) == nil) {
            lbl_FoodQuantity_Validation.isHidden = false
            lbl_FoodQuantity_Validation.text = NAString().Please_select_expected_Hours()
        }
        if !(txt_FoodType.text?.isEmpty)! && (isValidFoodButtonClicked.index(of: true) != nil) {
           inviteAlertView()
        }
    }
    
    @IBAction func btnSelectFood(_ sender: UIButton) {
        selectedFoodButtonColor(tag: sender.tag)
        lbl_FoodQuantity_Validation.isHidden = true
    }
    
    //AlertView For navigation
    func inviteAlertView() {
        //creating alert controller
        let alert = UIAlertController(title: NAString().addFood_AlertTitle() , message: NAString().addFood_AlertMessage(), preferredStyle: .alert)
        //creating Accept alert actions
        let okAction = UIAlertAction(title:NAString().ok(), style: .default) { (action) in
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
