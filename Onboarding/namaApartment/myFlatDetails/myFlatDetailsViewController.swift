//
//  myFlatDetailsViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class myFlatDetailsViewController: NANavigationViewController
{
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var segment_ResidentType: UISegmentedControl!
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var txtApartment: UITextField!
    @IBOutlet weak var txtSociety: UITextField!
    @IBOutlet weak var txtFlat: UITextField!
    
    @IBOutlet weak var lbl_City: UILabel!
    @IBOutlet weak var lbl_Apartment: UILabel!
    @IBOutlet weak var lbl_Flat: UILabel!
    @IBOutlet weak var lbl_Society: UILabel!
    @IBOutlet weak var lbl_ResidentType: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentResidentType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //TextField formatting & setting
    txtCity.font = NAFont().textFieldFont()
    txtSociety.font = NAFont().textFieldFont()
    txtFlat.font = NAFont().textFieldFont()
    txtApartment.font = NAFont().textFieldFont()
   
    //Label formatting & setting
    lbl_City.font = NAFont().headerFont()
    lbl_Flat.font = NAFont().headerFont()
    lbl_Society.font = NAFont().headerFont()
    lbl_Apartment.font = NAFont().headerFont()
    lbl_ResidentType.font = NAFont().headerFont()
    lbl_Description.font = NAFont().descriptionFont()
        
    lbl_City.text = NAString().city()
    lbl_Society.text = NAString().society()
    lbl_Flat.text = NAString().flat()
    lbl_Apartment.text = NAString().apartment()
    lbl_ResidentType.text = NAString().resident_type()
    lbl_Description.text = NAString().verification_message()

    //Button formatting & setting
    btnContinue.backgroundColor = NAColor().buttonBgColor()
    btnContinue.setTitleColor(NAColor().buttonFontColor(), for: .normal)
    btnContinue.titleLabel?.font = NAFont().buttonFont()
    btnContinue.setTitle(NAString().continue_button(), for: .normal)
        
    //Set Textfield bottom border line
    txtCity.underlined()
    txtFlat.underlined()
    txtSociety.underlined()
    txtApartment.underlined()
    
    //become First Responder
    txtCity.becomeFirstResponder()
        
    //scrollView
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        
    //Hiding Navigation bar Back Button
    self.navigationItem.hidesBackButton = true
        
    //set Title in Navigation Bar
    self.navigationItem.title = "My Flat Details"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnContinue(_ sender: Any)
    {
    }
    
    @IBAction func btnResidentType(_ sender: Any)
    {
    }
}
