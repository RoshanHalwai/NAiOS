//
//  MyWalletViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/23/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Razorpay
import FirebaseDatabase

class MyWalletViewController: NANavigationViewController,RazorpayPaymentCompletionProtocol {
    
    @IBOutlet weak var nammaApartment_CardView: UIView!
    @IBOutlet weak var payFor_CardView: UIView!
    @IBOutlet weak var myAccount_CardView: UIView!
    @IBOutlet weak var buttonBackGroundView: UIView!
    
    @IBOutlet weak var lbl_nammaApartment: UILabel!
    @IBOutlet weak var lbl_payFor: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_myTransactions: UILabel!
    
    @IBOutlet weak var img_indianRupee: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView_AmountDue: UIStackView!
    
    @IBOutlet weak var btn_SocietyServices: UIButton!
    @IBOutlet weak var lbl_Cost: UILabel!
    @IBOutlet weak var lbl_AmoutDue: UILabel!
    @IBOutlet weak var lbl_Rs: UILabel!
    @IBOutlet weak var lbl_Maintenance: UILabel!
    
    var navTitle = String()
    var pendingAmount = 0
    var pendingDueAmount = String()
    var maintenanceCost = Int()
    var currentComponents = DateComponents()
    var convenienceFee: Float = 0.0
    var periodArray = [String]()
    var periodString = String()
    
    //created varible for razorPay
    var razorpay: Razorpay!
    var paymentDescription = String()
    var getUserMobileNumebr = String()
    var getUserEmailID = String()
    var getUserPendingAmount = String()
    var gettingPercentageAmount = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Payment Gateway Namma Apartment API KEY for Transactions
        razorpay = Razorpay.initWithKey("rzp_live_NpHSQJwSuvSIts", andDelegate: self)
        
        storingPendingDues()
        
        //Retrieving Firebase Data in Pending Dues
        retrievingPendingDues()
        
        getUserMobileNumebr = (GlobalUserData.shared.personalDetails_Items.first?.getphoneNumber())!
        getUserEmailID = (GlobalUserData.shared.personalDetails_Items.first?.getemail())!
        
        //Setting label fonts
        lbl_nammaApartment.font = NAFont().headerFont()
        lbl_payFor.font = NAFont().headerFont()
        lbl_description.font = NAFont().lato_Regular_16()
        lbl_myTransactions.font = NAFont().lato_Regular_20()
        btn_SocietyServices.titleLabel?.font = NAFont().lato_Regular_16()
        
        lbl_Maintenance.font = NAFont().lato_Regular_16()
        lbl_Cost.font = NAFont().labelFont()
        lbl_Rs.font = NAFont().labelFont()
        
        lbl_nammaApartment.text = NAString().nammaApartments_E_Payment()
        lbl_description.text = NAString().wallet_Description()
        lbl_payFor.text = NAString().make_payment_For()
        
        //Setting View Shadow Effect
        NAShadowEffect().shadowEffectForView(view: myAccount_CardView)
        NAShadowEffect().shadowEffectForView(view: payFor_CardView)
        NAShadowEffect().shadowEffectForView(view: nammaApartment_CardView)
        
