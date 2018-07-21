//
//  NotificationSettingsViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 20/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class NotificationSettingsViewController: NANavigationViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table_View: UITableView!
    var navTitle = String()
    var notificationsArray = [NAString().new_Message_Notification(), NAString().email_Notification(), NAString().vibrate(), NAString().enable_inApp_Sound_Notification(), NAString().product_Updates()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table_View.separatorStyle = .none
        super.ConfigureNavBarTitle(title: navTitle)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as! NotificationSettingsTableViewCell
        cell.labelView.text = notificationsArray[indexPath.row]
        cell.labelView.font = NAFont().headerFont()
        return cell
    }

}
