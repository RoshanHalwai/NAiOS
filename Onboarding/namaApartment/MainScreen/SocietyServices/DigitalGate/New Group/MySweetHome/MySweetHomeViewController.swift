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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mysweethomeImages = [#imageLiteral(resourceName: "splashScreen")]
    var MySweetHomeName =  ["Vinod"]
    var MySweetHomeRelation = ["Brother"]
    var MySweetHomeGrantAccess = ["Yes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating back buttom going back to digigate
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
        
        //Constrains & Height setting programatically
        self.addMemberButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addMemberButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            addMemberButton.heightAnchor.constraint(equalToConstant: 39),
            addMemberButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
              addMemberButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20)])
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
        let lv = NAViewPresenter().digiGateVC()
        self.navigationController?.pushViewController(lv, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return mysweethomeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! mySweetHomeCollectionViewCell
    
        cell.lbl_Name.text = MySweetHomeName[indexPath.row]
        cell.lbl_Relation.text = MySweetHomeRelation[indexPath.row]
        cell.lbl_GrantAccess.text = MySweetHomeGrantAccess[indexPath.row]
        
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
            
            let dv = NAViewPresenter().editMyDailyServices()
            self.navigationController?.pushViewController(dv, animated: true)
            dv.getTitle = NAString().edit_my_family_member_details().capitalized
            dv.getName = cell.lbl_MySweetHomeName.text!
            
            // TODO : To Change Mobile number here.
            dv.getMobile = "9725098237"
            
        }
    
    return cell
}
}

extension MySweetHomeViewController : removeCollectionProtocol{
    
    func deleteData(indx: Int, cell: UICollectionViewCell) {
        
        //AlertView will Display while remo
        let alert = UIAlertController(title: NAString().delete(), message: NAString().remove_alertview_description(), preferredStyle: .alert)
        
         let actionNO = UIAlertAction(title:NAString().no(), style: .cancel) { (action) in
            }
         let actionYES = UIAlertAction(title:NAString().yes(), style: .default) { (action) in
            
                //Remove collection view cell item with animation
                self.mysweethomeImages.remove(at: indx)
            
                //animation at final state
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            
                UIView.animate(withDuration: 0.3)
                {
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
    
    
    


