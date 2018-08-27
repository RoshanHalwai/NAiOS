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
    var visitorsScreen = false
    var dailyServicesScreen = false
    var flatMembersScreen = false
    var handedThingsScreen = false
    var emergencyScreen = false
    var plumberScreen = false
    var carpenterScreen = false
    var electricianScreen = false
    var garbageManagementScreen = false
    var eventManagementScreen = false
    
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
    
    var plumberRelatedArray = [NAString().SocietyService_Approval_Query(Service: NAString().plumber()),
                               NAString().SocietyService_EstimatedTime_Query(Service: NAString().plumber())]
    
    var carpenterRelatedArray = [NAString().SocietyService_Approval_Query(Service: NAString().carpenter()),
                                 NAString().SocietyService_EstimatedTime_Query(Service: NAString().carpenter())]
    
    var electricianRelatedArray = [NAString().SocietyService_Approval_Query(Service: NAString().electrician()),
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
    override func viewDidAppear(_ animated: Bool) {
        
        switch true {
        case visitorsScreen :
            let indexPath = IndexPath(row: 0, section: 2)
            table_View.scrollToRow(at: indexPath, at: .top, animated: true)
        case dailyServicesScreen :
            let indexPath = IndexPath(row: 0, section: 3)
            table_View.scrollToRow(at: indexPath, at: .top, animated: true)
        case flatMembersScreen :
            let indexPath = IndexPath(row: 0, section: 4)
            table_View.scrollToRow(at: indexPath, at: .top, animated: true)
        case handedThingsScreen :
            let indexPath = IndexPath(row: 0, section: 5)
            table_View.scrollToRow(at: indexPath, at: .top, animated: true)
        case emergencyScreen :
            let indexPath = IndexPath(row: 0, section: 6)
            table_View.scrollToRow(at: indexPath, at: .top, animated: true)
        case plumberScreen :
            let indexPath = IndexPath(row: 0, section: 7)
            table_View.scrollToRow(at: indexPath, at: .top, animated: true)
        case carpenterScreen :
            let indexPath = IndexPath(row: 0, section: 8)
            table_View.scrollToRow(at: indexPath, at: .top, animated: true)
        case electricianScreen :
            let indexPath = IndexPath(row: 0, section: 9)
            table_View.scrollToRow(at: indexPath, at: .top, animated: true)
        case garbageManagementScreen :
            let indexPath = IndexPath(row: 0, section: 10)
            table_View.scrollToRow(at: indexPath, at: .top, animated: true)
        case eventManagementScreen:
            let indexPath = IndexPath(row: 0, section: 11)
            table_View.scrollToRow(at: indexPath, at: .top, animated: true)
        default :
            break
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            return generalRelatedArray.count
        case 1 :
            return accountRelatedArray.count
        case 2 :
            return visitorsRelatedArray.count
        case 3 :
            return dailyServiceRelatedArray.count
        case 4 :
            return flatMembersRelatedArray.count
        case 5 :
            return handedThingsRelatedArray.count
        case 6 :
            return emergencyRelatedArray.count
        case 7 :
            return plumberRelatedArray.count
        case 8 :
            return carpenterRelatedArray.count
        case 9 :
            return electricianRelatedArray.count
        case 10 :
            return garbageRelatedArray.count
        case 11 :
            return eventsRelatedArray.count
            
        default:
            break
        }
        return notificationRelatedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_View.dequeueReusableCell(withIdentifier: NAString().cellID()) as! FrequentlyAskedTableViewCell
        
        switch indexPath.section {
        case 0 :
            cell.label_View.text = generalRelatedArray[indexPath.item]
        case 1 :
            cell.label_View.text = accountRelatedArray[indexPath.item]
        case 2 :
            cell.label_View.text = visitorsRelatedArray[indexPath.item]
        case 3 :
            cell.label_View.text = dailyServiceRelatedArray[indexPath.item]
        case 4 :
            cell.label_View.text = flatMembersRelatedArray[indexPath.item]
        case 5 :
            cell.label_View.text = handedThingsRelatedArray[indexPath.item]
        case 6 :
            cell.label_View.text = emergencyRelatedArray[indexPath.item]
        case 7 :
            cell.label_View.text = plumberRelatedArray[indexPath.item]
        case 8 :
            cell.label_View.text = carpenterRelatedArray[indexPath.item]
        case 9 :
            cell.label_View.text = electricianRelatedArray[indexPath.item]
        case 10 :
            cell.label_View.text = garbageRelatedArray[indexPath.item]
        case 11 :
            cell.label_View.text = eventsRelatedArray[indexPath.item]
        case 12 :
            cell.label_View.text = notificationRelatedArray[indexPath.item]
            
        default:
            break
        }
        cell.label_View.font = NAFont().textFieldFont()
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0 :
            return NAString().general()
        case 1 :
            return NAString().account()
        case 2 :
            return NAString().Visitors()
        case 3 :
            return NAString().daily_Services()
        case 4 :
            return NAString().flatMembers()
        case 5 :
            return NAString().handed_Things()
        case 6 :
            return NAString().emergency()
        case 7 :
            return NAString().plumber()
        case 8 :
            return NAString().carpenter()
        case 9 :
            return NAString().electrician()
        case 10 :
            return NAString().garbage()
        case 11 :
            return NAString().event_management()
        default:
            break
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
