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
    
    var UserDetails = [NammaApartmentVisitor]()
    var selectedRow : Int?
    var currentTag: Int?
    var Vistitor_UID = [String]()
    var Vistitor_Main_UIDs = [String]()
    var userDataRef : DatabaseReference?
    var visitorDataRef : DatabaseReference?
    var handedThingsList = [NammaApartmentVisitor]()
    var enteredGuestsUIDList = [EneteredGuestUIDList]()
    var visitorsUIDCount = 0
    @IBOutlet weak var TableView: UITableView!
    var titleName =  String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Disable Table view cell selection & cell border line.
        TableView.allowsSelection = false
        self.TableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
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
        //Create constant variable to store all the firebase data in it.
        let nammaApartmentVisitor : NammaApartmentVisitor
        nammaApartmentVisitor = handedThingsList[indexPath.row]
        //Create local variable to store Date & Time From Firebase
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
        //cell.txt_Description.delegate = self
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
            let alert = UIAlertController(title: NAString().notify_btnClick_Alert_title(), message: NAString().notify_btnClick_Alert_message(), preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                let lv = NAViewPresenter().handedThingsGuestHistoryVC()
                self.navigationController?.pushViewController(lv, animated: true)
                lv.titleName = NAString().history().capitalized
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
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
extension HandedThingsToGuestViewController {
    //Retrieving Entered Guests from Firebase
    //TODO: Need to use CallBack methods for showing error layout message also when no guest entered.
    func retrieveHandedThingsToGuest() {
        
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        userDataRef = GlobalUserData.shared.getUserDataReference()
            .child(Constants.FLAT_Visitor).child(userUID)
        
        userDataRef?.observeSingleEvent(of: .value, with: {(snapshot) in
            
            if snapshot.exists() {
                let visitorsUID = snapshot.value as? NSDictionary
                for visitorUID in (visitorsUID?.allKeys)! {
                    self.visitorsUIDCount = self.visitorsUIDCount + 1
                    
                    self.visitorDataRef =  Database.database().reference().child(Constants.FIREBASE_CHILD_VISITORS).child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS)
                        .child(visitorUID as! String)
                    
                    self.visitorDataRef?.observeSingleEvent(of: .value, with: {(snapshot) in
                        print(snapshot)
                        
                        let visitorData = snapshot.value as? [String: AnyObject]
                        let status = visitorData?[VisitorListFBKeys.status.key] as? String
                        if status == NAString().entered() {
                            let dateAndTimeOfVisit = visitorData?[VisitorListFBKeys.dateAndTimeOfVisit.key] as? String
                            let fullName = visitorData?[VisitorListFBKeys.fullName.key] as? String
                            let inviterUID = visitorData?[VisitorListFBKeys.inviterUID.key] as? String
                            let mobileNumber = visitorData?[VisitorListFBKeys.mobileNumber.key] as? String
                            let profilePhoto = visitorData?[VisitorListFBKeys.profilePhoto.key] as? String
                            let uid = visitorData?[VisitorListFBKeys.uid.key] as? String
                            print(uid as Any)
                            let enteredUser = EneteredGuestUIDList(uid: uid)
                            self.enteredGuestsUIDList.append(enteredUser)
                            print("For Data",self.enteredGuestsUIDList)
                            let user = NammaApartmentVisitor(dateAndTimeOfVisit: dateAndTimeOfVisit , fullName: fullName , inviterUID: inviterUID , mobileNumber: mobileNumber , profilePhoto: profilePhoto , status: status, uid: uid)
                            self.handedThingsList.append(user)
                            NAActivityIndicator.shared.hideActivityIndicator()
                            self.TableView.reloadData()
                            
                            if(self.visitorsUIDCount == visitorsUID?.count) {
                                if (self.enteredGuestsUIDList.count == 0) {
                                    NAActivityIndicator.shared.hideActivityIndicator()
                                    NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorVisitorList())
                                }
                            }
                        }
                    })
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorVisitorList())
            }
        })
    }
}
