//
//  MyVisitorListViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 07/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyGuestListViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate {
    //Created variable of DBReference for storing data in firebase
    var myVisitorListReference : DatabaseReference?
    
    //Created variable for NammaApartmentVisitor file to fetch data from firebase.
    var myVisitorList = [NammaApartmentVisitor]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var titleName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to show activity indicator before loading data from firebase
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        myVisitorListReference = Database.database().reference().child(Constants.FIREBASE_CHILD_VISITORS).child(Constants.FIREBASE_CHILD_PRE_APPROVED_VISITORS)
        
            myVisitorListReference?.observeSingleEvent(of: .value, with: {(snapshot) in

            //checking that  child node have data or not inside firebase. If Have then fatch all the data in tableView
            if snapshot.exists() {
                //for loop for getting all the data in tableview
                for visitors in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let visitorObject = visitors.value as? [String: AnyObject]
                    
                    let dateAndTimeOfVisit = visitorObject?[VisitorListFBKeys.dateAndTimeOfVisit.key]
                    let fullName = visitorObject?[VisitorListFBKeys.fullName.key] as? String
                    let inviterUID = visitorObject?[VisitorListFBKeys.inviterUID.key]
                    let mobileNumber = visitorObject?[VisitorListFBKeys.mobileNumber.key]
                    let profilePhoto = visitorObject?[VisitorListFBKeys.profilePhoto.key]
                    let status = visitorObject?[VisitorListFBKeys.status.key]
                    let uid = visitorObject?[VisitorListFBKeys.uid.key]
                    
                    //creating userAccount model & set earlier created let variables in userObject in the below parameter
                    let user = NammaApartmentVisitor(dateAndTimeOfVisit: dateAndTimeOfVisit as! String?, fullName: fullName , inviterUID: inviterUID as! String?, mobileNumber: mobileNumber as! String?, profilePhoto: profilePhoto as! String?, status: status as! String?, uid: uid as! String?)

                    //Adding visitor in visitor List
                    self.myVisitorList.append(user)
                    //Hidding Activity indicator after loading data in the list from firebase.
                    NAActivityIndicator.shared.hideActivityIndicator()
                }
                //reload collection view.
                self.collectionView.reloadData()
            }
            else {
                //Hiding Activity Indicator & showing error image & message.
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorVisitorList())
            }
        })
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: NAString().my_Guest())

        //created custom back button for goto My Visitors List
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToDigitGate))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    //created custome back button to go back to My Visitors List
    @objc func goBackToDigitGate() {
        let dv = NAViewPresenter().digiGateVC()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myVisitorList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! MyGuestListCollectionViewCell
        
        //Created constant variable to store all the firebase data in it.
        let myList : NammaApartmentVisitor
        myList = myVisitorList[indexPath.row]
        
        //Created local variable to store Date & Time from firebase
        var dateTimeString : String
        dateTimeString = myList.getdateAndTimeOfVisit()
            //Created array to spilt Date & time in separate variables
            let arrayOfDateTime = dateTimeString.components(separatedBy: "\t\t")
            let dateString: String = arrayOfDateTime[0]
            let timeString: String = arrayOfDateTime[1]
            //Assigning date & time separate variables to get data in cell labels.
            cell.lbl_MyVisitorTime.text = timeString
            cell.lbl_MyVisitorDate.text = dateString
        
        cell.lbl_MyVisitorName.text = myList.getfullName()
        cell.lbl_MyVisitorType.text = NAString().guest()
  
       //Calling function to get Profile Image from Firebase.
        if let urlString = myList.getprofilePhoto() {
           NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.myVisitorImage)
        }
        //TODO : Need to get Name from Firebase (According To Default User)
        cell.lbl_InvitedName.text = "Vikas"
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        //assigning font & style to cell labels
        cell.lbl_InvitedName.font = NAFont().headerFont()
        cell.lbl_MyVisitorType.font = NAFont().headerFont()
        cell.lbl_MyVisitorName.font = NAFont().headerFont()
        cell.lbl_MyVisitorDate.font = NAFont().headerFont()
        cell.lbl_MyVisitorTime.font = NAFont().headerFont()
        
        //setting image round
        cell.myVisitorImage.layer.cornerRadius = cell.myVisitorImage.frame.size.width/2
        cell.myVisitorImage.clipsToBounds = true
        
        //delete particular cell from list
        cell.index = indexPath
        cell.delegate = self
        
        //calling Reschdule button action on particular cell
        cell.objReschduling = {
            
                let dv = NAViewPresenter().rescheduleMyVisitorVC()
                dv.providesPresentationContextTransitionStyle = true
                dv.definesPresentationContext = true
                dv.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
                dv.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
                self.present(dv, animated: true, completion: nil)
                
                //passing cell date & time to Reschedule VC
                dv.getTime = cell.lbl_MyVisitorTime.text!
                dv.getDate = cell.lbl_MyVisitorDate.text!
        }
        return cell
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
        
        //AlertView will Display while removing Card view
        let alert = UIAlertController(title: NAString().delete(), message: NAString().remove_alertview_description(), preferredStyle: .alert)
        
        let actionNO = UIAlertAction(title:NAString().no(), style: .cancel) { (action) in }
        let actionYES = UIAlertAction(title:NAString().yes(), style: .default) { (action) in
            
            //Remove collection view cell item with animation
             self.myVisitorList.remove(at: indx)
            //animation at final state
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
            
            UIView.animate(withDuration: 0.3) {
                cell.alpha = 0.0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 400, 20, 0)
                cell.layer.transform = transform
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

