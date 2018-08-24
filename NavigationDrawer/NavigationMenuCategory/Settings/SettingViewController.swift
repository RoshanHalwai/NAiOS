//
//  SettingViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 21/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SettingViewController: NANavigationViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    @IBOutlet weak var table_View: UITableView!
    @IBOutlet weak var languages_PopUp_View: UIView!
    @IBOutlet weak var opacity_View: UIView!
    
    var navTitle = String()
    //TODO: Need to Add more Languages in future.
    let languagesList = ["English","Hindi","Tamil","Kannada","Telugu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languages_Text_Field.inputView = UIView()
        languages_Text_Field.tintColor = UIColor.clear
        bug_Text_Field.delegate = self
        languages_Text_Field.delegate = self
        
        table_View.separatorStyle = .none
        table_View.delegate = self
        table_View.dataSource = self
        
        opacity_View.isHidden = true
        languages_PopUp_View.isHidden = true
        
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
        
        //Choose languages TextField function
        languages_Text_Field.addTarget(self, action: #selector(chooseLanguagesTextField), for: UIControlEvents.touchDown)
    }
 
    //Change Admin TextField function
    @objc func chooseLanguagesTextField(textField: UITextField) {
        if textField == languages_Text_Field {
            opacity_View.isHidden = false
            languages_PopUp_View.isHidden = false
            table_View.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath)
        cell.textLabel?.text = languagesList[indexPath.row]
        
        //Label formatting & setting
        cell.textLabel?.font = NAFont().textFieldFont()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* - Getting the index path of selected row.
         - Getting the current cell from the index path.
         - Getting the text of that cell. */
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        let language = (currentCell.textLabel?.text)!
        languages_Text_Field.text = language
        tableView.deselectRow(at: indexPath!, animated: true)
        opacity_View?.isHidden = true
        languages_PopUp_View?.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        opacity_View?.isHidden = true
        languages_PopUp_View?.isHidden = true
        self.view.endEditing(true)
    }
}
