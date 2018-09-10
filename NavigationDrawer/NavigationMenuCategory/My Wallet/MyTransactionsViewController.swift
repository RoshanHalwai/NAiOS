//
//  MyTransactionsViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 09/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MyTransactionsViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var navTitle = String()
    
    var userTransactionData = [NAUserTransactions]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        retrievingUserTransactions()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userTransactionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! MyTransactionsCollectionViewCell
        
        let transactionDetails : NAUserTransactions
        transactionDetails = userTransactionData[indexPath.row]
        
        let timeStamp = transactionDetails.getTimeStamp()
        let date = (NSDate(timeIntervalSince1970: TimeInterval(timeStamp/1000)))
        let dateString = String(describing: date)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = NAString().transactionTimeStampFormat()
        let dateAndTime = dateFormatterGet.date(from: dateString)
        dateFormatterGet.dateFormat = NAString().convertedTimeStampFormat()
        let transactionDate = (dateFormatterGet.string(from: dateAndTime!))
        
        cell.lbl_rupees.text = NAString().rs(amount: transactionDetails.getAmount())
        cell.lbl_ServiceType.text = transactionDetails.getServiceCategory()
        cell.lbl_Date_And_Time.text = transactionDate
        
        if transactionDetails.getResult() == NAString().successful() {
            cell.success_Failure_Image.image = #imageLiteral(resourceName: "checked")
        } else {
            cell.success_Failure_Image.image = #imageLiteral(resourceName: "Cancel")
        }
        NAShadowEffect().shadowEffect(Cell: cell)
        cell.lbl_rupees.font = NAFont().lato_Bold_16()
        cell.lbl_rupees.textColor = UIColor.gray
        cell.lbl_ServiceType.font = NAFont().lato_Regular_16()
        cell.lbl_ServiceType.textColor = UIColor.gray
        cell.lbl_Date_And_Time.font = NAFont().lato_Regular_16()
        cell.lbl_Date_And_Time.textColor = UIColor.gray
        
        return cell
    }
    
    func retrievingUserTransactions() {
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        let userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_TRANSACTIONS)
        
        userDataRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                let transactionsUID = snapshot.value as! NSDictionary
                for transactionUID in transactionsUID.allKeys {
                    let transactionRef = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_TRANSACTIONS).child(Constants.FIREBASE_CHILD_PRIVATE).child(transactionUID as! String)
                    transactionRef.observeSingleEvent(of: .value, with: { (transactionSnapshot) in
                        let transactionData = transactionSnapshot.value as! [String: AnyObject]
                        
                        let amount = (transactionData[NAUserTransactionFBKeys.amount.key])?.floatValue
                        let servicecategory = transactionData[NAUserTransactionFBKeys.serviceCategory.key]
                        let timestamp = (transactionData[NAUserTransactionFBKeys.timestamp.key])?.floatValue
                        let result = transactionData[NAUserTransactionFBKeys.result.key]
                        
                        let userData = NAUserTransactions(amount: Int(amount! as Float), serviceCategory: servicecategory as! String, timestamp: Int(timestamp! as Float), result: result as! String)
                        
                        self.userTransactionData.append(userData)
                        NAActivityIndicator.shared.hideActivityIndicator()
                        self.collectionView.reloadData()
                    })
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorTransactionsList())
            }
        }
    }
}
