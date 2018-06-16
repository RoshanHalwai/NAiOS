//
//  MyVisitorListViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 07/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyVisitorListViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate
{
    //array for displaying card view data
//    var cardImageList = [#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen")]
//    var MyVisitorName = ["Vikas Nayak","Chaitanya","Vinod Kumar","Avinash"]
//    var MyVisitorDate = ["May 1 2018","May 2 2018","May 3 2018","Apr 30 2017"]
//    var MyVisitorType = ["Guest","Guest","Guest","Guest"]
//    var MyVisitorTime = ["12:14","14:09","09:12","05:50"]
//    var InvitorName = ["Vinod Kumar","Rohit Mishra","Yuvaraj","Akash Patel"]
    
    //for storing data in firebase
    var dbReference : DatabaseReference?
    
     var myVisitorList = [NAVisitor]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //db reference
        dbReference = Database.database().reference().child("visitors").child("preApprovedVisitors")
        
        //
        dbReference?.observe(DataEventType.value, with: { (snapshot) in
            //checking that  child node have data or not inside firebase. If Have then fatch all the data in tableView
            if snapshot.childrenCount > 0
            {
                self.myVisitorList.removeAll()
                
                //forloop for getting all the data in tableview
                for visitors in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let visitorObject = visitors.value as? [String: AnyObject]
                    
                    let dateAndTimeOfVisit = visitorObject?["dateAndTimeOfVisit"]
                    let fullName = visitorObject?["fullName"]
                    let inviterUID = visitorObject?["inviterUID"]
                    let mobileNumber = visitorObject?["mobileNumber"]
                    let profilePhoto = visitorObject?["profilePhoto"]
                    let status = visitorObject?["status"]
                    let uid = visitorObject?["uid"]
                    
                    
                    //creating userAccount model & set earlier created let variables in userObject in the below parameter
                    let user = NAVisitor(dateAndTimeOfVisit: dateAndTimeOfVisit as! String?, fullName: fullName as! String?, inviterUID: inviterUID as! String?, mobileNumber: mobileNumber as! String?, profilePhoto: profilePhoto as! String?, status: status as! String?, uid: uid as! String?)
                    
                    //add users In UserList
                    self.myVisitorList.append(user)
                }
                
                //reload tableview
                self.collectionView.reloadData()
            }
            
        })

        
        
    
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: NAString().myVisitorViewTitle())
        self.navigationItem.title = ""
        
        //created custom back button for goto digi gate screen
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToDigiGate))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.navigationItem.hidesBackButton = true
    }
    
    //created custome back button to go back to digi gate
    @objc func goBackToDigiGate()
    {
        let dv = NAViewPresenter().digiGateVC()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myVisitorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyVistorListCollectionViewCell
        
         let myList : NAVisitor
        
        myList = myVisitorList[indexPath.row]
        
      //  cell.lbl_InvitedName.text = myList.
        cell.lbl_MyVisitorDate.text = myList.dateAndTimeOfVisit
       // cell.lbl_MyVisitorTime.text =
        //cell.lbl_MyVisitorName.text =
        //cell.lbl_MyVisitorType.text =
        
   //     cell.myVisitorImage
//        .image = cardImageList[indexPath.row]
        
        
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
            self.navigationController?.pushViewController(dv, animated: true)
            
            //passing cell date & time to Reschedule VC
            dv.getTime = cell.lbl_MyVisitorTime.text!
            dv.getDate = cell.lbl_MyVisitorDate.text!
            
            //hide navigation bar with backButton
            self.navigationController?.isNavigationBarHidden = true
            self.navigationItem.hidesBackButton = true
        }
        return cell
    }

    //date action fucntion
    @objc func donePressed(txtDate: UITextField, picker: UIDatePicker) {
        // format date
        let date = DateFormatter()
        date.dateFormat = NAString().dateFormate()
        let dateString = date.string(from: picker.date)
        txtDate.text = dateString
        self.view.endEditing(true)
    }
}

extension MyVisitorListViewController : dataCollectionProtocol{
     func deleteData(indx: Int, cell: UICollectionViewCell) {
        
        //AlertView will Display while removing Card view
        let alert = UIAlertController(title: NAString().delete(), message: NAString().remove_alertview_description(), preferredStyle: .alert)
        
            let actionNO = UIAlertAction(title:NAString().no(), style: .cancel) { (action) in
                }
            let actionYES = UIAlertAction(title:NAString().yes(), style: .default) { (action) in

                //Remove collection view cell item with animation
                
                
               // self.MyVisitorName.remove(at: indx)
                
                //animation at final state
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
        
                UIView.animate(withDuration: 0.3)
                {
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

