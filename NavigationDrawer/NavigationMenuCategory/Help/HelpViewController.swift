//
//  HelpViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 20/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HelpViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection_View: UICollectionView!
    
    var helpArray = [NAString().frequently_asked_questions(), NAString().contact_us(), NAString().terms_and_conditions(), NAString().privacy_policy()]
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.ConfigureNavBarTitle(title: navTitle)
        collection_View.delegate = self
        collection_View.dataSource = self
        collection_View.reloadData()
        
        //Hiding History NavigationBar  RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //Get device width
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        //set section inset as per your requirement.
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: height/9)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //set minimum vertical line spacing here between two lines in collectionview
        layout.minimumLineSpacing = 10
        
        //apply defined layout to collectionview
        collection_View!.collectionViewLayout = layout
        
        //created custom back button for goto Main Screen view Controller
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToMainVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //Navigating Back to Main Screen View Controller.
    @objc func goBackToMainVC() {
        let mainScreenVC = NAViewPresenter().mainScreenVC()
        self.navigationController?.pushViewController(mainScreenVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! HelpCollectionViewCell
        cell.label_View.text = helpArray[indexPath.row]
        
        //Label formatting & setting
        cell.label_View.font = NAFont().textFieldFont()
        NAShadowEffect().shadowEffect(Cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            UIApplication.shared.open(URL(string: NAString().faqWebsiteLink())!, options: [:], completionHandler: nil)
            
        case 1:
            let helpCategoryVC = NAViewPresenter().contactUs()
            helpCategoryVC.navTitle = NAString().contact_us().capitalized
            self.navigationController?.pushViewController(helpCategoryVC, animated: true)
            
        case 2:
            UIApplication.shared.open(URL(string: NAString().termsAndConditionsWebsiteLink())!, options: [:], completionHandler: nil)
            
        case 3:
            UIApplication.shared.open(URL(string: NAString().privacyPolicyWebsiteLink())!, options: [:], completionHandler: nil)
            
        default:
            break
        }
    }
}
