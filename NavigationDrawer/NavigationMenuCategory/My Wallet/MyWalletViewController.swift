//
//  MyWalletViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/23/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Razorpay

class MyWalletViewController: NANavigationViewController,RazorpayPaymentCompletionProtocol {
    
    @IBOutlet weak var nammaApartment_CardView: UIView!
    @IBOutlet weak var payFor_CardView: UIView!
    @IBOutlet weak var myAccount_CardView: UIView!
    
    @IBOutlet weak var lbl_nammaApartment: UILabel!
    @IBOutlet weak var lbl_payFor: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_myTransactions: UILabel!
    
    @IBOutlet weak var img_indianRupee: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btn_SocietyServices: UIButton!
    @IBOutlet weak var btn_ApartmentServices: UIButton!
    
    var navTitle = String()
    
    //created varible for razorPay
    var razorpay: Razorpay!
    var paymentDescription = String()
    var getUserMobileNumebr = String()
    var getUserEmailID = String()
    var getUserPendingAmount = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Payment Gateway test API KEY
        razorpay = Razorpay.initWithKey("rzp_test_GCFVAY6RGbNWyb", andDelegate: self)
        
        getUserMobileNumebr = (GlobalUserData.shared.personalDetails_Items.first?.getphoneNumber())!
        getUserEmailID = (GlobalUserData.shared.personalDetails_Items.first?.getfullName())!
        
        //TODO: Hardcoded Amount,but will change it later after completing Amount UI in My wallet Screen
        getUserPendingAmount = "100"
       
        //Setting label fonts
        lbl_nammaApartment.font = NAFont().headerFont()
        lbl_payFor.font = NAFont().headerFont()
        lbl_description.font = NAFont().lato_Regular_16()
        lbl_myTransactions.font = NAFont().lato_Regular_20()
        btn_ApartmentServices.titleLabel?.font = NAFont().lato_Regular_16()
        btn_SocietyServices.titleLabel?.font = NAFont().lato_Regular_16()
        
        lbl_nammaApartment.text = NAString().nammaApartments_E_Payment()
        lbl_description.text = NAString().wallet_Description()
        lbl_payFor.text = NAString().make_payment_For()
        
        //Setting View Shadow Effect
        NAShadowEffect().shadowEffectForView(view: myAccount_CardView)
        NAShadowEffect().shadowEffectForView(view: payFor_CardView)
        NAShadowEffect().shadowEffectForView(view: nammaApartment_CardView)
        
        //Setting Button Shadow Effect
        NAShadowEffect().shadowEffectForButton(button:btn_ApartmentServices)
        NAShadowEffect().shadowEffectForButton(button:btn_SocietyServices)
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0)
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
    }
    
    @IBAction func apartmentServicesAction(_ sender: Any) {
        paymentDescription = NAString().Apartment_Services_Title()
        showPaymentUI()
    }
    
    @IBAction func societyServicesAction(_ sender: Any) {
        paymentDescription = NAString().society_Services_Title()
        showPaymentUI()
    }
    
    //This will call when any error occurred during transaction
    func onPaymentError(_ code: Int32, description str: String) {
        NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().failure(), Message: str, OkStyle: .default, OK: nil)
    }
    
     //This will call when transaction succeed
    func onPaymentSuccess(_ payment_id: String) {
        NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().success(), Message: "Payment Id \(payment_id)", OkStyle: .default, OK: nil)
    }
    
    //This will show the default UI of RazorPay with some user's informations.
    func showPaymentUI() {
        let options: [String:Any] = [
            "amount" : getUserPendingAmount,
            "description": paymentDescription,
            "name": NAString().splash_NammaHeader_Title(),
            "prefill": [
            "contact": getUserMobileNumebr,
            "email": getUserEmailID
            ],
            "theme": [
                "color": "#F37254"
            ]
        ]
        razorpay.open(options)
    }
}
