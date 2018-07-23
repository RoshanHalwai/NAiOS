//
//  SideMenuViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 19/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var top_View: UIView!
    @IBOutlet weak var tableView: UITableView!
    var sideMenuArray = [NAString().my_profile(), NAString().my_family_members(), NAString().notice_board(), NAString().settings(), NAString().help(), NAString().rate_us(), NAString().logout()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SideMenuTableViewCell
        cell.image_View.image = UIImage(named: sideMenuArray[indexPath.row])
        cell.labelView.text = sideMenuArray[indexPath.row]
        return cell
    }


}