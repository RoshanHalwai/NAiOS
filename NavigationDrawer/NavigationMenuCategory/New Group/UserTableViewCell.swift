//
//  UserTableViewCell.swift
//  nammaApartment
//
//  Created by kirtan labs on 12/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var user_Parent_View: UIView!
    @IBOutlet weak var lbl_User_Message: UILabel!
    @IBOutlet weak var lbl_User_Time: UILabel!
    @IBOutlet weak var user_Parent_View_Trailing: NSLayoutConstraint!
}
