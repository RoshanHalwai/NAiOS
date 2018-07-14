//
//  PopupView.swift
//  nammaApartment
//
//  Created by kalpana on 7/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

@IBDesignable class PopupView: UIView {
    
    var view:UIView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //Create Loadview Nib Name
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PopupView", bundle: bundle)
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
