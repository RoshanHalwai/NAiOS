//
//  ExpectingCabArrivalViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 09/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class ExpectingCabArrivalViewController: NANavigationViewController {
    @IBOutlet weak var lbl_CabNumber: UILabel!
    @IBOutlet weak var lbl_DateTime: UILabel!
    @IBOutlet weak var lbl_ValidFor: UILabel!
    
    @IBOutlet weak var lbl_cabNumber_Validation: UILabel!
    @IBOutlet weak var lbl_dateField_Validation: UILabel!
    @IBOutlet weak var lbl_expectedHours_Validation: UILabel!
    
    @IBOutlet weak var txt_CabNumber: UITextField!
    @IBOutlet weak var txt_DateTime: UITextField!
    
    @IBOutlet weak var btn_NotifyGate: UIButton!
    
    @IBOutlet weak var btn_1Hour: UIButton!
    @IBOutlet weak var btn_2Hour: UIButton!
    @IBOutlet weak var btn_4Hour: UIButton!
    @IBOutlet weak var btn_6Hour: UIButton!
    @IBOutlet weak var btn_8Hour: UIButton!
    @IBOutlet weak var btn_12Hour: UIButton!
    @IBOutlet weak var btn_16Hour: UIButton!
    @IBOutlet weak var btn_24Hour: UIButton!
    
    //array of buttons for color changing purpose
    var buttons : [UIButton] = []
    var isValidButtonClicked: [Bool] = []
    
    //to set navigation title
    var navTitle: String?
    
    //Assigning Strings according to title
    var vendorCabNameString: String?
    
    //for card view
    @IBOutlet weak var cardView: UIView!
    
    // for scroll view
    @IBOutlet weak var scrollView: UIScrollView!
    
    //created date picker programtically
    var picker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding error Label
        lbl_cabNumber_Validation.isHidden = true
        lbl_dateField_Validation.isHidden = true
        lbl_expectedHours_Validation.isHidden = true
        
        //assigned delegate method on textFields
        txt_DateTime.delegate = self
        txt_CabNumber.delegate = self
        
        //placing image calender imgage inside the Date&Time TextField
        self.txt_DateTime.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newCalender")
        imageView.image = image
        txt_DateTime.rightView = imageView
        
        // become first responder
        self.txt_CabNumber.becomeFirstResponder()
        
        //Setting & fromatting Navigation Bar
        super.ConfigureNavBarTitle(title: navTitle!)
        
        //Assigning Strings to the label tile according to title
        self.lbl_CabNumber.text = vendorCabNameString
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0)
        
        //calling datePicker On ViewLoad
        createDatePicker()
        
        //putting black bottom line on textFields
        txt_CabNumber.underlined()
        txt_DateTime.underlined()
        
        //Label formatting & setting
        lbl_DateTime.text = NAString().date_Time()
        lbl_ValidFor.text = NAString().valid_for()
        
        //lbl_Title.font = NAFont().headerFont()
        lbl_ValidFor.font = NAFont().headerFont()
        lbl_DateTime.font = NAFont().headerFont()
        lbl_CabNumber.font = NAFont().headerFont()
        
        //Error Labels Font Style
        lbl_cabNumber_Validation.font = NAFont().descriptionFont()
        lbl_dateField_Validation.font = NAFont().descriptionFont()
        lbl_expectedHours_Validation.font = NAFont().descriptionFont()
        
        //Textfield formatting & setting
        txt_CabNumber.font = NAFont().textFieldFont()
        txt_DateTime.font = NAFont().textFieldFont()
        
        //for changing button color
        buttons.removeAll()
        buttons.append(btn_1Hour)
        buttons.append(btn_2Hour)
        buttons.append(btn_4Hour)
        buttons.append(btn_6Hour)
        buttons.append(btn_8Hour)
        buttons.append(btn_12Hour)
        buttons.append(btn_16Hour)
        buttons.append(btn_24Hour)
        
        //button Formatting & setting
        btn_1Hour.setTitle(NAString()._1_hr(), for: .normal)
        btn_2Hour.setTitle(NAString()._2_hrs(), for: .normal)
        btn_4Hour.setTitle(NAString()._4_hrs(), for: .normal)
        btn_6Hour.setTitle(NAString()._6_hrs(), for: .normal)
        btn_8Hour.setTitle(NAString()._8_hrs(), for: .normal)
        btn_12Hour.setTitle(NAString()._12_hrs(), for: .normal)
        btn_16Hour.setTitle(NAString()._16_hrs(), for: .normal)
        btn_24Hour.setTitle(NAString()._24_hrs(), for: .normal)
        btn_NotifyGate.setTitle(NAString().notify_gate(), for: .normal)
        
        //color set on selected
        btn_1Hour.setTitleColor(UIColor.black, for: .selected)
        btn_2Hour.setTitleColor(UIColor.black, for: .selected)
        btn_4Hour.setTitleColor(UIColor.black, for: .selected)
        btn_6Hour.setTitleColor(UIColor.black, for: .selected)
        btn_8Hour.setTitleColor(UIColor.black, for: .selected)
        btn_12Hour.setTitleColor(UIColor.black, for: .selected)
        btn_16Hour.setTitleColor(UIColor.black, for: .selected)
        btn_24Hour.setTitleColor(UIColor.black, for: .selected)
        
        //Button Formatting & settings
        btn_NotifyGate.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_NotifyGate.backgroundColor = NAColor().buttonBgColor()
        btn_NotifyGate.titleLabel?.font = NAFont().buttonFont()
        
        //set tag values to buttons
        btn_1Hour.tag = 1
        btn_2Hour.tag = 2
        btn_4Hour.tag = 3
        btn_6Hour.tag = 4
        btn_8Hour.tag = 5
        btn_12Hour.tag = 6
        btn_16Hour.tag = 7
        btn_24Hour.tag = 8
        
        //make buttons rounded corner
        btn_1Hour.layer.cornerRadius = 15.0
        btn_2Hour.layer.cornerRadius = 15.0
        btn_4Hour.layer.cornerRadius = 15.0
        btn_6Hour.layer.cornerRadius = 15.0
        btn_8Hour.layer.cornerRadius = 15.0
        btn_12Hour.layer.cornerRadius = 15.0
        btn_16Hour.layer.cornerRadius = 15.0
        btn_24Hour.layer.cornerRadius = 15.0
        
        //settin border width for buttons
        btn_1Hour.layer.borderWidth = 1
        btn_2Hour.layer.borderWidth = 1
        btn_4Hour.layer.borderWidth = 1
        btn_6Hour.layer.borderWidth = 1
        btn_8Hour.layer.borderWidth = 1
        btn_12Hour.layer.borderWidth = 1
        btn_16Hour.layer.borderWidth = 1
        btn_24Hour.layer.borderWidth = 1
        
        //setting button hight
        btn_16Hour.heightAnchor.constraint(equalToConstant: 39.0).isActive = true
        btn_1Hour.heightAnchor.constraint(equalToConstant: 39).isActive = true
        btn_NotifyGate.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        //cardUIView
        cardView.layer.cornerRadius = 3
        cardView.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView.layer.shadowRadius = 1.7
        cardView.layer.shadowOpacity = 0.45
    }
    
    //for datePicker
    func createDatePicker() {
        
        // toolbar
        picker = UIDatePicker()
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        txt_DateTime.inputAccessoryView = toolbar
        txt_DateTime.inputView =  picker
        
        // format picker for date
        picker?.datePickerMode = .dateAndTime
        
        //minimum date
        picker?.minimumDate = NSDate() as Date
        
        //set local date to Europe to show 24 hours
        picker?.locale = Locale(identifier: "en_GB")
    }
    
    @objc func donePressed() {
        // format date
        let date = DateFormatter()
        date.dateFormat = "MMM d, YYYY \t HH:mm"
        let dateString = date.string(from: (picker?.date)!)
        txt_DateTime.text = dateString
        self.view.endEditing(true)
        
        if !(txt_DateTime.text?.isEmpty)! {
            lbl_dateField_Validation.isHidden = true
            txt_DateTime.underlined()
        }
    }
    
    @IBAction func btnSelectHours(_ sender: UIButton) {
        
        selectedColor(tag: sender.tag)
    }
    
    @IBAction func btnNotifyGate(_ sender: Any) {
        
        if (txt_CabNumber.text?.isEmpty)! {
            lbl_cabNumber_Validation.isHidden = false
            lbl_cabNumber_Validation.text = NAString().please_fill_details()
            txt_CabNumber.redunderlined()
        } else {
            lbl_cabNumber_Validation.isHidden = true
            txt_CabNumber.underlined()
        }
        if (txt_DateTime.text?.isEmpty)! {
            lbl_dateField_Validation.isHidden = false
            lbl_dateField_Validation.text = NAString().Please_select_date()
            txt_DateTime.redunderlined()
        } else {
            lbl_dateField_Validation.isHidden = true
            txt_DateTime.underlined()
        }
        if !(txt_DateTime.text?.isEmpty)! && (isValidButtonClicked.index(of: true) == nil) {
            lbl_expectedHours_Validation.isHidden = false
            lbl_expectedHours_Validation.text = NAString().Please_select_expected_Hours()
        } else if (isValidButtonClicked.index(of: true) != nil) {
            lbl_expectedHours_Validation.isHidden = true
        }
        if !(txt_CabNumber.text?.isEmpty)! && !(txt_DateTime.text?.isEmpty)! &&  (isValidButtonClicked.index(of: true) != nil) {
            inviteAlertView()
        }
    }
    
    //AlertView For navigation
    func inviteAlertView() {
        
        //creating alert controller
        let alert = UIAlertController(title: NAString().notifyButtonAlertViewTitle() , message: NAString().notifyButtonAlertViewMessage(), preferredStyle: .alert)
        
        //creating Accept alert actions
        let okAction = UIAlertAction(title:NAString().ok(), style: .default) { (action) in
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    //creating function to highlight select button color
    func selectedColor(tag: Int) {
        
        for button in buttons as [UIButton] {
            isValidButtonClicked = [true]
            if button.tag == tag {
                button.isSelected = true
                lbl_expectedHours_Validation.isHidden = true
            } else {
                button.isSelected = false
            }
            let color = button.isSelected ? NAColor().buttonFontColor() : UIColor.white
            button.backgroundColor = color
            button.tintColor = color
        }
    }
}

extension ExpectingCabArrivalViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true}
        let newLength = text.utf16.count + string.utf16.count - range.length
        
        if textField == txt_CabNumber {
            if (newLength == NAString().zero_length()) {
                lbl_cabNumber_Validation.isHidden = false
                lbl_cabNumber_Validation.text = NAString().please_fill_details()
                txt_CabNumber.redunderlined()
            } else {
                lbl_cabNumber_Validation.isHidden = true
                txt_CabNumber.underlined()
            }
        }
        if textField == txt_DateTime {
            if (newLength == NAString().zero_length()) {
                lbl_dateField_Validation.isHidden = false
                txt_DateTime.redunderlined()
                lbl_dateField_Validation.text = NAString().Please_select_date()
            } else {
                lbl_dateField_Validation.isHidden = true
                txt_DateTime.underlined()
            }
        }
        return true
    }
}