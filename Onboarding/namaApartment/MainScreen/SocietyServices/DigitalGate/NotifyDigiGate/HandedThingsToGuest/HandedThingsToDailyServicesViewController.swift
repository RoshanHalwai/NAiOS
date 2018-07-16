//
//  HandedThingsToDailyServicesViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 13/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HandedThingsToDailyServicesViewController: NANavigationViewController, UITableViewDataSource, UITableViewDelegate {
    
    //variable taken to remove cell from list
    var selectedRow : Int?
    var currentTag: Int?
    
    @IBOutlet weak var TableView: UITableView!
    
    //set title from previous page
    var titleName =  String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Disable Table view cell selection & cell border line.
        TableView.allowsSelection = false
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //Creating History icon on Navigation bar
        let historyButton = UIButton(type: .system)
        historyButton.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        historyButton.frame = CGRect(x: 0, y: 0, width: 34, height: 30)
        historyButton.addTarget(self, action: #selector(gotoHandedThingsServiceHistoryVC), for: .touchUpInside)
        let history = UIBarButtonItem(customView: historyButton)
        //Creating info icon on Navigation bar
        let infoButton = UIButton(type: .system)
        infoButton.setImage(#imageLiteral(resourceName: "information24"), for: .normal)
        infoButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        let info = UIBarButtonItem(customView: infoButton)
        //created Array for history and info button icons
        self.navigationItem.setRightBarButtonItems([info,history], animated: true)
        
        //Formatting & setting navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        self.navigationItem.title = ""
        
        //created custom back button for goto My Visitors List
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToNotifyDigiGate))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //to Navigate Back to Notify digi Gate
    @objc func goBackToNotifyDigiGate() {
        let dv = NAViewPresenter().notifyDigiGateVC()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    //to Navigate to Daily Services History VC
    @objc func gotoHandedThingsServiceHistoryVC() {
        let dv = NAViewPresenter().handedThingsServiceHistoryVC()
        dv.titleName = NAString().history()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HandedThingsToDailyServicesTableViewCell
        
        //assigning delegate method to textFiled
        cell.txt_Description.delegate = self
    
        //Label Formatting & setting
        cell.lbl_Name.font = NAFont().textFieldFont()
        cell.lbl_Type.font = NAFont().textFieldFont()
        cell.lbl_Rating.font = NAFont().textFieldFont()
        cell.lbl_InTime.font = NAFont().textFieldFont()
        cell.lbl_Flats.font = NAFont().textFieldFont()
        
        cell.lbl_ServiceName.font = NAFont().headerFont()
        cell.lbl_ServiceType.font = NAFont().headerFont()
        cell.lbl_ServiceRating.font = NAFont().headerFont()
        cell.lbl_ServiceInTime.font = NAFont().headerFont()
        cell.lbl_ServiceFlats.font = NAFont().headerFont()
        
        cell.lbl_ThingsGiven.font = NAFont().headerFont()
        cell.lbl_Description.font = NAFont().headerFont()
        
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
        
        /*Dynamically Change Cell Height while selecting segment Controller
        by default which index is selected on view load*/
        cell.segmentSelect.tag = indexPath.row
        cell.segmentSelect.selectedSegmentIndex = 0
        
        if currentTag != nil && currentTag == indexPath.row  && selectedRow != cell.segmentSelect.selectedSegmentIndex {
            cell.segmentSelect.selectedSegmentIndex = 1
        }
        cell.segmentSelect.addTarget(self, action: #selector(selectSegment(sender:)), for: .valueChanged)
        
        //calling History button action on particular cell
        cell.objHistoryVC = {
            let alert = UIAlertController(title: NAString().notify_btnClick_Alert_title(), message: NAString().notify_btnClick_Alert_message(), preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                let lv = NAViewPresenter().handedThingsServiceHistoryVC()
                self.navigationController?.pushViewController(lv, animated: true)
                lv.titleName = NAString().history()
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        return cell
    }
    
    //Dynamically Change Cell Height while selecting segment Controller
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedRow == 1  && selectedRow != nil && currentTag != nil && currentTag == indexPath.row {
            return HandedThingsToDailyServicesTableViewCell.expandedHeight
        } else {
            return HandedThingsToDailyServicesTableViewCell.defaultHeight
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
