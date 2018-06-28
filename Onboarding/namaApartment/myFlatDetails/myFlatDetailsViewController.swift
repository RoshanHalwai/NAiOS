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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hiding All items Except city item When View Loading
        btnContinue.isHidden = true
        segment_ResidentType.isHidden = true
        txtApartment.isHidden = true
        //txtSociety.isHidden = true
        txtFlat.isHidden = true
        lbl_Apartment.isHidden = true
        lbl_Flat.isHidden = true
        //lbl_Society.isHidden = true
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if txtCity.isHidden == false && txtSociety.isHidden == true {
            return city.count
        }
        if txtSociety.isHidden == false {
            return Society.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyFlatTableViewCell
        Cell.list_Label.text = "Bangalore"
        return Cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
