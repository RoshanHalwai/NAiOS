//
//  NoticeBoardViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 25/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NoticeBoardViewController: NANavigationViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!    
    var myExpectedNoticeBoardList = [NAExpectingNoticeBoard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Progress indicator while we retrieve user guests
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: NAString().notice_board())
        self.navigationItem.rightBarButtonItem = nil
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        //Calling RetrievieMyGuardData In Firebase
        self.retrieviedNoticeBoardDataInFirebase()
    }
    
    @IBAction func btn_BackAction(_ sender: Any) {
        goBackToMyFlatDetails()
    }
    
    //Navigating back to NAHome screen on click of back button.
    @objc func goBackToMyFlatDetails() {
        let dest = NAViewPresenter().mainScreenVC()
        self.navigationController?.pushViewController(dest, animated: true)
    }
    
    //MARK: TableView Delegate and DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myExpectedNoticeBoardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NAString().cellID(), for: indexPath) as! NoticeBoardTableViewCell
        let myNoticeBoardsList : NAExpectingNoticeBoard
        myNoticeBoardsList = myExpectedNoticeBoardList[indexPath.row]
        
        //Created local variable to store Date & Time from firebase
        var dateTimeString : String
        dateTimeString = myNoticeBoardsList.getdateAndTime()
        //Created array to spilt Date & time in separate variables
        let arrayOfDateTime = dateTimeString.components(separatedBy: "\t\t")
        let dateString: String = arrayOfDateTime[0]
        let timeString: String = arrayOfDateTime[1]
        
        cell.lbl_FestivalName.text = myNoticeBoardsList.gettitle()
        cell.lbl_FestivalDescription.text = myNoticeBoardsList.getdescription()
        cell.lbl_AdminName.text = myNoticeBoardsList.getnameOfAdmin()
        cell.lbl_Date.text = dateString + " " + timeString
        
        //assigning font & style to cell labels
        cell.lbl_FestivalName.font = NAFont().headerFont()
        cell.lbl_FestivalDescription.font = NAFont().textFieldFont()
        cell.lbl_AdminName.font = NAFont().headerFont()
        cell.lbl_Date.font = NAFont().textFieldFont()
        
        //cardUIView
        NAShadowEffect().shadowEffectForView(view: cell.cardView)
        
        return cell
    }
}

extension NoticeBoardViewController {
    
    func retrieviedNoticeBoardDataInFirebase() {
        
        let noticeBoardDataRef = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_NOTICEBOARD)
        noticeBoardDataRef.observeSingleEvent(of: .value) { (noticeBoardSnapshot) in
            if noticeBoardSnapshot.exists() {
                if let noticeBoardsUID = noticeBoardSnapshot.value as? [String: Any] {
                    let noticeBoardUIDKeys = Array(noticeBoardsUID.keys)
                    //sorting UID's
                    let sortedArray = noticeBoardUIDKeys.sorted()
                    //Reversing the Array order to make sure that Latest Request Data should be on the top in the List
                    let reversedArray = sortedArray.reversed()
                    for noticeBoardUID in reversedArray {
                        noticeBoardDataRef.child(noticeBoardUID).observeSingleEvent(of: .value, with: { (snapshot) in
                            let noticeBoardData = snapshot.value as? [String: AnyObject]
                            let title : String = (noticeBoardData?[NoticeBoardListFBKeys.title.key])! as! String
                            let description : String = (noticeBoardData?[NoticeBoardListFBKeys.description.key])! as! String
                            let nameOfAdmin : String = (noticeBoardData?[NoticeBoardListFBKeys.nameOfAdmin.key])! as! String
                            let dateAndTime : String = (noticeBoardData?[NoticeBoardListFBKeys.dateAndTime.key])! as! String
                            let noticeBoardDetails = NAExpectingNoticeBoard(title: title, description: description,nameOfAdmin : nameOfAdmin,dateAndTime : dateAndTime)
                            self.myExpectedNoticeBoardList.append(noticeBoardDetails)
                            NAActivityIndicator.shared.hideActivityIndicator()
                            self.tableView.reloadData()
                        })
                    }
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().noticeBoardErrorLayoutMessage())
            }
        }
    }
}
