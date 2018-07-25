//
//  RateUsView.swift
//  nammaApartment
//
//  Created by Sundir Talari on 22/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

@IBDesignable class RateUsView:  UIView {
    var view: UIView!
    
    @IBOutlet weak var lbl_RateUs: UILabel!
    @IBOutlet weak var btn_Rate_Now: UIButton!
    @IBOutlet weak var btn_Remind_me_Later: UIButton!
    
    //Create LoadView Nib Name
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "RateUsView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    // Setting Xib
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    //Create Xib Frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
    }
    
}
