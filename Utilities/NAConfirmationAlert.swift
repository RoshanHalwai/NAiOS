//
//  NAConfirmationAlert.swift
//  nammaApartment
//
//  Created by Sundir Talari on 14/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAConfirmationAlert: NSObject {
    
    func showConfirmationDialog(VC: UIViewController, Title: String, Message: String, CancelStyle: UIAlertActionStyle, OkStyle: UIAlertActionStyle, OK: ((UIAlertAction) -> Void)?, Cancel: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: Title , message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: CancelStyle, handler: Cancel))
        alert.addAction(UIAlertAction(title: "OK", style: OkStyle, handler: OK))
        alert.view.backgroundColor = UIColor.white
        alert.view.layer.cornerRadius = 10
        VC.present(alert, animated: true)
    }
    
    func showNotificationDialog(VC : UIViewController, Title: String, Message: String, OkStyle: UIAlertActionStyle, OK: ((UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: OkStyle, handler: OK))
        alert.view.backgroundColor = UIColor.white
        alert.view.layer.cornerRadius = 10
        VC.present(alert, animated: true)
    }
}
