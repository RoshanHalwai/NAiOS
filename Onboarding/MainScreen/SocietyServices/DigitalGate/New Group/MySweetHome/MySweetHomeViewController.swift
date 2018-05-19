//
//  MySweetHomeViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 18/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
class MySweetHomeViewController: NANavigationViewController {

    private var addMemberButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.ConfigureNavBarTitle(title: NAString().my_sweet_home().capitalized)
       
        self.addMemberButton = UIButton(type: .custom)
        self.addMemberButton.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.addMemberButton.backgroundColor = UIColor.black
        self.addMemberButton.setTitle(NAString().btn_mySweet_home(), for: .normal)
        self.addMemberButton.addTarget(self, action: #selector(self.ButtonClick(_:)), for: UIControlEvents.touchUpInside)
    
        self.view.addSubview(self.addMemberButton)
    }
    
    override func viewWillLayoutSubviews() {
        self.addMemberButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addMemberButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 20),
            
            addMemberButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
              addMemberButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -20)])
        
        addMemberButton.layer.frame = CGRect(x: 20, y: 570, width: 335, height: 39)
    }

    @IBAction func ButtonClick(_ sender: UIButton)
    {
        let vc : AddMyDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyDetailsViewController
        //passing value to my services VC
        let passVC = "mySweetHomeVC"
        vc.vcValue = passVC
      
       vc.navTitle =  NAString().addFamilyMemberTitle().capitalized
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
