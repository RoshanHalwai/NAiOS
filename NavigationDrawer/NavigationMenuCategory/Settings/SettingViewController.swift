//
//  SettingViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 21/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SettingViewController: NANavigationViewController {
    
    @IBOutlet weak var general_Settings_View: UIView!
    @IBOutlet weak var notification_settings_View: UIView!
    
    @IBOutlet weak var general_Settings_Label: UILabel!
    @IBOutlet weak var change_Language_Label: UILabel!
    @IBOutlet weak var sounds_Label: UILabel!
    @IBOutlet weak var location_Services_Label: UILabel!
    @IBOutlet weak var report_A_Bug_Label: UILabel!
    
    @IBOutlet weak var languages_Text_Field: UITextField!
    @IBOutlet weak var bug_Text_Field: UITextField!
    
    @IBOutlet weak var notification_Settings_Label: UILabel!
    @IBOutlet weak var new_Message_Notification_Label: UILabel!
    @IBOutlet weak var email_Notification_Label: UILabel!
    @IBOutlet weak var vibrate_Label: UILabel!
    @IBOutlet weak var enable_In_App_Label: UILabel!
    @IBOutlet weak var product_Updates_Label: UILabel!
    
    var navTitle = String()
    var selectLanguage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting TextField Delegates
        bug_Text_Field.delegate = self
        languages_Text_Field.delegate = self
        
        self.languages_Text_Field.text = selectLanguage
        languages_Text_Field.underlined()
        languages_Text_Field.inputView = UIView()
        
        self.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        //Label and TextFields Formatting and Setting
        general_Settings_Label.font = NAFont().labelFont()
        notification_Settings_Label.font = NAFont().labelFont()
        change_Language_Label.font = NAFont().headerFont()
        sounds_Label.font = NAFont().headerFont()
        location_Services_Label.font = NAFont().headerFont()
        report_A_Bug_Label.font = NAFont().headerFont()
        languages_Text_Field.font = NAFont().textFieldFont()
        
        languages_Text_Field.underlined()
        bug_Text_Field.underlined()
        
        new_Message_Notification_Label.font = NAFont().headerFont()
        email_Notification_Label.font = NAFont().headerFont()
        vibrate_Label.font = NAFont().headerFont()
        enable_In_App_Label.font = NAFont().headerFont()
        product_Updates_Label.font = NAFont().headerFont()
        bug_Text_Field.font = NAFont().textFieldFont()
        
        new_Message_Notification_Label.text = NAString().new_Message_Notification()
        email_Notification_Label.text = NAString().email_Notification()
        vibrate_Label.text = NAString().vibrate()
        enable_In_App_Label.text = NAString().enable_inApp_Sound_Notification()
        product_Updates_Label.text = NAString().product_Updates()
        
        //Creating Shadow Effect for Views
        NAShadowEffect().shadowEffectForView(view: general_Settings_View)
        NAShadowEffect().shadowEffectForView(view: notification_settings_View)
    }
    
    //Calling TextField Delegate Method
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let searchVC = NAViewPresenter().languageVC()
        let nav : UINavigationController = UINavigationController(rootViewController: searchVC)
        searchVC.navigationTitle = NAString().selectLanguage()
        searchVC.settingVC = self
        self.navigationController?.present(nav, animated: true, completion: nil)
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.languages_Text_Field.text = selectLanguage
    }
}
