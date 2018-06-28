//
//  myFlatDetailsViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 02/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class myFlatDetailsViewController: NANavigationViewController, UITableViewDelegate, UITableViewDataSource {
    
    var city = ["Bangalore"]
    var Society = ["Brigade Gateway", "Salarpuria Cambridge"]
    var BrigadeGateway = ["Aster", "Bolivia"]
    var SalarpuriaCambridge = ["Block-1", "Block-2", "Block-3", "Block-4", "Block-5"]
    var Aster = ["A1001", "A1002", "A1003"]
    var Bolivia = ["B1001", "B1002", "B1003"]
    var Block1 = ["101", "102", "103", "104", "105"]
    var Block2 = ["201", "202", "203", "204", "205"]
    var Block3 = ["301", "302", "303", "304", "305"]
    var Block4 = ["401", "402", "403", "404", "405"]
    var Block5 = ["501", "502", "503", "504", "505"]
    
    
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
    @IBOutlet weak var list_TableView: UITableView!
    @IBOutlet weak var search_TextField: UITextField!
    @IBOutlet weak var list_View: UIView!
    @IBOutlet weak var opacity_View: UIView!
    
    
    var placeHolder = NSMutableAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list_TableView.rowHeight = UITableViewAutomaticDimension
        list_TableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        list_View.layer.cornerRadius = 5

        
        //Assigning Delegates to TextFields
        txtCity.delegate = self
        txtFlat.delegate = self
        txtSociety.delegate = self
        txtApartment.delegate = self
        
        //Assigning TableView Delegates and Datasource
        list_TableView.delegate = self
        list_TableView.dataSource = self
        
        search_TextField.underlined()
        
        self.list_TableView.separatorStyle = .none
        
        //Hiding All items Except city item When View Loading
        btnContinue.isHidden = true
        segment_ResidentType.isHidden = true
        txtApartment.isHidden = true
        txtSociety.isHidden = true
        txtFlat.isHidden = true
        lbl_Apartment.isHidden = true
        lbl_Flat.isHidden = true
        lbl_Society.isHidden = true
        lbl_ResidentType.isHidden = true
        lbl_Description.isHidden = true
        
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
        
        //become First Responder
        txtCity.becomeFirstResponder()
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        
        //Hiding Navigation bar Back Button
        self.navigationItem.hidesBackButton = true
        
        //set Title in Navigation Bar
        self.navigationItem.title = "My Flat Details"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        opacity_View.addGestureRecognizer(tap)


    }
    override func viewWillAppear(_ animated: Bool) {
       list_TableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnContinue(_ sender: Any)
    {
    }
    
    @IBAction func btnResidentType(_ sender: Any)
    {
        lbl_Description.isHidden = false
        btnContinue.isHidden = false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtCity {
            opacity_View.isHidden = false
            lbl_Society.isHidden = true
            lbl_Apartment.isHidden = true
            lbl_Flat.isHidden = true
            txtSociety.isHidden = true
            txtSociety.text = ""
            txtApartment.isHidden = true
            txtApartment.text = ""
            txtFlat.isHidden = true
            txtFlat.text = ""
            lbl_ResidentType.isHidden = true
            segment_ResidentType.isHidden = true
            lbl_Description.isHidden = true
            btnContinue.isHidden = true
            list_View.isHidden = false
            list_TableView.reloadData()
        }
        if textField == txtSociety {
            opacity_View.isHidden = false
            lbl_Apartment.isHidden = true
            lbl_Flat.isHidden = true
            txtApartment.isHidden = true
            txtApartment.text = ""
            txtFlat.isHidden = true
            txtFlat.text = ""
            lbl_ResidentType.isHidden = true
            segment_ResidentType.isHidden = true
            lbl_Description.isHidden = true
            btnContinue.isHidden = true
            list_View.isHidden = false
            list_TableView.reloadData()
        }
        if textField == txtApartment {
            opacity_View.isHidden = false
            lbl_Flat.isHidden = true
            txtFlat.isHidden = true
            txtFlat.text = ""
            lbl_ResidentType.isHidden = true
            segment_ResidentType.isHidden = true
            lbl_Description.isHidden = true
            btnContinue.isHidden = true
            list_View.isHidden = false
            list_TableView.reloadData()
        }
        if textField == txtFlat {
            opacity_View.isHidden = false
            lbl_ResidentType.isHidden = true
            segment_ResidentType.isHidden = true
            lbl_Description.isHidden = true
            btnContinue.isHidden = true
            list_View.isHidden = false
            list_TableView.reloadData()
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (txtSociety.text?.isEmpty)! {
            opacity_View.isHidden = false
            list_View.isHidden = false
            list_TableView.reloadData()
        } else if (txtApartment.text?.isEmpty)! {
            opacity_View.isHidden = false
            list_View.isHidden = false
            list_TableView.reloadData()
        } else if (txtFlat.text?.isEmpty)! {
            opacity_View.isHidden = false
            list_View.isHidden = false
            list_TableView.reloadData()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        list_View.isHidden = true
        opacity_View.isHidden = true
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if txtCity.isHidden == false && txtSociety.isHidden == true {
            return city.count
        } else if txtSociety.isHidden == false && txtApartment.isHidden == true {
            return Society.count
        } else if txtCity.isHidden == false && txtApartment.isHidden == false && txtFlat.isHidden == true && txtSociety.text == "Brigade Gateway" {
            return BrigadeGateway.count
        } else if txtFlat.isHidden == false && txtApartment.text == "Aster" {
            return Aster.count
        } else if txtFlat.isHidden == false && txtApartment.text == "Bolivia" {
            return Bolivia.count
        } else if txtApartment.isHidden == false && txtSociety.text == "Salarpuria Cambridge" {
            return SalarpuriaCambridge.count
        } else if txtFlat.isHidden == false && txtApartment.text == "Block-1" {
            return Block1.count
        } else if txtFlat.isHidden == false && txtApartment.text == "Block-2" {
            return Block2.count
        } else if txtFlat.isHidden == false && txtApartment.text == "Block-3" {
            return Block3.count
        } else if txtFlat.isHidden == false && txtApartment.text == "Block-4" {
            return Block4.count
        } else if txtFlat.isHidden == false && txtApartment.text == "Block-5" {
            return Block5.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyFlatTableViewCell
        if txtCity.isHidden == false {
            placeHolderMethod(Name: "Search City")
            Cell.list_Label.text = "Bangalore"
        }
        if txtSociety.isHidden == false && txtApartment.isHidden == true {
            placeHolderMethod(Name: "Search Society")
            Cell.list_Label.text = Society[indexPath.row]
        }
        if txtApartment.isHidden == false && txtFlat.isHidden == true && txtSociety.text == "Brigade Gateway" {
            placeHolderMethod(Name: "Search Apartment")
            Cell.list_Label.text = BrigadeGateway[indexPath.row]
        }
        if txtApartment.isHidden == false && txtSociety.text == "Salarpuria Cambridge" {
            placeHolderMethod(Name: "Search Apartment")
            Cell.list_Label.text = SalarpuriaCambridge[indexPath.row]
        }
        if txtApartment.text == BrigadeGateway[0] && (txtFlat.text?.isEmpty)! {
            placeHolderMethod(Name: "Search Flat")
            Cell.list_Label.text = Aster[indexPath.row]
        }
        if txtApartment.text == BrigadeGateway[1] && (txtFlat.text?.isEmpty)! {
            placeHolderMethod(Name: "Search Flat")
            Cell.list_Label.text = Bolivia[indexPath.row]
        }
        if txtApartment.text == SalarpuriaCambridge[0] && (txtFlat.text?.isEmpty)! {
            placeHolderMethod(Name: "Search Flat")
            Cell.list_Label.text = Block1[indexPath.row]
        }
        if txtApartment.text == SalarpuriaCambridge[1] && (txtFlat.text?.isEmpty)! {
            placeHolderMethod(Name: "Search Flat")
            Cell.list_Label.text = Block2[indexPath.row]
        }
        if txtApartment.text == SalarpuriaCambridge[2] && (txtFlat.text?.isEmpty)! {
            placeHolderMethod(Name: "Search Flat")
            Cell.list_Label.text = Block3[indexPath.row]
        }
        if txtApartment.text == SalarpuriaCambridge[3] && (txtFlat.text?.isEmpty)! {
            placeHolderMethod(Name: "Search Flat")
            Cell.list_Label.text = Block4[indexPath.row]
        }
        if txtApartment.text == SalarpuriaCambridge[4] && (txtFlat.text?.isEmpty)! {
            placeHolderMethod(Name: "Search Flat")
            Cell.list_Label.text = Block5[indexPath.row]
        }
        return Cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //getting the index path of selected row
        let indexPath = tableView.indexPathForSelectedRow
        
        //getting the current cell from the index path
        let currentCell = tableView.cellForRow(at: indexPath!)! as! MyFlatTableViewCell
        
        //getting the text of that cell
        let currentItem = currentCell.list_Label.text
        
        if (txtCity.text?.isEmpty)! || !(txtCity.text?.isEmpty)! && txtSociety.isHidden == true {
            self.txtCity.text = currentItem
            lbl_Society.isHidden = false
            txtSociety.isHidden = false
            opacity_View.isHidden = true
            list_View.isHidden = true
        } else if !(txtCity.text?.isEmpty)! && (txtSociety.text?.isEmpty)! && txtApartment.isHidden == true {
            self.txtSociety.text = currentItem
            lbl_Apartment.isHidden = false
            txtApartment.isHidden = false
            opacity_View.isHidden = true
            list_View.isHidden = true
        } else if !(txtSociety.text?.isEmpty)! && (txtApartment.text?.isEmpty)! {
            self.txtApartment.text = currentItem
            lbl_Flat.isHidden = false
            txtFlat.isHidden = false
            opacity_View.isHidden = true
            list_View.isHidden = true
        } else if !(txtApartment.text?.isEmpty)! && (txtFlat.text?.isEmpty)! {
            self.txtFlat.text = currentItem
            lbl_ResidentType.isHidden = false
            segment_ResidentType.isHidden = false
            opacity_View.isHidden = true
            list_View.isHidden = true
        }
        if !(txtCity.text?.isEmpty)! && txtSociety.isHidden == true {
            self.txtCity.text = currentItem
            lbl_Society.isHidden = false
            txtSociety.isHidden = false
            opacity_View.isHidden = true
            list_View.isHidden = true
        } else if !(txtSociety.text?.isEmpty)! && txtApartment.isHidden == true {
            self.txtSociety.text = currentItem
            lbl_Apartment.isHidden = false
            txtApartment.isHidden = false
            opacity_View.isHidden = true
            list_View.isHidden = true
        } else if !(txtApartment.text?.isEmpty)! && txtFlat.isHidden == true {
            self.txtApartment.text = currentItem
            lbl_Flat.isHidden = false
            txtFlat.isHidden = false
            opacity_View.isHidden = true
            list_View.isHidden = true
        } else if !(txtFlat.text?.isEmpty)! && lbl_ResidentType.isHidden == true {
            self.txtFlat.text = currentItem
            lbl_ResidentType.isHidden = false
            segment_ResidentType.isHidden = false
            opacity_View.isHidden = true
            list_View.isHidden = true
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func placeHolderMethod(Name : String) {
        // Set the Font
        placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedStringKey.font :UIFont(name: "Palatino-Italic", size: 15.0)!])
        search_TextField.attributedPlaceholder = placeHolder
    }
}
