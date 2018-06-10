//
//  customAlertView.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 10/06/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class customAlertView: UIView {
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var alertMessage: UILabel!
    @IBOutlet weak var btn_alertReject: UIButton!
    @IBOutlet weak var btn_alertAccept: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        commitInit()
    }
    
    private func commitInit()
    {
        Bundle.main.loadNibNamed("customAlertView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func btnReject(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func btnAccept(_ sender: UIButton) {
        
        let lv = NAViewPresenter().otpViewController()
        let navi = UINavigationController()
        navi.pushViewController(lv, animated: true)
        
    }

}
