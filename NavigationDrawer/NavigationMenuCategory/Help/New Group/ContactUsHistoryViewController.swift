//
//  ContactUsHistoryViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 09/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class ContactUsHistoryViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userSupportDetails = [NAUserProblems]()
    var serviceType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ConfigureNavBarTitle(title: NAString().history().capitalized)
        self.navigationItem.rightBarButtonItem = nil
        retrievingUserProblemData()        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userSupportDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as? ContactUsHistoryCollectionViewCell
        
        let supportDetails : NAUserProblems
        supportDetails = userSupportDetails[indexPath.row]
        
        let timeStamp = supportDetails.getTimeStamp()
        let date = (NSDate(timeIntervalSince1970: TimeInterval(timeStamp/1000)))
        let dateString = String(describing: date)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = NAString().userProblemTimeStampFormat()
        let dateAndTime = dateFormatterGet.date(from: dateString)
        dateFormatterGet.dateFormat = NAString().convertedUserProblemTimeStampFormat()
        let userRequestTime = (dateFormatterGet.string(from: dateAndTime!))
        
        cell?.lbl_Category_Detail.text = supportDetails.getCategory()
        cell?.lbl_Type_Detail.text = supportDetails.getType()
        cell?.lbl_Problem_Detail.text = supportDetails.getProblem()
        cell?.lbl_Status_Detail.text = supportDetails.getStatus()
        cell?.lbl_Date_Detail.text = userRequestTime
        
        cell?.lbl_Category_Type.font = NAFont().textFieldFont()
        cell?.lbl_Type.font = NAFont().textFieldFont()
        cell?.lbl_Problem_Type.font = NAFont().textFieldFont()
        cell?.lbl_Date_Type.font = NAFont().textFieldFont()
        cell?.lbl_Status_Type.font = NAFont().textFieldFont()
        
        cell?.lbl_Category_Detail.font = NAFont().headerFont()
        cell?.lbl_Type_Detail.font = NAFont().headerFont()
        cell?.lbl_Problem_Detail.font = NAFont().headerFont()
        cell?.lbl_Date_Detail.font = NAFont().headerFont()
        cell?.lbl_Status_Detail.font = NAFont().headerFont()
        
        NAShadowEffect().shadowEffect(Cell: cell!)
        return cell!
    }
    
    func retrievingUserProblemData() {
        
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        let userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_SUPPORT)
        
        userDataRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                let supportsUID = snapshot.value as? NSDictionary
                for supportUID in (supportsUID?.allKeys)! {
                    let supportRef = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_SUPPORT).child(supportUID as! String)
                    supportRef.observeSingleEvent(of: .value, with: { (supportSnapshot) in
                        let userSupportData = supportSnapshot.value as? [String: AnyObject]
                        
                        let category = userSupportData![SupportDetailsFBKeys.serviceCategory.key]
                        let type = userSupportData![SupportDetailsFBKeys.serviceType.key]
                        let problem = userSupportData![SupportDetailsFBKeys.problemDescription.key]
                        let timestamp = (userSupportData![SupportDetailsFBKeys.timestamp.key])?.floatValue
                        let status = userSupportData![SupportDetailsFBKeys.status.key]
                        
                        let problemsData = NAUserProblems(problemDescription: problem as! String, serviceCategory: category as! String, serviceType: type as! String, status: status as! String, timestamp: Int(timestamp!))
                        
                        self.userSupportDetails.append(problemsData)
                        NAActivityIndicator.shared.hideActivityIndicator()
                        self.collectionView.reloadData()
                    })
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorUserSupport())
            }
        }
    }
}
