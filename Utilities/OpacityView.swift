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
    var navTitle: String?
    var addButtonTagValue : Int = NAString().zero_length()
    var opacityView = UIView()
    
    //Create showing popup view
    func showingOpacityView(view: UIViewController) {
        opacityView.frame = CGRect(x: 0, y:0, width:view.view.frame.width, height: view.view.frame.height)
        opacityView.backgroundColor = UIColor.black
        opacityView.alpha = 0.5
        view.view.addSubview(opacityView)
    }
    
    //Create showing popup view
    func showingPopupView(view: UIViewController) {
        popupView = PopupView(frame: CGRect(x: 0, y:0, width: 250, height: 150))
        popupView.center.x = view.view.bounds.width/2
        popupView.center.y = view.view.bounds.height/2
        popupView.lbl_Message.text = NAString().addButtonloadViewMessage()
        self.popupViewTitle()
        popupView.layer.cornerRadius = CGFloat(NAString().popupViewCornerRadius())
        popupView.layer.masksToBounds = true
        view.view.addSubview(popupView)
    }
    
    //Create popup view label title
    func popupViewTitle() {
        popupView.lbl_Title.font = NAFont().headerFont()
        popupView.lbl_Message.font = NAFont().popupViewFont()
        if addButtonTagValue == NAString().inviteButtonTagValue() {
            popupView.lbl_Title.text = NAString().inviteButtonloadViewTitle()
        } else if addButtonTagValue == NAString().addMyFamilyMemberButtonTagValue() {
            popupView.lbl_Title.text = NAString().addFamilyMemberTitle()
        } else if addButtonTagValue == NAString().addMyDailyServicesButtonTagValue() {
            popupView.lbl_Title.text = NAString().addButtonDailyServicesloadViewTitle()
        }
        else if addButtonTagValue == NAString().verifyOTPButtonTagValue() {
            popupView.lbl_Title.text = NAString().verifyingOTPDescription()
        }
        else if addButtonTagValue == NAString().continueButtonTagValue() {
            popupView.lbl_Title.text = NAString().verifyingAccountDescription()
        }
    }
    
    //Create hiding popup view
    func hidingPopupView() {
        popupView.isHidden = true
    }
    
    //Create hiding Opacity view
    func hidingOpacityView() {
        opacityView.isHidden = true
    }
}
