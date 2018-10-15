//
//  MyVisitorListViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 07/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI
import SDWebImage

class MyGuestListViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate, MFMessageComposeViewControllerDelegate {
    
    //Created variable of DBReference for storing data in firebase
    var myVisitorListReference : DatabaseReference?
    var visitorData : DatabaseReference?
    var userDataRef : DatabaseReference?
    var myVisitorList = [NammaApartmentVisitor]()
    var VisitorUseruiD = [String]()
    
    //Created variable for NammaApartmentVisitor file to fetch data from firebase.
    @IBOutlet weak var collectionView: UICollectionView!
    var titleName = String()
    
    //A boolean variable to indicate if previous screen was Expecting Arrival.
    var fromInvitingVisitorsVC = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Progress indicator while we retrieve user guests
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        //Calling Retriving Data Function
        self.retrivingMyGuestData()
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: NAString().myVisitorViewTitle())
        
        //created custom back button for goto My DigiGate
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToDigitGate))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
        
        //Here Adding Observer Value Using NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshData(notification:)), name: Notification.Name("refreshRescheduledData"), object: nil)
       
        //info Button Action
        infoButton()
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: 220)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
    }
    
    //Create Refresh Data Function
    @objc func refreshData(notification: Notification) {
        self.myVisitorList.removeAll()
        self.retrivingMyGuestData()
    }
    
    //Create Retriving Data in My GuestList View Controller
    func retrivingMyGuestData() {
        let retrieveGuestList : RetrievingGuestList
        retrieveGuestList = RetrievingGuestList.init(pastGuestListRequired: true)
        
        //Retrieve guest of current userUID and their family members if any
        retrieveGuestList.getPreAndPostApprovedGuests { (guestDataList) in
            
            //Hiding Progress indicator after retrieving data.
            NAActivityIndicator.shared.hideActivityIndicator()
            
            if(guestDataList.count == 0) {
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorVisitorList())
            } else {
                for guestData in guestDataList {
                    //Append only those guest data
                    self.myVisitorList.append(guestData)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    //Navigating Back to digi gate according to Screen coming from
    @objc func goBackToDigitGate() {
        if fromInvitingVisitorsVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-3]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myVisitorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! MyGuestListCollectionViewCell
        
        //Created constant variable to store all the firebase data in it.
        let nammaApartmentVisitor : NammaApartmentVisitor
        nammaApartmentVisitor = myVisitorList[indexPath.row]
        
        //Created local variable to store Date & Time from firebase
        var dateTimeString : String
        dateTimeString = nammaApartmentVisitor.getdateAndTimeOfVisit()
        //Created array to spilt Date & time in separate variables
        let arrayOfDateTime = dateTimeString.components(separatedBy: "\t\t")
        let dateString: String = arrayOfDateTime[0]
        let timeString: String = arrayOfDateTime[1]
        //Assigning date & time separate variables to get data in cell labels.
        cell.lbl_MyVisitorTime.text = timeString
        cell.lbl_MyVisitorDate.text = dateString
        cell.lbl_MyVisitorName.text = nammaApartmentVisitor.getfullName()
        cell.lbl_MyVisitorType.text = nammaApartmentVisitor.getstatus()
  
        //Retrieving Image & Showing Activity Indicator on top of image with the help of 'SDWebImage Pod'
        cell.myVisitorImage.sd_setShowActivityIndicatorView(true)
        cell.myVisitorImage.sd_setIndicatorStyle(.gray)
        cell.myVisitorImage.sd_setImage(with: URL(string: nammaApartmentVisitor.getprofilePhoto()!), completed: nil)
        
        /* We check if the inviters UID is equal to current UID if it is then we don't have to check in
         firebase since we now know that the inviter is current user.*/
        if(nammaApartmentVisitor.getinviterUID() == userUID) {
            cell.lbl_InvitedName.text = GlobalUserData.shared.personalDetails_Items.first?.fullName
        } else {
            let inviterNameRef = Constants.FIREBASE_USERS_PRIVATE.child(nammaApartmentVisitor.getinviterUID())
            
            inviterNameRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
                let usersData = userDataSnapshot.value as? [String: AnyObject]
                
                //Creating instance of UserPersonalDetails
                let userPersonalDataMap = usersData?["personalDetails"] as? [String: AnyObject]
                let fullName = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as? String
                cell.lbl_InvitedName.text = fullName
            })
        }
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        //setting image round
        cell.myVisitorImage.layer.cornerRadius = cell.myVisitorImage.frame.size.width/2
        cell.myVisitorImage.clipsToBounds = true
        
        //delete particular cell from list
        cell.index = indexPath
        cell.delegate = self
        
        //Setting Label Invitor text based on Firebase Approved Type
        if nammaApartmentVisitor.getapprovalType() == Constants.FIREBASE_CHILD_POST_APPROVED {
            cell.lbl_Invitor.text = NAString().approver()
        } else if nammaApartmentVisitor.getapprovalType() == Constants.FIREBASE_CHILD_GUARD_APPROVED {
            cell.lbl_Invitor.text = NAString().approver()
            cell.lbl_InvitedName.text = NAString().guard_Nmae()
        } else if nammaApartmentVisitor.getapprovalType() == Constants.FIREBASE_CHILD_PRE_APPROVED {
            cell.lbl_Invitor.text = NAString().inviter()
        }
        
        //calling Reschedule action to rechedule visitor date
        cell.actionRescheduling = {
            
            //Checking if the visitor is Entered/Left/Not Entered. So that User can Reschedule his Visitor who is Not entered.
            if nammaApartmentVisitor.getstatus() ==  NAString().notEntered() {
                let dv = NAViewPresenter().rescheduleMyVisitorVC()
                
                cell.btn_Reschedule.tag = NAString().rescheduleButtonTagValue()
                dv.buttonTagValue = cell.btn_Reschedule.tag
                
                //passing cell date & time to Reschedule VC
                dv.getTime = cell.lbl_MyVisitorTime.text!
                dv.getDate = cell.lbl_MyVisitorDate.text!
                dv.getVisitorUID = nammaApartmentVisitor.getuid()
                
                dv.providesPresentationContextTransitionStyle = true
                dv.definesPresentationContext = true
                dv.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
                dv.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
                self.present(dv, animated: true, completion: nil)
            } else {
                NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().reschedule_Title(), Message: NAString().reschedule_Alert_Message(), buttonTitle: NAString().ok(), OkStyle: .default, OK: nil)
            }
        }
        
        //Calling call action to call Visitor
        cell.actionCall = {
            UIApplication.shared.open(NSURL(string: "tel://\(nammaApartmentVisitor.getmobileNumber())")! as URL, options: [:], completionHandler: nil)
        }
        cell.actionMessage = {
            MFMessageComposeViewController.canSendText()
            let messageSheet : MFMessageComposeViewController = MFMessageComposeViewController()
            messageSheet.messageComposeDelegate = self
            messageSheet.recipients = [nammaApartmentVisitor.getmobileNumber()]
            messageSheet.body = ""
            self.present(messageSheet, animated: true, completion: nil)
        }
        return cell
    }
    
    //Message UI default function to dismiss UI after calling.
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //date action fucntion
    @objc func donePressed(txtDate: UITextField, picker: UIDatePicker) {
        // format date
        let date = DateFormatter()
        date.dateFormat = NAString().dateFormat()
        let dateString = date.string(from: picker.date)
        txtDate.text = dateString
        self.view.endEditing(true)
    }
}

