//
//  FrequentlyAskedQuestionsViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 20/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class FrequentlyAskedQuestionsViewController: NANavigationViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table_View: UITableView!
    var navTitle = String()
    
    var generalRelatedArray = [NAString().general_Updates(),
                               NAString().general_edit_userName(),
                               NAString().general_edit_emailAddress(),
                               NAString().general_edit_mobileNuber(),
                               NAString().general_Languages_Query()]
    
    var accountRelatedArray = [NAString().account_Delete_Query(),
                               NAString().account_Deactivate_Query()]
    
    var visitorsRelatedArray = [NAString().visitors_Inviting_Query(),
                                NAString().visitors_UnexpectedNotifications(),
                                NAString().visitors_Cancel_Query(),
                                NAString().visitors_Reschedule_Query(),
                                NAString().Valid_For_About()]
    
    var dailyServiceRelatedArray = [NAString().dailyService_Adding_Query(),
                                    NAString().dailyService_Remove_Query(),
                                    NAString().dailyService_Reschedule_Query()]
    
    var flatMembersRelatedArray = [NAString().flatMembers_Delete_Query(),
                                   NAString().flatMembers_Adding_Query(),
                                   NAString().flatMembers_AdminAccess_Query()]
    
    var handedThingsRelatedArray = [NAString().handedThings_Concept(),
                                    NAString().handedThings_What_Things_can_be_Handed(),
                                    NAString().handedThings_Guard_Notified_Query()]
    
    var emergencyRelatedArray = [NAString().emergencyAlarm_raising_Query(),
                                 NAString().emergencyAlarm_Actions_Query(),
                                 NAString().emergency_EstimatedTime_Query()]
    var plumberRelatedArray = [NAString().societyServiceNotAvailable(serviceName: NAString().plumber()),
                               NAString().SocietyService_EstimatedTime_Query(Service: NAString().plumber())]
    
    var carpenterRelatedArray = [NAString().societyServiceNotAvailable(serviceName: NAString().carpenter()),
                                 NAString().SocietyService_EstimatedTime_Query(Service: NAString().carpenter())]
    
    var electricianRelatedArray = [NAString().societyServiceNotAvailable(serviceName: NAString().electrician()),
                                   NAString().SocietyService_EstimatedTime_Query(Service: NAString().electrician())]
    
    var garbageRelatedArray = [NAString().SocietyService_Approval_Query(Service: NAString().garbage()),
                               NAString().SocietyService_EstimatedTime_Query(Service: NAString().garbage_Collector())]
    
    var eventsRelatedArray = [NAString().SocietyService_Approval_Query(Service: NAString().event_management()),
                              NAString().event_Reschedule_Query()]
    
    var notificationRelatedArray = [NAString().notification_InternetConnection_Issue(),
                                    NAString().notification_Query(),
                                    NAString().notification_InternetFine_But_NotificationIssue(),
                                    NAString().notification_Setting_ON_But_Issue(),
                                    NAString().receiveNotifications_With_delay()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        table_View.delegate = self
        table_View.dataSource = self
        table_View.rowHeight = UITableViewAutomaticDimension
        table_View.estimatedRowHeight = UITableViewAutomaticDimension
        table_View.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return generalRelatedArray.count
        } else if section == 1 {
            return accountRelatedArray.count
        } else if section == 2{
            return visitorsRelatedArray.count
        } else if section == 3{
            return dailyServiceRelatedArray.count
        } else if section == 4{
            return flatMembersRelatedArray.count
        } else if section == 5{
            return handedThingsRelatedArray.count
        } else if section == 6 {
            return emergencyRelatedArray.count
        } else if section == 7 {
            return plumberRelatedArray.count
        } else if section == 8 {
            return carpenterRelatedArray.count
        } else if section == 9 {
            return electricianRelatedArray.count
        } else if section == 10 {
            return garbageRelatedArray.count
        } else if section == 11 {
            return eventsRelatedArray.count
        }
        return notificationRelatedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_View.dequeueReusableCell(withIdentifier: NAString().cellID()) as! FrequentlyAskedTableViewCell
        
        if indexPath.section == 0 {
            cell.label_View.text = generalRelatedArray[indexPath.item]
        } else if indexPath.section == 1 {
            cell.label_View.text = accountRelatedArray[indexPath.item]
        } else if indexPath.section == 2 {
            cell.label_View.text = visitorsRelatedArray[indexPath.item]
        } else if indexPath.section == 3 {
            cell.label_View.text = dailyServiceRelatedArray[indexPath.item]
        } else if indexPath.section == 4 {
            cell.label_View.text = flatMembersRelatedArray[indexPath.item]
        } else if indexPath.section == 5 {
            cell.label_View.text = handedThingsRelatedArray[indexPath.item]
        } else if indexPath.section == 6 {
            cell.label_View.text = emergencyRelatedArray[indexPath.item]
        } else if indexPath.section == 7 {
            cell.label_View.text = plumberRelatedArray[indexPath.item]
        } else if indexPath.section == 8 {
            cell.label_View.text = carpenterRelatedArray[indexPath.item]
        } else if indexPath.section == 9 {
            cell.label_View.text = electricianRelatedArray[indexPath.item]
        } else if indexPath.section == 10 {
            cell.label_View.text = garbageRelatedArray[indexPath.item]
        } else if indexPath.section == 11 {
            cell.label_View.text = eventsRelatedArray[indexPath.item]
        } else {
            cell.label_View.text = notificationRelatedArray[indexPath.item]
        }
        cell.label_View.font = NAFont().textFieldFont()
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NAString().general()
        } else if section == 1 {
            return NAString().account()
        } else if section == 2 {
            return NAString().Visitors()
        } else if section == 3 {
            return NAString().daily_Services()
        } else if section == 4 {
            return NAString().flatMembers()
        } else if section == 5 {
            return NAString().handed_Things()
        } else if section == 6 {
            return NAString().emergency()
        } else if section == 7 {
            return NAString().plumber()
        } else if section == 8 {
            return NAString().carpenter()
        } else if section == 9 {
            return NAString().electrician()
        } else if section == 10 {
            return NAString().garbage()
        } else if section == 11 {
            return NAString().event_management()
        }
        return NAString().notification()
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView, let textLabel = headerView.textLabel {
            textLabel.font = NAFont().labelFont()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexpath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexpath!) as! FrequentlyAskedTableViewCell
        print(currentCell.label_View.text as Any)
        table_View.deselectRow(at: indexPath, animated: true)
    }
}
