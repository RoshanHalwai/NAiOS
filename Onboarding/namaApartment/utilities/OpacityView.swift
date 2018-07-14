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
    var addButtonTagValue : Int = 0
    //Create showing popup view
    func showingPopupView(view: UIViewController) {
        popupView = PopupView(frame: CGRect(x: 0, y:0, width: 300, height: 120))
        popupView.center.x = view.view.bounds.width/2
        popupView.center.y = view.view.bounds.height/2
        popupView.lbl_Message.text = NAString().addButtonloadViewMessage()
        self.popupViewTitle()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        view.view.addSubview(popupView)
    }
    //Create popup view label title
    func popupViewTitle() {
        popupView.lbl_Title.font = NAFont().headerFont()
        popupView.lbl_Message.font = NAFont().popupViewFont()
        if addButtonTagValue == 101 {
            popupView.lbl_Title.text = NAString().inviteButtonloadViewTitle()
        } else if addButtonTagValue == 102 {
            popupView.lbl_Title.text = NAString().addButtonDailyServicesloadViewTitle()
        } else {
            popupView.lbl_Title.text = NAString().addFamilyMemberTitle()
        }
    }
    //Create hiding popup view
    func hidingPopupView() {
        popupView.isHidden = true
    }
}
