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
        
        //creating back buttom going back to
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToDigiGate))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.navigationItem.hidesBackButton = true
        
        super.ConfigureNavBarTitle(title: NAString().my_sweet_home().capitalized)
       
        self.addMemberButton = UIButton(type: .custom)
        self.addMemberButton.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.addMemberButton.backgroundColor = UIColor.black
        self.addMemberButton.setTitle(NAString().btn_mySweet_home(), for: .normal)
        self.addMemberButton.addTarget(self, action: #selector(self.btnAddFamilyMember(_:)), for: UIControlEvents.touchUpInside)
    
        self.view.addSubview(self.addMemberButton)
    }
    
    override func viewWillLayoutSubviews() {
        self.addMemberButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addMemberButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            addMemberButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
              addMemberButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20)])
        
        addMemberButton.layer.frame = CGRect(x: 20, y: 570, width: 335, height: 39)
    }

    @IBAction func btnAddFamilyMember(_ sender: UIButton)
    {
        let vc : AddMyServicesViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyServicesViewController
        //passing value to my services VC
        let passVC = "mySweetHomeVC"
        vc.vcValue = passVC
      
       vc.navTitle =  NAString().addFamilyMemberTitle().capitalized
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //created custome back button to go back to digi gate
    @objc func goBackToDigiGate()
    {
        let vcName = UIStoryboard(name: "Main", bundle: nil)
        let destVC = vcName.instantiateViewController(withIdentifier: "digiGateVC")
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}
