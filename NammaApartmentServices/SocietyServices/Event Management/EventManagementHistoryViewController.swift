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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title:NAString().history())

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID()) as! EventManagementHistoryTableViewCell
        
        cell.lbl_EventTitle.font = NAFont().textFieldFont()
        cell.lbl_Status.font = NAFont().textFieldFont()
        cell.lbl_EventDate.font = NAFont().textFieldFont()
        
        cell.lbl_EventTitle_Details.font = NAFont().headerFont()
        cell.lbl_Status_Details.font = NAFont().headerFont()
        cell.lbl_EventDate_Details.font = NAFont().headerFont()
        
        //cardUIView
        cell.cardView.layer.cornerRadius = 3
        cell.cardView.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cell.cardView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cell.cardView.layer.shadowRadius = 1.7
        cell.cardView.layer.shadowOpacity = 0.45
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}
