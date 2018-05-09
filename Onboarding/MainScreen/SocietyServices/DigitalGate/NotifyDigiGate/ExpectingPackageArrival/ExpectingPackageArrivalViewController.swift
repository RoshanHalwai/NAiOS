//
//  ExpectingPackageArrivalViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 09/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class ExpectingPackageArrivalViewController: UIViewController
{
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_PackageVendor: UILabel!
    @IBOutlet weak var lbl_DateTime: UILabel!
    @IBOutlet weak var lbl_ValidFor: UILabel!
    
    @IBOutlet weak var txt_PacageVendor: UITextField!
    @IBOutlet weak var txt_DateTime: UITextField!
    
    @IBOutlet weak var btn_DateTime: UIButton!
    @IBOutlet weak var btn_NotifyGate: UIButton!
    
    @IBOutlet weak var btn_1Hour: UIButton!
    @IBOutlet weak var btn_2Hour: UIButton!
    @IBOutlet weak var btn_4Hour: UIButton!
    @IBOutlet weak var btn_6Hour: UIButton!
    @IBOutlet weak var btn_8Hour: UIButton!
    @IBOutlet weak var btn_12Hour: UIButton!
    @IBOutlet weak var btn_16Hour: UIButton!
    @IBOutlet weak var btn_24Hour: UIButton!
    
    //for card view
    @IBOutlet weak var cardView: UIView!
    // for scroll view
    @IBOutlet weak var scrollView: UIScrollView!
    
    //created date picker programtically
    let picker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //putting black bottom line on textFields
        txt_PacageVendor.underlined()
        txt_DateTime.underlined()
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        
        //calling datePicker On ViewLoad
        createDatePicker()
        
        //Label formatting & setting
        lbl_Title.text = NAString().expecting_package_arrival()
        lbl_PackageVendor.text = NAString().package_number()
        lbl_DateTime.text = NAString().date_Time()
        lbl_ValidFor.text = NAString().valid_for()
        
        lbl_Title.font = NAFont().headerFont()
        lbl_ValidFor.font = NAFont().headerFont()
        lbl_DateTime.font = NAFont().headerFont()
        lbl_PackageVendor.font = NAFont().headerFont()
        
        //Textfield formatting & setting
        txt_PacageVendor.font = NAFont().textFieldFont()
        txt_DateTime.font = NAFont().textFieldFont()
        
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
        
        btn_1Hour.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_2Hour.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_4Hour.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_6Hour.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_8Hour.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_12Hour.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_16Hour.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_24Hour.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_NotifyGate.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        
        btn_NotifyGate.backgroundColor = NAColor().buttonBgColor()
        
        btn_NotifyGate.titleLabel?.font = NAFont().buttonFont()
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //for datePicker
    func createDatePicker() {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        txt_DateTime.inputAccessoryView = toolbar
        txt_DateTime.inputView = picker
        // format picker for date
        picker.datePickerMode = .dateAndTime
    }
    
    @objc func donePressed() {
        // format date
        let date = DateFormatter()
        date.dateFormat = "MMM d, YY \t HH:mm"
        let dateString = date.string(from: picker.date)
        txt_DateTime.text = dateString
        self.view.endEditing(true)
        
    }
    
    @IBAction func btnShowCalender(_ sender: Any)
    {
        
    }
    
    @IBAction func btnNotifyGate(_ sender: Any)
    {
        
    }
}
