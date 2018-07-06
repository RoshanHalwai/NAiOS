//
//  myFlatDetailsViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class myFlatDetailsViewController: NANavigationViewController {
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
    
    //TODO : Need to get data from firebase
    var cities = ["Bangalore", "Hyderabad", "Mumbai", "Delhi", "Bombay"]
    var societies = ["Brigade Gateway", "Salarpuria Cambridge"]
    var BrigadeGateway = ["Aster", "Bolivia"]
    var SalarpuriaCambridge = ["Block-1", "Block-2", "Block-3", "Block-4", "Block-5"]
    var Aster = ["A1001", "A1002", "A1003"]
    var Bolivia = ["B1001", "B1002", "B1003"]
    var Block1 = ["101", "102", "103", "104", "105"]
    var Block2 = ["201", "202", "203", "204", "205"]
    var Block3 = ["301", "302", "303", "304", "305"]
    var Block4 = ["401", "402", "403", "404", "405"]
    var Block5 = ["501", "502", "503", "504", "505"]
    
    //placeHolder instance
    var placeHolder = NSMutableAttributedString()
    
    var cityString = String()
    var societyString = String()
    var apartmentString = String()
    var flatString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtCity.text = cityString
        self.txtSociety.text = societyString
        self.txtApartment.text = apartmentString
        self.txtFlat.text = flatString
       
        //Assigning Delegates to TextFields
        txtCity.delegate = self
        txtFlat.delegate = self
        txtSociety.delegate = self
        txtApartment.delegate = self
        
        //hiding all other items on view load except city
        hideDetailsofSociety()
        hideDetailsofAppartment()
        hideDetailsofFlat()
        hideDetailsofResidentandContinueButton()
        
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
        
        txtCity.font = NAFont().textFieldFont()
        txtSociety.font = NAFont().textFieldFont()
        txtApartment.font = NAFont().textFieldFont()
        txtFlat.font = NAFont().textFieldFont()
        
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
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        
        //Hiding Navigation bar Back Button
        self.navigationItem.hidesBackButton = true
        
        //set Title in Navigation Bar
        self.navigationItem.title = NAString().My_flat_Details_title()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.txtCity.text = cityString
        self.txtSociety.text = societyString
        self.txtApartment.text = apartmentString
        self.txtFlat.text = flatString
        
        if !(txtCity.text?.isEmpty)! && lbl_Society.isHidden == true {
            txtSociety.isHidden = false
            lbl_Society.isHidden = false
            txtSociety.text = ""
        } else if !(txtSociety.text?.isEmpty)! && txtApartment.isHidden == true {
            txtApartment.isHidden = false
            lbl_Apartment.isHidden = false
            txtApartment.text = ""
        } else if !(txtApartment.text?.isEmpty)! && txtFlat.isHidden == true {
            txtFlat.isHidden = false
            lbl_Flat.isHidden = false
            txtFlat.text = ""
        } else if !(txtFlat.text?.isEmpty)! && lbl_ResidentType.isHidden == true {
            lbl_ResidentType.isHidden = false
            segment_ResidentType.isHidden = false
        }
    }
    @IBAction func btnContinue(_ sender: Any) {
    }
    @IBAction func btnResidentType(_ sender: Any) {
        lbl_Description.isHidden = false
        btnContinue.isHidden = false
        self.view.endEditing(true)
    }
    func hideDetailsofSociety() {
        lbl_Society.isHidden = true
        txtSociety.isHidden = true
        txtSociety.text = ""
    }
    func hideDetailsofAppartment() {
        lbl_Apartment.isHidden = true
        txtApartment.isHidden = true
        txtApartment.text = ""
    }
    func hideDetailsofFlat() {
        lbl_Flat.isHidden = true
        txtFlat.isHidden = true
        txtFlat.text = ""
    }
    func hideDetailsofResidentandContinueButton() {
        lbl_ResidentType.isHidden = true
        segment_ResidentType.isHidden = true
        segment_ResidentType.selectedSegmentIndex = UISegmentedControlNoSegment
        lbl_Description.isHidden = true
        btnContinue.isHidden = true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
            case txtCity:
                hideDetailsofSociety()
                hideDetailsofAppartment()
                hideDetailsofFlat()
                hideDetailsofResidentandContinueButton()
            case txtSociety:
                hideDetailsofAppartment()
                hideDetailsofFlat()
                hideDetailsofResidentandContinueButton()
            case txtApartment:
                hideDetailsofFlat()
                hideDetailsofResidentandContinueButton()
            case txtFlat:
                hideDetailsofResidentandContinueButton()
            default:
                break
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            let searchVC = self.storyboard!.instantiateViewController(withIdentifier: "searchVC") as! SearchTableViewController
            let nav : UINavigationController = UINavigationController(rootViewController: searchVC)
            
            if textField == txtCity {
                searchVC.title = NAString().your_city()
                txtCity.resignFirstResponder()
            } else if textField == txtSociety {
                searchVC.title = NAString().your_society()
                txtSociety.resignFirstResponder()
            } else if textField == txtApartment {
                searchVC.title = NAString().your_apartment()
                txtApartment.resignFirstResponder()
            } else if textField == txtFlat {
                searchVC.title = NAString().your_flat()
                txtFlat.resignFirstResponder()
            }
            searchVC.myFlatDetailsVC = self
            self.navigationController?.present(nav, animated: true, completion: nil)
        return true
    }
    //function to end editing on the touch on the view
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