extension MyGuestListViewController : dataCollectionProtocol {
    
    func deleteData(indx: Int, cell: UICollectionViewCell) {
        let visitor_UId =  myVisitorList[indx]
        
        self.userDataRef = GlobalUserData.shared.getUserDataReference()
            .child(Constants.FIREBASE_CHILD_VISITORS)
            .child(userUID)
            .child(visitor_UId.getuid())
        
        var removeButtonTitle: String?
        var removeButtonMessage: String?
        
        //Changing Alert Title and Message Based on the Visitor status
        if visitor_UId.getstatus() == NAString().notEntered() {
            removeButtonTitle = NAString().cancel_invitation()
            removeButtonMessage = NAString().remove_invitation_message()
        } else {
            removeButtonTitle = NAString().remove_guest()
            removeButtonMessage = NAString().remove_guests_message()
        }
        
        let alert = UIAlertController(title: removeButtonTitle, message: removeButtonMessage, preferredStyle: .alert)
        let actionNO = UIAlertAction(title:NAString().no(), style: .cancel) { (action) in }
        let actionYES = UIAlertAction(title:NAString().yes(), style: .default) { (action) in
            
            //Changing the Value of Visitor UID to false on Remove Button Click.
            self.userDataRef?.setValue(NAString().getfalse())
            
            //Remove collection view cell item with animation
            self.myVisitorList.remove(at: indx)
            
            //Showing Error layout Message if all the Visitors Data removed from the Guests List.
            if self.myVisitorList.isEmpty {
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorVisitorList())
            }
            //animation at final state
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
            UIView.animate(withDuration: 0.3) {
                cell.alpha = 0.0
                cell.transform = CGAffineTransform.identity
            }
            Timer.scheduledTimer(timeInterval: 0.24, target: self, selector: #selector(self.reloadCollectionData), userInfo: nil, repeats: false)
        }
        alert.addAction(actionNO) //add No action on AlertView
        alert.addAction(actionYES) //add YES action on AlertView
        present(alert, animated: true, completion: nil)
    }
    
    @objc func reloadCollectionData() {
        collectionView.reloadData()
    }
}