        //Setting Button Shadow Effect
        NAShadowEffect().shadowEffectForButton(button:btn_SocietyServices)
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0)
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        myAccount_CardView.isUserInteractionEnabled = true
        myAccount_CardView.addGestureRecognizer(tap)
        
        let currentDate = NSDate()
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "MM-dd-yyyy"
        
        let currentCalendar = Calendar.current
        currentComponents = currentCalendar.dateComponents([.year, .month, .day], from: currentDate as Date)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let transactionsVC = NAViewPresenter().myTransactionVC()
        transactionsVC.navTitle = NAString().transactions()
        self.navigationController?.pushViewController(transactionsVC, animated: true)
    }
    
    @IBAction func apartmentServicesAction(_ sender: Any) {
        paymentDescription = NAString().Apartment_Services_Title()
        showPaymentUI()
    }
    
    @IBAction func societyServicesAction(_ sender: Any) {
        paymentDescription = NAString().society_Services_Title()
        
        if self.lbl_Maintenance.text == NAString().noPendingDues() {
            NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().no_Dues_Alert_Title(), Message: NAString().no_Dues_Alert_Message(), buttonTitle: NAString().ok(), OkStyle: .default, OK: nil)
        } else {
            let convenienceChargesRef = Constants.FIREBASE_CONVENIENCE_CHARGES
            convenienceChargesRef.observeSingleEvent(of: .value) { (convenienceChargesSnapshot) in
                self.convenienceFee = (convenienceChargesSnapshot.value as? NSNumber)?.floatValue ?? 0
                self.gettingPercentageAmount = Double((Float(self.pendingDueAmount)! * self.convenienceFee) / 100)
                let totalAmount:Float = Float(Double(Float(self.pendingDueAmount)!) + self.gettingPercentageAmount)
                
                NAConfirmationAlert().paymentsConfirmationDialog(VC: self, Title: NAString().maintenanceBill(), Message: NAString().maintenanceAmountAlert_Message(maintenanceAmount: Int(self.pendingDueAmount)!, additionalCharges: Float(self.gettingPercentageAmount), totalAmount: (Float(totalAmount)), chargesPer: (self.convenienceFee)), CancelStyle: .default, OkStyle: .default, OK: { (action) in
                    self.showPaymentUI()
                }, Cancel: nil, cancelActionTitle: NAString().cancel().uppercased(), okActionTitle: NAString().payNow())
            }
        }
    }
    //This will call when any error occurred during transaction
    func onPaymentError(_ code: Int32, description str: String) {
        NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().failure(), Message: str, buttonTitle: NAString().ok(), OkStyle: .default, OK: nil)
        
        //Storing data in firebase in case of Transaction fail & after getting error code 0
        if code != 2 || str != NAString().paymentCancelledByUser() {
            storePaymentDetails(paymentId: "", result: NAString().failure().capitalized)
        }
    }
    
    //This will call when transaction succeed
    func onPaymentSuccess(_ payment_id: String) {
        NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().success(), Message: "Payment Id \(payment_id)", buttonTitle: NAString().ok(), OkStyle: .default, OK: nil)
        storePaymentDetails(paymentId: payment_id, result: NAString().successful())
        let pendingRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_PENDINGDUES)
        pendingRef.removeValue()
    }
    
    func storePaymentDetails(paymentId: String, result: String) {
        let userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_TRANSACTIONS)
        let transactionUID : String?
        transactionUID = (userDataRef.childByAutoId().key)
        userDataRef.child(transactionUID!).setValue(NAString().gettrue())
        
        let transactionRef = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_TRANSACTIONS).child(Constants.FIREBASE_CHILD_PRIVATE).child(transactionUID!)
        
        let transactionDetails = [
            NAUserTransactionFBKeys.amount.key :lbl_Cost.text as Any,
            NAUserTransactionFBKeys.paymentId.key : paymentId,
            NAUserTransactionFBKeys.result.key : result,
            NAUserTransactionFBKeys.serviceCategory.key : paymentDescription,
            NAUserTransactionFBKeys.timestamp.key : (Int64(Date().timeIntervalSince1970 * 1000)),
            NAUserTransactionFBKeys.uid.key : transactionUID as Any,
            NAUserTransactionFBKeys.userUID.key : userUID,
            NAUserTransactionFBKeys.period.key : self.periodString]
        transactionRef.setValue(transactionDetails)
    }
    
    //This will show the default UI of RazorPay with some user's informations.
    func showPaymentUI() {
        
        let percentageChargesInPaisa: Int = Int(self.gettingPercentageAmount * 100)
        self.pendingDueAmount = String(percentageChargesInPaisa)
        
        let pendingChargesInInt = Int(pendingDueAmount)
        let pendingAmountInInt = Int(getUserPendingAmount)
        let totalAmountInInt = pendingChargesInInt! + pendingAmountInInt!
        
        //Converting Int to String for showing in RazorPay
        let totalPendingAmount = "\(totalAmountInInt)"
        
        let options: [String:Any] = [
            "amount" : totalPendingAmount,
            "description": paymentDescription,
            "name": NAString().splash_NammaHeader_Title(),
            "prefill": [
                "contact": getUserMobileNumebr,
                "email": getUserEmailID
            ],
            ]
        razorpay.open(options)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        storingPendingDues()
    }
    
    //Storing Pending Dues in Firebase
    func storingPendingDues() {
        let maintenanceCostRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_MAINTENANCE_COST)
        maintenanceCostRef.observeSingleEvent(of: .value) { (costSnapshot) in
            self.maintenanceCost = costSnapshot.value as! Int
            
            let pendingDueRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_PENDINGDUES)
            
            let date = NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMyyyy"
            
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: date as Date)
            components.setValue(1, for: .day)
            
            if components == self.currentComponents {
                let firstDayOfMonth = calendar.date(from: components)
                let currentDueMonth = dateFormatter.string(from: firstDayOfMonth!)
                pendingDueRef.child(currentDueMonth).setValue(self.maintenanceCost)
            } 
        }
    }
    
    //Retrieving Pending Dues in Firebase
    func retrievingPendingDues() {
        let pendingDueRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_PENDINGDUES)
        pendingDueRef.observeSingleEvent(of: .value) { (pendingDueSnapshot) in
            if pendingDueSnapshot.exists() {
                let pendingDues = pendingDueSnapshot.value as? NSDictionary
                self.periodArray = (pendingDues?.allKeys as! [String]).sorted()
                if self.periodArray.count == 1 {
                    self.periodString = self.periodArray[0]
                } else {
                    self.periodString = self.periodArray.first! + "-" + self.periodArray.last!
                }
                
                for pendingDue in pendingDues! {
                    let amount = pendingDue.value as! Int
                    self.pendingAmount = self.pendingAmount + amount
                    let totalAmountInPaisa: Int = self.pendingAmount * 100
                    self.pendingDueAmount = String(self.pendingAmount)
                    self.lbl_Maintenance.text = NAString().maintenanceCost()
                    self.lbl_Cost.text = self.pendingDueAmount
                    self.getUserPendingAmount = "\(totalAmountInPaisa)"
                }
            } else {
                self.stackView_AmountDue.isHidden = true
                self.lbl_AmoutDue.isHidden = true
                self.lbl_Maintenance.text = NAString().noPendingDues()
            }
        }
    }
}
