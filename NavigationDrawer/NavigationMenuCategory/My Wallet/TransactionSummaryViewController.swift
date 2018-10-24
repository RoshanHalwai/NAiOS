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
    
    var fromInvitingTransactionsSummaryVC = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: NAString().transactionSummary())
        self.navigationItem.rightBarButtonItem = nil
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        contact_Us_ParentView.isUserInteractionEnabled = true
        contact_Us_ParentView.addGestureRecognizer(tap)
        
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
        
        //created custom back button for goto My DigiGate
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToDigitGate))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //Navigating Back to digi gate according to Screen coming from
    @objc func goBackToDigitGate() {
        if fromInvitingTransactionsSummaryVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-3]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //Create Guesture Function
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let transactionContactUsVC = NAViewPresenter().transactionContactUsVC()
        transactionContactUsVC.navTitle = NAString().contactUs()
        self.navigationController?.pushViewController(transactionContactUsVC, animated: true)
    }
    
    @IBAction func btn_Copy_Action(_ sender: UIButton) {
        //Copying paymentID to clipboard
        let pasteboard = UIPasteboard.general
        pasteboard.string = lbl_PaymentID.text
    }
}
