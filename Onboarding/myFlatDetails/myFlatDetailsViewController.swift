//
//  myFlatDetailsViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

extension UITextField{
    
    func underlinedMyFlatDetails(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}

class myFlatDetailsViewController: UIViewController,UITextFieldDelegate
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
        
        //Color & sizes for textfields & labels
        txtCity.font = NAFont().textFieldFont()
        txtSociety.font = NAFont().textFieldFont()
        txtFlat.font = NAFont().textFieldFont()
        txtApartment.font = NAFont().textFieldFont()
        
        lbl_City.font = NAFont().headerFont()
         lbl_Flat.font = NAFont().headerFont()
         lbl_Society.font = NAFont().headerFont()
         lbl_Apartment.font = NAFont().headerFont()
         lbl_ResidentType.font = NAFont().headerFont()
         lbl_Description.font = NAFont().descriptionFont()
        
        //color & font for button
        btnContinue.backgroundColor = NAColor().buttonBgColor()
        btnContinue.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        
        //Set Textfield bottom border line
        txtCity.underlinedMyFlatDetails()
        txtFlat.underlinedMyFlatDetails()
        txtSociety.underlinedMyFlatDetails()
        txtApartment.underlinedMyFlatDetails()
        //keyboard will appear when textfield got focus
        
        txtCity.becomeFirstResponder()
        
        //set strings
        lbl_City.text = NAString().city()
        lbl_Society.text = NAString().society()
        lbl_Flat.text = NAString().flat()
        lbl_Apartment.text = NAString().apartment()
        lbl_ResidentType.text = NAString().resident_type()
        lbl_Description.text = NAString().verification_message()
    btnContinue.setTitle(NAString().continue_button(), for: .normal)
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        
       
        //hide back button
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "MY FLAT DETAILS"
        

       
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
