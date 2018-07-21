//
//  MySweetHomeViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 18/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MySweetHomeViewController: NANavigationViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var opacityView: UIView!
    @IBOutlet weak var popUp_View: UIView!
    @IBOutlet weak var access_Segment: UISegmentedControl!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var btn_ChangeAccess: UIButton!
    @IBOutlet weak var lbl_Grant_Access: UILabel!
    @IBOutlet weak var btn_AddmyFamilyMember: UIButton!

    var mysweethomeImages = [#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen")]
    var MySweetHomeName =  ["Preeti","Vikas"]
    var MySweetHomeRelation = ["Sister","Brother"]
    var MySweetHomeGrantAccess = ["Yes","No"]
    
    //A boolean variable to indicate if previous screen was Expecting Arrival.
    var fromHomeScreenVC = false
    
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Corner Radius for popUp View
        popUp_View.layer.cornerRadius = 5
        
        opacityView.isHidden = true
        popUp_View.isHidden = true
        
        lbl_Grant_Access.font = NAFont().headerFont()
        btn_Cancel.titleLabel?.font = NAFont().popUpButtonFont()
        btn_ChangeAccess.titleLabel?.font = NAFont().popUpButtonFont()
        
        //Formmating & setting Button
        self.btn_AddmyFamilyMember.setTitle(NAString().btn_mySweet_home().capitalized, for: .normal)
        self.btn_AddmyFamilyMember.backgroundColor = NAColor().buttonBgColor()
        self.btn_AddmyFamilyMember.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_AddmyFamilyMember.titleLabel?.font = NAFont().buttonFont()
        
        //Formatting & setting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.title = ""
        //created custom back button for goto Home Screen
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToHomeScreenVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    //Navigating Back to digi gate according to Screen coming from
    @objc func goBackToHomeScreenVC() {
        if fromHomeScreenVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-NAString().count_two()]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnAddFamilyMember(_ sender: UIButton) {
        let lv = NAViewPresenter().myFamilyMembers()
        lv.navTitle = NAString().addFamilyMemberTitle()
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MySweetHomeName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! mySweetHomeCollectionViewCell
        
        cell.lbl_MySweetHomeName.text = MySweetHomeName[indexPath.row]
        cell.lbl_MySweetHomeRelation.text = MySweetHomeRelation[indexPath.row]
        cell.lbl_MySweetHomeGrantAccess.text = MySweetHomeGrantAccess[indexPath.row]
        cell.MySweeetHomeimg.image = mysweethomeImages[indexPath.row]
        
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
        
        //creating round Image using Corner radius
        cell.MySweeetHomeimg.layer.cornerRadius = cell.MySweeetHomeimg.frame.size.width/2
        cell.MySweeetHomeimg.clipsToBounds = true
        
        //setting fonts for labels
        cell.lbl_MySweetHomeName.font = NAFont().headerFont()
        cell.lbl_MySweetHomeRelation.font = NAFont().headerFont()
        cell.lbl_MySweetHomeGrantAccess.font = NAFont().headerFont()
        cell.lbl_Name.font = NAFont().headerFont()
        cell.lbl_Relation.font = NAFont().headerFont()
        cell.lbl_GrantAccess.font = NAFont().headerFont()
        cell.lbl_Call.font = NAFont().headerFont()
        cell.lbl_Message.font = NAFont().headerFont()
        cell.lbl_Edit.font = NAFont().headerFont()
        cell.lbl_Remove.font = NAFont().headerFont()
        
        cell.lbl_Name.font = NAFont().textFieldFont()
        cell.lbl_Relation.font = NAFont().textFieldFont()
        cell.lbl_GrantAccess.font = NAFont().textFieldFont()
        
        //setting strings to labels
        cell.lbl_Name.text = NAString().name()
        cell.lbl_Relation.text = NAString().relation()
        cell.lbl_GrantAccess.text = NAString().grant_access()
        cell.lbl_Call.text = NAString().call()
        cell.lbl_Message.text = NAString().message()
        cell.lbl_Edit.text = NAString().edit()
        cell.lbl_Remove.text = NAString().remove()
        
        //delete particular cell from list
        cell.index = indexPath
        cell.delegate = self
        
        //calling edit button action on particular cell
        cell.objEdit = {
            self.opacityView.isHidden = false
            self.popUp_View.isHidden = false
        }
        return cell
    }
    
    @IBAction func Cancel_Action(_ sender: UIButton) {
        opacityView.isHidden = true
        popUp_View.isHidden = true
    }
    
    @IBAction func Change_Button(_ sender: UIButton) {
        opacityView.isHidden = true
        popUp_View.isHidden = true
    }
    
    @IBAction func aceess_Segment_Action(_ sender: UISegmentedControl) {
    }
}

extension MySweetHomeViewController : removeCollectionProtocol {
    
    func deleteData(indx: Int, cell: UICollectionViewCell) {
        
        //AlertView will Display while removing Card view
        let alert = UIAlertController(title: NAString().delete(), message: NAString().remove_alertview_description(), preferredStyle: .alert)
        
        let actionNO = UIAlertAction(title:NAString().no(), style: .cancel) { (action) in }
        let actionYES = UIAlertAction(title:NAString().yes(), style: .default) { (action) in
            
            //Remove collection view cell item with animation
            self.MySweetHomeName.remove(at: indx)
            
            //animation at final state
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
            
            UIView.animate(withDuration: 0.3) {
                cell.alpha = 0.0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 400, 20, 0)
                cell.layer.transform = transform
            }
            Timer.scheduledTimer(timeInterval: 0.24, target: self, selector: #selector(self.reloadCollectionData), userInfo: nil, repeats: false)
        }
        alert.addAction(actionNO) //add No action on AlertView
        alert.addAction(actionYES) //add YES action on AlertView
        present(alert, animated: true, completion: nil)
    }
    
    @objc func reloadCollectionData() {
        collectionView.reloadData()
    }
}





