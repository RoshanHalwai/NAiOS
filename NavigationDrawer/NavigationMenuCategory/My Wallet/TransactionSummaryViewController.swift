//
//  TransactionSummaryViewController.swift
//  nammaApartment
//
//  Created by kirtan labs on 12/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class TransactionSummaryViewController: NANavigationViewController {
    
    @IBOutlet weak var transactionID_Parent_View: UIView!
    @IBOutlet weak var transaction_Amount_ParentView: UIView!
    @IBOutlet weak var contact_Us_ParentView: UIView!
    @IBOutlet weak var lbl_Successful_title: UILabel!
    @IBOutlet weak var lbl_PaymentID: UILabel!
    @IBOutlet weak var lbl_Transaction_Period: UILabel!
    @IBOutlet weak var lbl_Transaction_Date: UILabel!
    @IBOutlet weak var lbl_Total_Amount: UILabel!
    @IBOutlet weak var status_ImageView: UIImageView!
    @IBOutlet weak var btn_Copy: UIButton!

    var transactionUID = String()
    var transactionDate = String()
    var totalAmount = Float()
    var status = String()
    var transactionPeriod = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: NAString().transactionSummary())
        self.navigationItem.rightBarButtonItem = nil
        
        lbl_PaymentID.text = transactionUID
        lbl_Total_Amount.text = String(totalAmount)
        lbl_Transaction_Date.text = transactionDate
        lbl_Transaction_Period.text = transactionPeriod
        
        if status == NAString().successful() {
            transactionID_Parent_View.isHidden = false
            status_ImageView.image = #imageLiteral(resourceName: "checked")
            lbl_Successful_title.text = NAString().transactionSummary_Success_Title()
        } else {
            transactionID_Parent_View.isHidden = true
            status_ImageView.image = #imageLiteral(resourceName: "Cancel")
            lbl_Successful_title.text = NAString().transactionSummary_Failed_Title()
            lbl_Successful_title.textColor = UIColor.red
        }
        
        btn_Copy.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        
        NAShadowEffect().shadowEffectForView(view: transactionID_Parent_View)
        NAShadowEffect().shadowEffectForView(view: transaction_Amount_ParentView)
        NAShadowEffect().shadowEffectForView(view: contact_Us_ParentView)
    }
    
    @IBAction func btn_Copy_Action(_ sender: UIButton) {
        //Copying paymentID to clipboard
        let pasteboard = UIPasteboard.general
        pasteboard.string = lbl_PaymentID.text
    }
}
