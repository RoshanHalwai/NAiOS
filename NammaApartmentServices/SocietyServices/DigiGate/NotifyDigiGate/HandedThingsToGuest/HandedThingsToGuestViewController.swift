//
//  HandedThingsToGuestViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 10/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HandedThingsToGuestViewController: NANavigationViewController,UITableViewDataSource,UITableViewDelegate {
    
    var selectedRow : Int?
    var currentTag: Int?
    var handedThingsList = [NammaApartmentVisitor]()
    var titleName =  String()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView cell move up automatically, If keyboard will appaer
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //Disable Table view cell selection & cell border line.
        tableView.allowsSelection = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //Calling Retrieval function
        retrieveHandedThingsToGuest()
        
        //Creating History icon on Navigation bar
        let historyButton = UIButton(type: .system)
        historyButton.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        historyButton.frame = CGRect(x: 0, y: 0, width: 34, height: 30)
        historyButton.addTarget(self, action: #selector(gotoHandedThingsGuestHistoryVC), for: .touchUpInside)
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
    }
    
    //To Navigate to Guest History VC
    @objc func gotoHandedThingsGuestHistoryVC() {
        let dv = NAViewPresenter().handedThingsGuestHistoryVC()
        dv.titleName = NAString().history().capitalized
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return handedThingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as! HandedThingsToGuestTableViewCell
        //Created constant variable to store all the firebase data in it.
        let nammaApartmentVisitor : NammaApartmentVisitor
        nammaApartmentVisitor = handedThingsList[indexPath.row]
        //Created local variable to store Date & Time From Firebase
        var dateTimeString : String
        dateTimeString = nammaApartmentVisitor.getdateAndTimeOfVisit()
        //Create array to split Date & Time from firebase
        let arrayOfDateTime = dateTimeString.components(separatedBy: "\t\t")
        let dateString: String = arrayOfDateTime[0]
        let timeString: String = arrayOfDateTime[1]
        
        cell.lbl_GuestTime.text = timeString
        cell.lbl_GuestDate.text = dateString
        cell.lbl_VisiterName.text = nammaApartmentVisitor.getfullName()
        
        //Calling function to get Profile Image from Firebase.
        if let urlString = nammaApartmentVisitor.getprofilePhoto() {
            NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.image_View)
        }
        
        if(nammaApartmentVisitor.getinviterUID() == userUID) {
            cell.lbl_GuestInvitedBy.text = GlobalUserData.shared.personalDetails_Items.first?.fullName
        }
        
        //assigning delegate method to textFiled
        cell.txt_Description.delegate = self
        
        //assigning title to cell Labels
        cell.lbl_Visiter.text = NAString().visitor()
        cell.lbl_Type.text = NAString().type()
        cell.lbl_Date.text = NAString().date()
        cell.lbl_Time.text = NAString().time()
        cell.lbl_Invited.text = NAString().inviter()
        
        //Label Formatting & setting
        cell.lbl_Visiter.font = NAFont().textFieldFont()
        cell.lbl_Type.font = NAFont().textFieldFont()
        cell.lbl_Date.font = NAFont().textFieldFont()
        cell.lbl_Time.font = NAFont().textFieldFont()
        cell.lbl_Invited.font = NAFont().textFieldFont()
        
        cell.lbl_VisiterName.font = NAFont().headerFont()
        cell.lbl_GuestType.font = NAFont().headerFont()
        cell.lbl_GuestDate.font = NAFont().headerFont()
        cell.lbl_GuestTime.font = NAFont().headerFont()
        cell.lbl_GuestInvitedBy.font = NAFont().headerFont()
        
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
        
        //Create Description textfield first letter capital
        cell.txt_Description.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
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
        
        //calling HistoryVC button action on particular cell
        cell.objHistoryVC = {
            //Storing Data of Handed Things to Guest.
            let visitorDataRef = Database.database().reference().child(Constants.FIREBASE_CHILD_VISITORS)
                .child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS).child(nammaApartmentVisitor.getuid())
            visitorDataRef.child(Constants.FIREBASE_HANDEDTHINGS).setValue(cell.txt_Description.text, withCompletionBlock: { (error, ref) in
                if error == nil {
                    print("Success")
                    let alert = UIAlertController(title: NAString().notify_btnClick_Alert_title(), message: NAString().notify_btnClick_Alert_message(), preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        let lv = NAViewPresenter().handedThingsGuestHistoryVC()
                        self.navigationController?.pushViewController(lv, animated: true)
                        lv.titleName = NAString().history().capitalized
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    print("Failure")
                }
            })
        }
        return cell
    }
    
    //TableView cell move up automatically, If when keyboard will appaer
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    //Create Description textfield first letter capital function
    @objc func valueChanged(sender: UITextField) {
        sender.text = sender.text?.capitalized
    }
    
    //Resizing Cell when Coming Back from History Screen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedRow = 0
        currentTag = 0
        tableView.reloadData()
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
        self.tableView.reloadData()
    }
}

extension HandedThingsToGuestViewController {
    
    //Retrieving Entered Guests data from Firebase
    func retrieveHandedThingsToGuest() {
        
        //Show Progress indicator while we retrieve user guests
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        let retrieveGuestList : RetrievingGuestList
        retrieveGuestList = RetrievingGuestList.init(pastGuestListRequired: true)
        
        //Retrieve guest of current userUID and their family members if any
        retrieveGuestList.getGuests { (guestDataList) in
            
            //Hiding Progress indicator after retrieving data.
            NAActivityIndicator.shared.hideActivityIndicator()
            
            if(guestDataList.count == 0) {
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorVisitorList())
            } else {
                for guestData in guestDataList {
                    
                    //Append only those guest data whose status is ENTERED
                    if guestData.getstatus() == NAString().entered() {
                        self.handedThingsList.append(guestData)
                    }
                }
                if(self.handedThingsList.count == 0) {
                    NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorVisitorList())
                }
                self.tableView.reloadData()
            }
        }
    }
}
