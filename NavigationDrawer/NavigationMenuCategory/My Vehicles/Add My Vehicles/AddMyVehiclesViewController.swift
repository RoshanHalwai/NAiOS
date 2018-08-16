//
//  AddMyVehiclesViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddMyVehiclesViewController: NANavigationViewController {
    
    @IBOutlet weak var btn_Bike : UIButton!
    @IBOutlet weak var btn_Car : UIButton!
    @IBOutlet weak var btn_AddVehicle : UIButton!
    
    @IBOutlet weak var lbl_VehicleType: UILabel!
    @IBOutlet weak var lbl_VehicleNumber: UILabel!
    @IBOutlet weak var lbl_VehicleType_Validation: UILabel!
    @IBOutlet weak var lbl_VehicleNumber_Validation: UILabel!
    
    @IBOutlet weak var txt_VehicleStateCode: UITextField!
    @IBOutlet weak var txt_VehicleRtoNumber: UITextField!
    @IBOutlet weak var txt_VehicleSerialNumberOne: UITextField!
    @IBOutlet weak var txt_VehicleSerialNumberTwo: UITextField!
    
    @IBOutlet weak var cardView: UIView!
    
    //Vehicle array of buttons for color changing purpose
    var vehicleButtons : [UIButton] = []
    var isValidVehicleButtonClicked: [Bool] = []
    var navTitle = String()
    
    //Database References
    var userDataVehicleRef : DatabaseReference?
    var vehiclesPrivateRef : DatabaseReference?
    var vehiclePrivateRef : DatabaseReference?
    
    var finalVehicleString = String()
    var btn_VehicleType_String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        
        //putting black bottom line on textFields
        txt_VehicleStateCode.underlined()
        txt_VehicleRtoNumber.underlined()
        txt_VehicleSerialNumberOne.underlined()
        txt_VehicleSerialNumberTwo.underlined()
        
        //Textfield formatting & setting
        txt_VehicleStateCode.font = NAFont().textFieldFont()
        txt_VehicleRtoNumber.font = NAFont().textFieldFont()
        txt_VehicleSerialNumberOne.font = NAFont().textFieldFont()
        txt_VehicleSerialNumberTwo.font = NAFont().textFieldFont()
        
        //Label formatting & setting
        lbl_VehicleType.font = NAFont().headerFont()
        lbl_VehicleNumber.font = NAFont().headerFont()
        
        //for changing Vehicle buttons color
        vehicleButtons.removeAll()
        vehicleButtons.append(btn_Bike)
        vehicleButtons.append(btn_Car)
        
        //button Formatting & setting
        btn_Bike.setTitle(NAString().bike(), for: .normal)
        btn_Car.setTitle(NAString().car(), for: .normal)
        
        //hiding error Label
        lbl_VehicleType_Validation.isHidden = true
        lbl_VehicleNumber_Validation.isHidden = true
        
        //Error Labels Font Style
        lbl_VehicleType_Validation.font = NAFont().descriptionFont()
        lbl_VehicleNumber_Validation.font = NAFont().descriptionFont()
        
        //color set on selected
        btn_Bike.setTitleColor(UIColor.black, for: .selected)
        btn_Car.setTitleColor(UIColor.black, for: .selected)
        
        //Button Formatting & settings
        btn_AddVehicle.setTitle(NAString().addVehicle(), for: .normal)
        btn_AddVehicle.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_AddVehicle.backgroundColor = NAColor().buttonBgColor()
        btn_AddVehicle.titleLabel?.font = NAFont().buttonFont()
        
        //set tag values to textFields
        txt_VehicleStateCode.tag = 1
        txt_VehicleRtoNumber.tag = 2
        txt_VehicleSerialNumberOne.tag = 3
        txt_VehicleSerialNumberTwo.tag = 4
        
        //set tag values to buttons
        btn_Bike.tag = 1
        btn_Car.tag = 2
        
        //make buttons rounded corner
        btn_Bike.layer.cornerRadius = 15.0
        btn_Car.layer.cornerRadius = 15.0
        
        //setting border width for buttons
        btn_Bike.layer.borderWidth = 1
        btn_Car.layer.borderWidth = 1
        
        //cardUIView
        cardView.layer.cornerRadius = 3
        cardView.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView.layer.shadowRadius = 1.7
        cardView.layer.shadowOpacity = 0.45
    }
    
    @IBAction func btnSelectVehicles(_ sender: UIButton) {
        btn_VehicleType_String = (sender.titleLabel?.text)!
        selectedVehicleColor(tag: sender.tag)
        lbl_VehicleType_Validation.isHidden = true
    }
    
    @IBAction func addVehicleButtonAction() {
        if (txt_VehicleStateCode.text?.isEmpty)! {
            txt_VehicleStateCode.redunderlined()
        } else {
            lbl_VehicleNumber_Validation.isHidden = true
            txt_VehicleStateCode.underlined()
        }
        if (txt_VehicleRtoNumber.text?.isEmpty)! {
            txt_VehicleRtoNumber.redunderlined()
        } else {
            lbl_VehicleNumber_Validation.isHidden = true
            txt_VehicleRtoNumber.underlined()
        }
        if (txt_VehicleSerialNumberOne.text?.isEmpty)! {
            txt_VehicleSerialNumberOne.redunderlined()
        } else {
            lbl_VehicleNumber_Validation.isHidden = true
            txt_VehicleSerialNumberOne.underlined()
        }
        if (txt_VehicleSerialNumberTwo.text?.isEmpty)! {
            txt_VehicleSerialNumberTwo.redunderlined()
        } else {
            lbl_VehicleNumber_Validation.isHidden = true
            txt_VehicleSerialNumberTwo.underlined()
        }
        if !(txt_VehicleStateCode.text?.isEmpty)! &&  !(txt_VehicleRtoNumber.text?.isEmpty)! && !(txt_VehicleSerialNumberOne.text?.isEmpty)! && !(txt_VehicleSerialNumberTwo.text?.isEmpty)! {
            lbl_VehicleNumber_Validation.isHidden = true
        } else {
            lbl_VehicleNumber_Validation.isHidden = false
            lbl_VehicleNumber_Validation.text = NAString().please_Enter_Vehicle_Number()
        }
        if (isValidVehicleButtonClicked.index(of: true) == nil) {
            lbl_VehicleType_Validation.isHidden = false
            lbl_VehicleType_Validation.text = NAString().Please_select_expected_Hours()
        }
        if !(txt_VehicleStateCode.text?.isEmpty)! &&  !(txt_VehicleRtoNumber.text?.isEmpty)! && !(txt_VehicleSerialNumberOne.text?.isEmpty)! && !(txt_VehicleSerialNumberTwo.text?.isEmpty)! &&  (isValidVehicleButtonClicked.index(of: true) != nil) {
            
            //Calling Expecting Vehicle Function
            storeVehicleDetailsInFirebase()
        }
    }
    
    //AlertView For navigation
    func inviteAlertView() {
        //creating alert controller
        let alert = UIAlertController(title: NAString().addVehicle_AlertTitle() , message: NAString().addVehicle_AlertMessage(), preferredStyle: .alert)
        //creating Accept alert actions
        let okAction = UIAlertAction(title:NAString().ok(), style: .default) { (action) in
            let lv = NAViewPresenter().myVehiclesVC()
            lv.fromHomeScreenVC = true
            lv.navTitle = NAString().my_vehicles()
            self.navigationController?.pushViewController(lv, animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    //creating function to highlight garbage button color
    func selectedVehicleColor(tag: Int) {
        for button in vehicleButtons as [UIButton] {
            isValidVehicleButtonClicked = [true]
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
    
    // Creating VehicleStateCodeAndSerailCodeLength Validation and vehicleSerialNumberLength Validation
    func vehicleStateCodeAndSerailCodeLength(isVehicleNumberLength: Int) -> Bool{
        if (isVehicleNumberLength >= 2) {
            return true
        } else {
            return false
        }
    }
    
    func vehicleSerialNumberLength(isVehicleSerialNumberLength: Int) -> Bool {
        if (isVehicleSerialNumberLength >= 4) {
            return true
        } else {
            return false
        }
    }
    
    // Creating move cursor from One textField to another TextField
    func shouldChangeCustomCharacters(textField:UITextField, string: String) ->Bool {
        //Check if textField has two chacraters
        if ((textField.text?.count)! == 1  && string.count > 0) {
            // get next TextField
            let nextTag = textField.tag + 1
            var nextTextField = textField.superview?.viewWithTag(nextTag)
            if (nextTextField == nil) {
                nextTextField = textField.superview?.viewWithTag(1)
            }
            textField.text = textField.text! + string
            //write here your last textfield tag
            if textField.tag == 4 {
                //Dissmiss keyboard on last entry
                textField.resignFirstResponder()
            }
            else {
                //Appear keyboard
                nextTextField?.becomeFirstResponder()
            }
            return false
        } else if ((textField.text?.count)! == 1  && string.count == 0) {
            // on deleteing value from Textfield
            let previousTag = textField.tag - 1
            // get previous TextField
            var previousTextField = textField.superview?.viewWithTag(previousTag)
            if (previousTextField == nil) {
                previousTextField = textField.superview?.viewWithTag(1)
            }
            textField.text = ""
            previousTextField?.becomeFirstResponder()
            return false
        }
        return true
    }
}

extension AddMyVehiclesViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true}
        let vehicle_New_TextLength = text.utf16.count + string.utf16.count - range.length
        if textField == txt_VehicleStateCode {
            if (vehicle_New_TextLength == NAString().zero_length()) {
                txt_VehicleStateCode.redunderlined()
            } else {
                lbl_VehicleNumber_Validation.isHidden = true
                txt_VehicleStateCode.underlined()
            }
            if shouldChangeCustomCharacters(textField: textField, string: string) {
                if vehicleStateCodeAndSerailCodeLength(isVehicleNumberLength: vehicle_New_TextLength) {
                    return vehicle_New_TextLength <= 2
                }
                return true
            }
        }
        if textField == txt_VehicleRtoNumber {
            if (vehicle_New_TextLength == NAString().zero_length()) {
                txt_VehicleRtoNumber.redunderlined()
            } else {
                lbl_VehicleNumber_Validation.isHidden = true
                txt_VehicleRtoNumber.underlined()
            }
            if shouldChangeCustomCharacters(textField: textField, string: string) {
                if vehicleStateCodeAndSerailCodeLength(isVehicleNumberLength: vehicle_New_TextLength) {
                    return vehicle_New_TextLength <= 2
                }
                return true
            }
        }
        if textField == txt_VehicleSerialNumberOne {
            if (vehicle_New_TextLength == NAString().zero_length()) {
                txt_VehicleSerialNumberOne.redunderlined()
            } else {
                lbl_VehicleNumber_Validation.isHidden = true
                txt_VehicleSerialNumberOne.underlined()
            }
            if shouldChangeCustomCharacters(textField: textField, string: string) {
                if vehicleStateCodeAndSerailCodeLength(isVehicleNumberLength: vehicle_New_TextLength) {
                    return vehicle_New_TextLength <= 2
                }
                return true
            }
        }
        if textField == txt_VehicleSerialNumberTwo {
            if vehicleSerialNumberLength(isVehicleSerialNumberLength: vehicle_New_TextLength) {
                if (vehicle_New_TextLength == NAString().zero_length()) {
                    txt_VehicleSerialNumberTwo.redunderlined()
                } else {
                    lbl_VehicleNumber_Validation.isHidden = true
                    txt_VehicleSerialNumberTwo.underlined()
                }
            }
            return vehicle_New_TextLength <= 4
        }
        return false
    }
    
    //Creating Function for Storing Vehicle Data in Firebase
    func storeVehicleDetailsInFirebase() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDate = formatter.string(from: date)
        
        //Concatination of Vehicle textFields
        let vehicleStateCode  = self.txt_VehicleStateCode.text!
        let vehicleRTOCode  = self.txt_VehicleRtoNumber.text!
        let vehicleSerialOne  = self.txt_VehicleSerialNumberOne.text!
        let vehicleSerialTwo = self.txt_VehicleSerialNumberTwo.text!
        let hyphen = "-"
        self.finalVehicleString = vehicleStateCode + hyphen + vehicleRTOCode + hyphen + vehicleSerialOne + hyphen + vehicleSerialTwo
        
        vehiclePrivateRef = Database.database().reference().child(Constants.FIREBASE_CHILD_VEHICLES).child(Constants.FIREBASE_USER_CHILD_PRIVATE)
        
        //Generating Vehicle UID
        let vehicleUID : String?
        vehicleUID = (vehiclePrivateRef?.childByAutoId().key)!
        
        vehiclesPrivateRef = Database.database().reference().child(Constants.FIREBASE_CHILD_VEHICLES).child(Constants.FIREBASE_USER_CHILD_ALL)
        
        userDataVehicleRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_VEHICLES)
        
        //Mapping VehicleUID with true under UsersData -> Flat
        userDataVehicleRef?.child(vehicleUID!).setValue(NAString().gettrue())
        
        //Mapping Vehicle Number With  Vehicle UID
        vehiclesPrivateRef?.child(finalVehicleString).setValue(vehicleUID)
        
        let expectingVehicleData = [
            VehicleListFBKeys.addedDate.key : currentDate,
            VehicleListFBKeys.ownerName.key : GlobalUserData.shared.personalDetails_Items.first?.fullName,
            VehicleListFBKeys.vehicleNumber.key : finalVehicleString,
            VehicleListFBKeys.vehicleType.key : btn_VehicleType_String
        ]
        
        //Adding data in Firebase from dictionary
        self.vehiclePrivateRef?.child(vehicleUID!).setValue(expectingVehicleData)
        //Calling Alert Function After Storing Data in Firebase
        inviteAlertView()
    }
}
