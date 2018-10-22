//
//  NANavigationViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 14/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Foundation
import Contacts
import ContactsUI

class NANavigationViewController: UIViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackBarButton()
        configureInfoButton()
        //configureHistoryButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func configureInfoButton() {
        let infoButton = UIButton(type: .system)
        infoButton.setImage(#imageLiteral(resourceName: "infoButton"), for: .normal)
        infoButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
    }
    
    func configureBackBarButton() {
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "backBarButton"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func ConfigureNavBarTitle(title: String)
    {
        let name = UILabel()
        name.text = title
        name.textColor =  UIColor.white
        name.textAlignment = .center
        name.font = NAFont().viewTitleFont()
        navigationItem.titleView = name
    }
    
    //For Hiding NumberPad when done pressed
    func hideNumberPad(numberTextField : UITextField) {
        //Created toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(hideNumberKeyboard))
        toolbar.setItems([done], animated: false)
        numberTextField.inputAccessoryView = toolbar
    }
    
    @objc func hideNumberKeyboard() {
        self.view.endEditing(true)
    }
}

extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //to get Images from both Camera and Gallery
    func toSelectImages(VC: UIViewController) {
        let actionSheet = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title:NAString().camera(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = VC
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            pickerController.allowsEditing = true
            VC.present(pickerController, animated: true, completion: nil)
        })
        let actionGallery = UIAlertAction(title:NAString().gallery(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = VC
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pickerController.allowsEditing = true
            VC.present(pickerController, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title:NAString().cancel(), style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in})
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionGallery)
        actionSheet.addAction(cancel)
        actionSheet.view.tintColor = UIColor.black
        VC.present(actionSheet, animated: true, completion: nil)
    }
    
    //to get images from only Gallery
    func toselectFromGallery(VC: UIViewController) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionGallery = UIAlertAction(title:NAString().gallery(), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let pickerController = UIImagePickerController()
            pickerController.delegate = VC
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pickerController.allowsEditing = true
            
            self.present(pickerController, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: NAString().cancel(), style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        actionSheet.addAction(actionGallery)
        actionSheet.addAction(cancel)
        
        actionSheet.view.tintColor = UIColor.black
        VC.present(actionSheet, animated: true, completion: nil)
    }
}

extension UIViewController : CNContactPickerDelegate {
    func toSelectContacts(VC : UIViewController) {
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        
        if authStatus == CNAuthorizationStatus.notDetermined {
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: { (success, nil) in
                
                if success {
                    self.openContacts(VC: VC)
                }
            })
        } else if authStatus == CNAuthorizationStatus.authorized {
            self.openContacts(VC: VC)
        }
            //Open App Setting if user cannot able to access Contacts
        else if authStatus == CNAuthorizationStatus.denied {
            NAConfirmationAlert().showConfirmationDialog(VC: VC, Title: NAString().setting_Permission_AlertBox(), Message: "", CancelStyle: .cancel, OkStyle: .default, OK: { (action) in
                let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.shared.open(settingsUrl)
            }, Cancel: { (action) in
            }, cancelActionTitle: NAString().cancel(), okActionTitle: NAString().settings())
        }
    }
    
    //to call default address book app
    func openContacts(VC: UIViewController) {
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        //uses did select method here
        VC.present(contactPicker, animated: true, completion: nil)
    }
}
