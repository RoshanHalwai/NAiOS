//
//  OpacityView.swift
//  nammaApartment
//
//  Created by kalpana on 7/14/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class OpacityView {
    
    static let shared = OpacityView()
    
    var popupView: PopupView!
    var opacityView = UIView()
    var navTitle: String?
    
    func showingOpacityView(view: UIViewController) {
        opacityView.frame = CGRect(x: 0, y: 0, width: view.view.frame.size.width, height: view.view.frame.size.height)
        opacityView.backgroundColor = UIColor.black
        opacityView.alpha = 0.7
        view.view.addSubview(opacityView)
    }
    
    func showingPopupView(view: UIViewController) {
        popupView = PopupView(frame: CGRect(x: 0, y:0, width: 300, height: 150))
        popupView.center.x = opacityView.bounds.width/2
        popupView.center.y = opacityView.bounds.height/2
        popupView.lbl_Message.text = NAString().addButtonloadViewMessage()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        view.view.addSubview(popupView)
        self.popupViewTitle()
    }
    
    func popupViewTitle() {
        popupView.lbl_Title.font = NAFont().headerFont()
        popupView.lbl_Message.font = NAFont().popupViewFont()
        if (navTitle == NAString().invite_visitors()) {
            popupView.lbl_Title.text = NAString().inviteButtonloadViewTitle()
        } else if (navTitle == NAString().addFamilyMemberTitle()) {
            popupView.lbl_Title.text = NAString().btn_mySweet_home()
        } else {
            popupView.lbl_Title.text = NAString().addButtonDailyServicesloadViewTitle()
        }
    }
    
    func hidingPopupView() {
        popupView.isHidden = true
    }
    
    func hidingOpacityView() {
        opacityView.isHidden = true
    }
    
}
