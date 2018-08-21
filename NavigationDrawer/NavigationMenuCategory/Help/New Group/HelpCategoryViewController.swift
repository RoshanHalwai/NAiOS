//
//  HelpCategoryViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 18/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HelpCategoryViewController: NANavigationViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var table_View: UITableView!
    
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        table_View.separatorStyle = .none
        
        if navTitle == NAString().contact_us().capitalized {
            lbl_Title.text = NAString().full_Address()
        } else if navTitle == NAString().privacy_policy().capitalized {
            lbl_Title.text = NAString().privacy_policy()
        } else if navTitle == NAString().terms_and_conditions().capitalized {
            lbl_Title.text = NAString().terms_and_conditions()
        }
        
         lbl_Title.font = NAFont().labelFont()
        
        table_View.rowHeight = UITableViewAutomaticDimension
        table_View.estimatedRowHeight = UITableViewAutomaticDimension
        table_View.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_View.dequeueReusableCell(withIdentifier: NAString().cellID()) as! HelpCategoryTableViewCell
        
        if navTitle == NAString().contact_us().capitalized {
            cell.lbl_View.text = NAString().address_Detail()
           
        } else if navTitle == NAString().privacy_policy().capitalized {
            cell.lbl_View.text = NAString().privacy_policy_Detail()
        } else if navTitle == NAString().terms_and_conditions().capitalized {
            cell.lbl_View.text = NAString().termsAndConditions_Detail()
        }
        
         cell.lbl_View.font = NAFont().layoutFeatureErrorFont()
        cell.lbl_View.sizeToFit()
        cell.lbl_View.layoutIfNeeded()
        cell.cardView.sizeToFit()
        cell.cardView.layoutIfNeeded()
        
        //cardUIView
        cell.cardView?.layer.cornerRadius = 3
        cell.cardView?.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cell.cardView?.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cell.cardView?.layer.shadowRadius = 1.7
        cell.cardView?.layer.shadowOpacity = 0.45
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table_View.estimatedRowHeight = 200
        table_View.rowHeight = UITableViewAutomaticDimension
    }
}
