//
//  EventManagementHistoryViewController.swift
//  nammaApartment
//
//  Created by kalpana on 9/20/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventManagementHistoryViewController: NANavigationViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var getEventUID = String()
    
    var userEventManagementDetails = [NAEventManagement]()
    var timeSlotsArry = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        retrieveUserBookedSlots()
        
        tableView.separatorStyle = .none
        self.ConfigureNavBarTitle(title:NAString().history())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEventManagementDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID()) as! EventManagementHistoryTableViewCell
        
        var eventDetails : NAEventManagement
        eventDetails = userEventManagementDetails[indexPath.row]
        
        cell.stackView_8AM_11AM.isHidden = true
        cell.stackView_11AM_2PM.isHidden = true
        cell.stackView_2PM_5PM.isHidden = true
        cell.stackView_5PM_8PM.isHidden = true
        cell.stackView_8PM_FullDay.isHidden = true
        
        cell.lbl_EventTitle_Details.text = eventDetails.getTitle()
        cell.lbl_EventDate_Details.text = eventDetails.getDate()
        cell.lbl_Status_Details.text = eventDetails.getCategory()
        
        let timeSlotsArray = eventDetails.getTimeSlot().sorted()
        var index = 0
        for label in cell.lbl_SelectedSlots {
            if index != timeSlotsArray.count {
                label.text = timeSlotsArray[index]
                index = index + 1
            } else {
                break
            }
        }
        
        cell.lbl_EventTitle.font = NAFont().textFieldFont()
        cell.lbl_Status.font = NAFont().textFieldFont()
        cell.lbl_EventDate.font = NAFont().textFieldFont()
        
        cell.lbl_EventTitle_Details.font = NAFont().headerFont()
        cell.lbl_Status_Details.font = NAFont().headerFont()
        cell.lbl_EventDate_Details.font = NAFont().headerFont()
        
        NAShadowEffect().shadowEffectForView(view: cell.cardView)
        
        for label in cell.lbl_SelectedSlots {
            if (label.text?.isEmpty)! {
                label.isHidden = true
            } else {
                label.isHidden = false
            }
        }
        
        for label in cell.lbl_8AM_11AM {
            if !((label.text?.isEmpty)!) {
                cell.stackView_8AM_11AM.isHidden = false
            }
        }
        
        for label in cell.lbl_11AM_2PM {
            if !((label.text?.isEmpty)!) {
                cell.stackView_11AM_2PM.isHidden = false
            }
        }
        
        for label in cell.lbl_2PM_5PM {
            if !((label.text?.isEmpty)!) {
                cell.stackView_2PM_5PM.isHidden = false
            }
        }
        
        for label in cell.lbl_5PM_8PM {
            if !((label.text?.isEmpty)!) {
                cell.stackView_5PM_8PM.isHidden = false
            }
        }
        
        for label in cell.lbl_8PM_FullDay {
            if !((label.text?.isEmpty)!) {
                cell.stackView_8PM_FullDay.isHidden = false
            }
        }
        
        for label in cell.lbl_SelectedSlots {
            label.backgroundColor = UIColor.white
            NAShadowEffect().shadowEffectForButton(label: label)
        }
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func retrieveUserBookedSlots() {
        
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        let userDataEventRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION)
        userDataEventRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                userDataEventRef.child(Constants.FIREBASE_CHILD_EVENT_MANAGEMENT).observeSingleEvent(of: .value, with: { (eventSnapshot) in
                    if eventSnapshot.exists() {
                        let eventsUID = eventSnapshot.value as! NSDictionary
                        for eventUID in eventsUID.allKeys {
                            let eventManagementRef = Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL.child(eventUID as! String)
                            eventManagementRef.observeSingleEvent(of: .value, with: { (eventDetailsSnapshot) in
                                let eventsData = eventDetailsSnapshot.value as! [String: AnyObject]
                                
                                let eventTitle = eventsData[NAEventManagementFBKeys.eventTitle.key]
                                let eventDate = eventsData[NAEventManagementFBKeys.eventDate.key]
                                let eventCategory = eventsData[NAEventManagementFBKeys.category.key]
                                eventManagementRef.child(NAEventManagementFBKeys.timeSlots.key).observeSingleEvent(of: .value, with: { (timeSlotSnapshot) in
                                    let timeSlots = timeSlotSnapshot.value as! NSDictionary
                                    self.timeSlotsArry = timeSlots.allKeys as! [String]
                                    
                                    let userData = NAEventManagement(title: (eventTitle as! String), date: (eventDate as! String), timeSlot: self.timeSlotsArry, status: nil, category: eventCategory as? String)
                                    self.userEventManagementDetails.append(userData)
                                    NAActivityIndicator.shared.hideActivityIndicator()
                                    self.tableView.reloadData()
                                })
                            })
                        }
                    } else {
                        NAActivityIndicator.shared.hideActivityIndicator()
                        NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorEventManagementHistory())
                    }
                })
            }
        })
    }
}
