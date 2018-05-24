//
//  EditMyServicesViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 23/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class EditMyServicesViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_MobileNo: UILabel!
    @IBOutlet weak var lbl_InTime: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_CountryCode: UITextField!
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_InTime: UITextField!
    
    @IBOutlet weak var btn_Update: UIButton!
    
    //get data from My Visitor List VC
    var getName = String()
    var getMobile = String()
    var getTime = String()
    var getDescription = String()
    var getTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Formatting & setting Navigation Bar
        super.ConfigureNavBarTitle(title: getTitle)
        
        //assigning string to labels to get data
        self.txt_Name.text! = getName
        self.txt_MobileNo.text! = getMobile
        self.txt_InTime.text! = getTime
        self.lbl_Description.text! = getDescription

        //Formattimg & setting Label
        self.lbl_Name.font = NAFont().headerFont()
        self.lbl_InTime.font = NAFont().headerFont()
        self.lbl_MobileNo.font = NAFont().headerFont()
        self.lbl_Description.font = NAFont().descriptionFont()
        
        self.lbl_Name.text = NAString().name()
        self.lbl_MobileNo.text = NAString().mobile()
        self.lbl_InTime.text = NAString().time()
    
        //Formatting & setting TextField
        self.txt_Name.font = NAFont().textFieldFont()
        self.txt_InTime.font = NAFont().textFieldFont()
        self.txt_MobileNo.font = NAFont().textFieldFont()
        self.txt_CountryCode.font = NAFont().textFieldFont()
        
        self.txt_CountryCode.text = NAString()._91()
        
        //creating black underline in bottom of texfield
        self.txt_CountryCode.underlined()
        self.txt_MobileNo.underlined()
        self.txt_Name.underlined()
        self.txt_InTime.underlined()
        
        //Formatting & setting Button
        self.btn_Update.setTitle(NAString().update(), for: .normal)
        self.btn_Update.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_Update.backgroundColor = UIColor.black
            
    }

}
