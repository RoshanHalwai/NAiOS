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
        
        cell.lbl_rupees.text = NAString().rs(amount: Float(transactionDetails.getAmount()))
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MyTransactionsCollectionViewCell
        
        passdata(index: indexPath.row, cell: cell!, date: (cell?.lbl_Date_And_Time.text)!)
    }
    
    func passdata(index: Int, cell: UICollectionViewCell, date: String) {
        let transactiondetails = userTransactionData[index]
        let transactionSummaryVC = NAViewPresenter().transactionSummaryVC()
        transactionSummaryVC.totalAmount = transactiondetails.getAmount()
        transactionSummaryVC.transactionDate = date
        transactionSummaryVC.status = transactiondetails.getResult()
        transactionSummaryVC.transactionUID = transactiondetails.getTransactionID()
        transactionSummaryVC.transactionPeriod = transactiondetails.getPeriod()
        self.navigationController?.pushViewController(transactionSummaryVC, animated: true)
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
                        
                        var servicecategory = String()
                        var transactionPeriod = String()
                        var startPeriod = String()
                        var endPeriod = String()
                        var transactionMonth = String()
                        
                        let amount = (transactionData[NAUserTransactionFBKeys.amount.key])?.floatValue
                        servicecategory = transactionData[NAUserTransactionFBKeys.serviceCategory.key] as! String
                        let timestamp = (transactionData[NAUserTransactionFBKeys.timestamp.key])?.floatValue
                        let result = transactionData[NAUserTransactionFBKeys.result.key]
                        let paymentID = transactionData[NAUserTransactionFBKeys.paymentId.key]
                        
                        if servicecategory != NAString().event_management() {
                            transactionPeriod = transactionData[NAUserTransactionFBKeys.period.key] as! String
                            
                            let array = transactionPeriod.split(separator: "-")
                            startPeriod = String(array[0])
                            
                            let date = startPeriod
                            let dateString = String(describing: date)
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = NAString().transactionPeriodFormat()
                            let dateAndTime = dateFormatterGet.date(from: dateString)
                            dateFormatterGet.dateFormat = NAString().convertedTransactionPeriodFormat()
                            let startingMonth = (dateFormatterGet.string(from: dateAndTime!))
                            
                            //Checking pending dues Months count
                            if array.count == 1 {
                                transactionMonth = startingMonth
                            } else {
                                endPeriod = String(array[1])
                                let date = endPeriod
                                let dateString = String(describing: date)
                                let dateFormatterGet = DateFormatter()
                                dateFormatterGet.dateFormat = NAString().transactionPeriodFormat()
                                let dateAndTime = dateFormatterGet.date(from: dateString)
                                dateFormatterGet.dateFormat = NAString().convertedTransactionPeriodFormat()
                                let endMonth = (dateFormatterGet.string(from: dateAndTime!))
                                transactionMonth = startingMonth + " - " + endMonth
                            }
                        }
                        
                        let userData = NAUserTransactions(amount: amount!, serviceCategory: servicecategory , timestamp: Int(timestamp! as Float), result: result as! String, transactionId: paymentID as! String, period: transactionMonth)
                        
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
