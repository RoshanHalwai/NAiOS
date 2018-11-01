//
//  ContactUsHistoryViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 09/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class ContactUsHistoryViewController: NANavigationViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userSupportDetails = [NAUserProblems]()
    var serviceType = String()
    
    var fromContactUsHistoryVC = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.ConfigureNavBarTitle(title: NAString().history().capitalized)
        self.navigationItem.rightBarButtonItem = nil
        retrievingUserProblemData()
        
        //created custom back button for goto My DigiGate
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToDigitGate))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //Navigating Back to digi gate according to Screen coming from
    @objc func goBackToDigitGate() {
        if fromContactUsHistoryVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-4]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK : TableView DataSource & Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSupportDetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as? ContactUsTableViewCell
        
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
        
        //assigning title to cell Labels
        cell?.lbl_Category_Type.text = NAString().category()
        cell?.lbl_Type.text = NAString().myVisitorType()
        cell?.lbl_Problem_Type.text = NAString().problem()
        cell?.lbl_Date_Type.text = NAString().myVisitorDate()
        cell?.lbl_Status_Type.text = NAString().Status()
        
        cell?.lbl_Category_Detail.font = NAFont().headerFont()
        cell?.lbl_Type_Detail.font = NAFont().headerFont()
        cell?.lbl_Problem_Detail.font = NAFont().headerFont()
        cell?.lbl_Date_Detail.font = NAFont().headerFont()
        cell?.lbl_Status_Detail.font = NAFont().headerFont()
        
        cell!.isUserInteractionEnabled = false
        
        //cardUIView
        NAShadowEffect().shadowEffectForView(view: (cell?.cardView)!)
        
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
                        self.tableView.reloadData()
                    })
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorUserSupport())
            }
        }
    }
}
