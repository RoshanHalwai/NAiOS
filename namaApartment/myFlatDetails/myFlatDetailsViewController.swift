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
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var txtApartment: UITextField!
    @IBOutlet weak var txtSociety: UITextField!
    @IBOutlet weak var txtFlat: UITextField!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var segmentResidentType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       // self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Set Textfield bottom border line
        txtCity.underlinedMyFlatDetails()
        txtFlat.underlinedMyFlatDetails()
        txtSociety.underlinedMyFlatDetails()
        txtApartment.underlinedMyFlatDetails()
        //keyboard will appear when textfield got focus
        
        txtCity.becomeFirstResponder()
        
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        
       
        self.navigationItem.title = "MY FLAT DETAILS"
        

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func btnContinue(_ sender: Any)
    {
        
        
    }
    
    

}
