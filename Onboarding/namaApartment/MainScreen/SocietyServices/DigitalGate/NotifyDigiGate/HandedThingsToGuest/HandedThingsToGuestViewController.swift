//
//  HandedThingsToGuestViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 10/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HandedThingsToGuestViewController: NANavigationViewController,UITableViewDataSource,UITableViewDelegate {
    //variable taken to remove cell from list
    var selectedRow : Int?
    var currentTag: Int?
    
    @IBOutlet weak var TableView: UITableView!
    //Handed Things to my guest array for displaying card view data
    var cardImageList = [#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen")]
    var MyVisitorName = ["Vikas Nayak","Chaitanya","Vinod Kumar","Avinash"]
    var MyVisitorDate = ["May 1 2018","May 2 2018","May 3 2018","Apr 30 2017"]
    var MyVisitorType = ["Guest","Guest","Guest","Guest"]
    var MyVisitorTime = ["12:14","14:09","09:12","05:50"]
    var InvitorName = ["Vinod Kumar","Rohit Mishra","Yuvaraj","Akash Patel"]
    
    //Handed Things to My Daily Services array for displaying card view data
    var cardImageHandedThigs = [#imageLiteral(resourceName: "splashScreen")]
    var nameHandedThings = ["Ramesh"]
    var typeHandedThings = ["cook"]
    var ratingHandedThings = ["4.2"]
    var inTimeHandedThings = ["14:30"]
    var flatHandedThings = ["4"]
    
     //set title from previous page
    var titleName =  String()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Disable Table view cell selection & cell border line.
        TableView.allowsSelection = false
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (titleName == NAString().handed_things_to_my_guest().capitalized) {
            return cardImageList.count
        } else {
            return cardImageHandedThigs.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HandedThingsToGuestTableViewCell
        
            //assigning delegate method to textFiled
            cell.txt_Description.delegate = self
        
        if (titleName == NAString().handed_things_to_my_guest().capitalized) {
            cell.lbl_VisiterName.text = InvitorName[indexPath.row]
            cell.lbl_GuestDate.text = MyVisitorDate[indexPath.row]
            cell.lbl_GuestTime.text = MyVisitorTime[indexPath.row]
            cell.lbl_GuestInvitedBy.text = MyVisitorName[indexPath.row]
            cell.lbl_GuestType.text = MyVisitorType[indexPath.row]
            cell.cellImage
                .image = cardImageList[indexPath.row]
            
            //assigning title to cell Labels
            cell.lbl_Visiter.text = NAString().visitor()
            cell.lbl_Type.text = NAString().type()
            cell.lbl_Date.text = NAString().date()
            cell.lbl_Time.text = NAString().time()
            cell.lbl_Invited.text = NAString().invited_by()
        } else {
            cell.lbl_VisiterName.text = nameHandedThings[indexPath.row]
            cell.lbl_GuestType.text = typeHandedThings[indexPath.row]
            cell.lbl_GuestDate.text = ratingHandedThings[indexPath.row]
            cell.lbl_GuestTime.text = inTimeHandedThings[indexPath.row]
            cell.lbl_GuestInvitedBy.text = flatHandedThings[indexPath.row]
    
            cell.cellImage.image = cardImageHandedThigs[indexPath.row]
            
            //assigning title to cell Labels
            cell.lbl_Visiter.text = NAString().name()
            cell.lbl_Type.text = NAString().type()
            cell.lbl_Date.text = NAString().rating()
            cell.lbl_Time.text = NAString().time()
            cell.lbl_Invited.text = NAString().flats()
        }
        //Label Formatting & setting
        cell.lbl_Visiter.font = NAFont().textFieldFont()
        cell.lbl_Type.font = NAFont().textFieldFont()
        cell.lbl_Date.font = NAFont().textFieldFont()
        cell.lbl_Time.font = NAFont().textFieldFont()
        cell.lbl_Invited.font = NAFont().textFieldFont()
        
        //This creates the shadows and modifies the cards a little bit
        cell.backgroundCardView.backgroundColor = UIColor.white
        cell.contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        cell.backgroundCardView.layer.borderWidth = 1.0
        cell.backgroundCardView.layer.borderColor = UIColor.clear.cgColor
        cell.backgroundCardView.layer.cornerRadius = 8.0
        cell.backgroundCardView.layer.masksToBounds = false
        cell.backgroundCardView.layer.shadowColor = UIColor.gray.cgColor
        cell.backgroundCardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.backgroundCardView.layer.shadowOpacity = 1
        
        cell.lbl_VisiterName.font = NAFont().headerFont()
        cell.lbl_GuestType.font = NAFont().headerFont()
        cell.lbl_GuestDate.font = NAFont().headerFont()
        cell.lbl_GuestTime.font = NAFont().headerFont()
        cell.lbl_GuestInvitedBy.font = NAFont().headerFont()
        
        cell.lbl_ThingsGiven.font = NAFont().headerFont()
        cell.lbl_Description.font = NAFont().headerFont()
        
        //TextField Formatting & setting
        cell.txt_Description.font = NAFont().textFieldFont()
        
        //Button Formatting & Setting
        cell.btn_NotifyGate.setTitle(NAString().notify_gate(), for: .normal)
        cell.btn_NotifyGate.backgroundColor = NAColor().buttonBgColor()
        cell.btn_NotifyGate.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        cell.btn_NotifyGate.titleLabel?.font = NAFont().buttonFont()
        
        //Creating black bottom line
        cell.txt_Description.underlined()
        
        //image makes round
        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.size.width/2
        cell.cellImage.clipsToBounds = true
        
        //Dynamically Change Cell Height while selecting segment Controller
        //by default which index is selected on view load
        cell.segmentSelect.tag = indexPath.row
        cell.segmentSelect.selectedSegmentIndex = 0
        
        if currentTag != nil && currentTag == indexPath.row  && selectedRow != cell.segmentSelect.selectedSegmentIndex {
            cell.segmentSelect.selectedSegmentIndex = 1
        }
        cell.segmentSelect.addTarget(self, action: #selector(selectSegment(sender:)), for: .valueChanged)
        return cell
    }
    //Dynamically Change Cell Height while selecting segment Controller
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedRow == 1  && selectedRow != nil && currentTag != nil && currentTag == indexPath.row {
            return HandedThingsToGuestTableViewCell.expandedHeight
        } else {
            return HandedThingsToGuestTableViewCell.defaultHeight
        }
    }
    //Dynamically Change Cell Height while selecting segment Controller
    @objc func selectSegment(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedRow = 0
        } else {
            selectedRow = 1
        }
        currentTag = sender.tag
        self.TableView.reloadData()
    }
}
