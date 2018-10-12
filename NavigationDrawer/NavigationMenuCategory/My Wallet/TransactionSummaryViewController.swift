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
    
    @IBOutlet weak var btn_Copy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: "Transaction Summary")
        self.navigationItem.rightBarButtonItem = nil
        
        btn_Copy.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        NAShadowEffect().shadowEffectForView(view: transactionID_Parent_View)
        NAShadowEffect().shadowEffectForView(view: transaction_Amount_ParentView)
    }
}
