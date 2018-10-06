//
//  SocietyServiceRatingView.swift
//  nammaApartment
//
//  Created by Sundir Talari on 24/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import HCSStarRatingView

@IBDesignable class SocietyServiceRatingView:  UIView {
    var view: UIView!
    
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var plumber_ImageView: UIImageView!
    @IBOutlet weak var lbl_Plumber: UILabel!
    @IBOutlet weak var lbl_RateYour_Service: UILabel!
    var ratingValue = 5
    
    //Create LoadView Nib Name
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SocietyServiceRatingView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    @IBAction func didValueChange(_ sender: HCSStarRatingView) {
        ratingValue = Int(sender.value)
    }
    
    //Setting Xib
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    //Create Xib Frame
    override init(frame: CGRect) {
        ratingValue = 5
        super.init(frame: frame)
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        ratingValue = 5
        super.init(coder: aDecoder)!
        xibSetup()
    }
}

