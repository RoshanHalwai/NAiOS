//
//  GeneralSettingsViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 20/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class GeneralSettingsViewController: NANavigationViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var choose_Language_Label: UILabel!
    @IBOutlet weak var location_Services_Label: UILabel!
    @IBOutlet weak var report_A_Bug_Label: UILabel!
    @IBOutlet weak var app_Version_Label: UILabel!
    @IBOutlet weak var report_Bug_TextField: UITextField!
    @IBOutlet weak var location_Services_Switch: UISwitch!
    @IBOutlet weak var language_Btn: UIButton?
    @IBOutlet weak var language_View: UIView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var opacityView: UIView?
    
    var navTitle = String()
    //TODO: Need to Add more Languages in future.
    let languagesList = ["English","Hindi","Tamil","Kannada","Telugu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* - Assigning Font and line for text field.
         - Assigning text and Font to Labels. */
        
        language_View?.isHidden = true
        opacityView?.isHidden = true
        
        super.ConfigureNavBarTitle(title: navTitle)
        
        report_Bug_TextField.underlined()
        report_Bug_TextField.font = NAFont().textFieldFont()
        
        choose_Language_Label.text = NAString().choose_Language()
        location_Services_Label.text = NAString().location_services()
        report_A_Bug_Label.text = NAString().report_bug()
        app_Version_Label.text = NAString().app_Version()
        
        choose_Language_Label.font = NAFont().headerFont()
        location_Services_Label.font = NAFont().headerFont()
        report_A_Bug_Label.font = NAFont().headerFont()
        app_Version_Label.font = NAFont().headerFont()
        language_Btn?.titleLabel?.font = NAFont().textFieldFont()
    }
    
    /* - Calling TableView Data Source & Delegate Methods & UIView Methods.
     - Create Language Button Action. */
    
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
        language_Btn?.titleLabel?.text = language
        tableView.deselectRow(at: indexPath!, animated: true)
        opacityView?.isHidden = true
        language_View?.isHidden = true
    }
    
    @IBAction func btn_LanguageAction() {
        opacityView?.isHidden = false
        language_View?.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        opacityView?.isHidden = true
    }
}
