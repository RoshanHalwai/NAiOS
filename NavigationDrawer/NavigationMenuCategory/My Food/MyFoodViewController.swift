//
//  MyFoodViewController.swift
//  nammaApartment
//
//  Created by kalpana on 9/15/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
    var selectDonateFoodbuttons : [UIButton] = []
    var isValidSelectDonateFoodButtonClicked: [Bool] = []
    
    var navTitle = String()
    var getFoodQuantityButton_Text = String()
    
    //Database References
    var userDataDonateFoodRef : DatabaseReference?
    var donateFoodsPrivateRef : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create Food Type textfield first letter capital
        txt_FoodType.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        txt_FoodType.delegate = self
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        //Creating History icon on Navigation bar
        let historyButton = UIButton(type: .system)
        historyButton.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        historyButton.addTarget(self, action: #selector(gotoDonateFoodHistoryVC), for: .touchUpInside)
        let history = UIBarButtonItem(customView: historyButton)
        
        //created Array for history and info button icons
        self.navigationItem.setRightBarButtonItems([history], animated: true)
        
        //Button Formatting & settings
        btn_CollectFood.setTitle(NAString().collectFood(), for: .normal)
        btn_CollectFood.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_CollectFood.backgroundColor = NAColor().buttonBgColor()
        btn_CollectFood.titleLabel?.font = NAFont().buttonFont()
        
        //Label and TextField formatting & setting
        lbl_FoodType.font = NAFont().headerFont()
        lbl_FoodQuantity.font = NAFont().headerFont()
        txt_FoodType.font = NAFont().textFieldFont()
        lbl_FoodType_Validation.font = NAFont().descriptionFont()
        lbl_FoodQuantity_Validation.font = NAFont().descriptionFont()
        
        //setting Label & Button Text
        lbl_FoodType.text = NAString().foodType()
        lbl_FoodQuantity.text = NAString().foodQuantity()
        
        self.view.layoutIfNeeded()
        //putting black bottom line on textFields
        txt_FoodType.underlined()
        
        //for changing Select Slot buttons color
        selectDonateFoodbuttons.removeAll()
        selectDonateFoodbuttons.append(btn_Less)
        selectDonateFoodbuttons.append(btn_More)
        
        //Apply Button Text
        btn_Less.setTitle(NAString().less(), for: .normal)
        btn_More.setTitle(NAString().more(), for: .normal)
        
        //color set on selected
        btn_Less.setTitleColor(UIColor.black, for: .selected)
        btn_More.setTitleColor(UIColor.black, for: .selected)
        
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
    
    @objc func gotoDonateFoodHistoryVC() {
        let dv = NAViewPresenter().donateFoodHistoryVC()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    
    //Create Food Type textfield first letter capital function
    @objc func valueChanged(sender: UITextField) {
        sender.text = sender.text?.capitalized
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txt_FoodType {
            lbl_FoodType_Validation.isHidden = true
            txt_FoodType.underlined()
        }
        return true
    }
    
    //creating function to highlight select Donate Food button color
    func selectedFoodButtonColor(tag: Int) {
        for button in selectDonateFoodbuttons as [UIButton] {
            isValidSelectDonateFoodButtonClicked = [true]
            if button.tag == tag {
                button.isSelected = true
                lbl_FoodQuantity_Validation.isHidden = true
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
            lbl_FoodType_Validation.isHidden = true
            txt_FoodType.underlined()
        }
        if (isValidSelectDonateFoodButtonClicked.index(of: true) == nil) {
            lbl_FoodQuantity_Validation.isHidden = false
            lbl_FoodQuantity_Validation.text = NAString().Please_select_expected_Hours()
        }
        if !(txt_FoodType.text?.isEmpty)! && (isValidSelectDonateFoodButtonClicked.index(of: true) != nil) {
            txt_FoodType.resignFirstResponder()
            storeDonateFoodDetailsInFirebase()
        }
    }
    
    @IBAction func btnSelectFood(_ sender: UIButton) {
        getFoodQuantityButton_Text = (sender.titleLabel?.text)!
        selectedFoodButtonColor(tag: sender.tag)
        txt_FoodType.resignFirstResponder()
    }
    
    //AlertView For navigation
    func inviteAlertView() {
        //creating alert controller
        let alert = UIAlertController(title: NAString().addFood_AlertTitle() , message: NAString().addFood_AlertMessage(), preferredStyle: .alert)
        //creating Accept alert actions
        let okAction = UIAlertAction(title:NAString().ok(), style: .default) { (action) in
            let dv = NAViewPresenter().donateFoodHistoryVC()
            self.txt_FoodType.text = ""
            self.selectedFoodButtonColor(tag: 0)
            dv.fromDonateFoodHistoryVC = true
            self.navigationController?.pushViewController(dv, animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension MyFoodViewController {
    //Creating Function for Storing Donate Food Data in Firebase
    func storeDonateFoodDetailsInFirebase() {
        
        userDataDonateFoodRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_DONATEFOOD)
        
        //Generating donateFood UID
        let donateFoodUID : String?
        donateFoodUID = (userDataDonateFoodRef?.childByAutoId().key)!
        
        //Mapping donateFoodUID with true under UsersData -> Flat
        userDataDonateFoodRef?.child(donateFoodUID!).setValue(NAString().gettrue())
        
        donateFoodsPrivateRef  = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_DONATEFOOD).child(donateFoodUID!)
        
        let expectingDonateFoodData = [
            DonateFoodListFBKeys.foodQuantity.key : getFoodQuantityButton_Text,
            DonateFoodListFBKeys.foodType.key : txt_FoodType.text as Any,
            DonateFoodListFBKeys.status.key : NAString().pending(),           DonateFoodListFBKeys.timeStamp.key : (Int64(Date().timeIntervalSince1970 * 1000)),
            DonateFoodListFBKeys.uid.key : donateFoodUID as Any,
            DonateFoodListFBKeys.userUID.key : userUID
        ]
        donateFoodsPrivateRef?.setValue(expectingDonateFoodData, withCompletionBlock: { (error, snapshot) in
            self.inviteAlertView()
        })
    }
}

