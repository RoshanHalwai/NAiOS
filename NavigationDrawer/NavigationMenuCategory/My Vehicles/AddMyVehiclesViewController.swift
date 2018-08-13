//
//  AddMyVehiclesViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class AddMyVehiclesViewController: NANavigationViewController {
    
    @IBOutlet weak var btn_Bike : UIButton!
    @IBOutlet weak var btn_Car : UIButton!
    @IBOutlet weak var btn_AddVehicle : UIButton!
    
    @IBOutlet weak var lbl_VehicleType: UILabel!
    @IBOutlet weak var lbl_VehicleNumber: UILabel!
    @IBOutlet weak var lbl_VehicleType_Validation: UILabel!
    @IBOutlet weak var lbl_VehicleNumber_Validation: UILabel!
    
    @IBOutlet weak var txt_CabStateCode: UITextField!
    @IBOutlet weak var txt_CabRtoNumber: UITextField!
    @IBOutlet weak var txt_CabSerialNumberOne: UITextField!
    @IBOutlet weak var txt_CabSerialNumberTwo: UITextField!
    
    @IBOutlet weak var cardView: UIView!
    
    //Vehicle array of buttons for color changing purpose
    var vehicleButtons : [UIButton] = []
    var isValidVehicleButtonClicked: [Bool] = []
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        
        //putting black bottom line on textFields
        txt_CabStateCode.underlined()
        txt_CabRtoNumber.underlined()
        txt_CabSerialNumberOne.underlined()
        txt_CabSerialNumberTwo.underlined()
        
        //Textfield formatting & setting
        txt_CabStateCode.font = NAFont().textFieldFont()
        txt_CabRtoNumber.font = NAFont().textFieldFont()
        txt_CabSerialNumberOne.font = NAFont().textFieldFont()
        txt_CabSerialNumberTwo.font = NAFont().textFieldFont()
        
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
        //Getting Button Text
        selectedVehicleColor(tag: sender.tag)
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
