//
//  MySweetHomeViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 18/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
class MySweetHomeViewController: NANavigationViewController , UICollectionViewDelegate , UICollectionViewDataSource {

    private var addMemberButton = UIButton()
    
    
    var mysweethomeImages = [#imageLiteral(resourceName: "splashScreen")]
    var MySweetHomeName =  ["vinod"]
    var MySweetHomeRelation = ["brother"]
    var MySweetHomeGrantAccess = ["Yes"]
    
    
    
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
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return mysweethomeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! mySweetHomeCollectionViewCell
        
        
        cell.Lbl_MySweetHomeName.text = MySweetHomeName[indexPath.row]
        cell.Lbl_MySweetHomeRelation.text = MySweetHomeRelation[indexPath.row]
        cell.Lbl_MySweetHomeGrantAccess.text = MySweetHomeGrantAccess[indexPath.row]
        
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    
        
        //setting the image in round shape
        cell.MySweeetHomeimg.layer.cornerRadius = cell.MySweeetHomeimg.frame.size.width/2
        cell.MySweeetHomeimg.clipsToBounds = true
        
        //setting fonts for labels
        cell.Lbl_MySweetHomeName.font = NAFont().headerFont()
        cell.Lbl_MySweetHomeRelation.font = NAFont().headerFont()
        cell.Lbl_MySweetHomeGrantAccess.font = NAFont().headerFont()
        cell.lbl_mysweethomename.font = NAFont().headerFont()
        cell.lbl_mysweethomeRelation.font = NAFont().headerFont()
        cell.lbl_mysweethomeGrantAccess.font = NAFont().headerFont()
        cell.lblcall_mysweethome.font = NAFont().headerFont()
        cell.lblmessage_mysweethome.font = NAFont().headerFont()
        cell.lbledit_mysweethome.font = NAFont().headerFont()
        cell.lblremove_mysweethome.font = NAFont().headerFont()
        
        
        //setting strings to labels
        cell.lbl_mysweethomename.text = NAString().name()
        cell.lbl_mysweethomeRelation.text = NAString().relation()
        cell.lbl_mysweethomeGrantAccess.text = NAString().grant_access()
        
        
    return cell
}
}
