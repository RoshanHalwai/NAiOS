//
//  DonateFoodHistoryViewController.swift
//  
//
//  Created by kalpana on 9/19/18.
//

import UIKit

class DonateFoodHistoryViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userFoodDonationDetails = [NAUserFoodDonations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ConfigureNavBarTitle(title: NAString().history().capitalized)
        self.navigationItem.rightBarButtonItem = nil
        retrievingFoodDonationsData()
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: 240)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userFoodDonationDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as? DonateFoodHistoryCollectionViewCell
        
        let foodDonationDetails : NAUserFoodDonations
        foodDonationDetails = userFoodDonationDetails[indexPath.row]
        
        let timeStamp = foodDonationDetails.getTimeStamp()
        let date = (NSDate(timeIntervalSince1970: TimeInterval(timeStamp/1000)))
        let dateString = String(describing: date)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = NAString().userProblemTimeStampFormat()
        let dateAndTime = dateFormatterGet.date(from: dateString)
        dateFormatterGet.dateFormat = NAString().convertedUserProblemTimeStampFormat()
        let userRequestTime = (dateFormatterGet.string(from: dateAndTime!))
        
        cell?.lbl_FoodType_Detail.text = foodDonationDetails.getFoodType()
        cell?.lbl_FoodQuantity_Detail.text = foodDonationDetails.getFoodQuantity()
        cell?.lbl_Date_Detail.text = userRequestTime
        
        //TODO : Feature Added Donate Food Image
        cell?.img_Profile.image = UIImage(named: "customer-support")
        
        cell?.lbl_FoodType.font = NAFont().textFieldFont()
        cell?.lbl_FoodQuantity_Type.font = NAFont().textFieldFont()
        cell?.lbl_Date_Type.font = NAFont().textFieldFont()
        
        cell?.lbl_FoodType_Detail.font = NAFont().headerFont()
        cell?.lbl_FoodQuantity_Detail.font = NAFont().headerFont()
        cell?.lbl_Date_Detail.font = NAFont().headerFont()
        
        //setting image round
        cell?.img_Profile.layer.cornerRadius = (cell?.img_Profile.frame.size.width)!/2
        cell?.img_Profile.clipsToBounds = true
        
        NAShadowEffect().shadowEffect(Cell: cell!)
        return cell!
    }
    
    func retrievingFoodDonationsData() {
        
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        let userFoodDonationDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_DONATEFOOD)
        
        userFoodDonationDataRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                let foodDonationsUID = snapshot.value as? NSDictionary
                for foodDonationUID in (foodDonationsUID?.allKeys)! {
                    let foodDonationRef = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_DONATEFOOD).child(foodDonationUID as! String)
                    foodDonationRef.observeSingleEvent(of: .value, with: { (foodDonationSnapshot) in
                        let userfoodDonationsData = foodDonationSnapshot.value as? [String: AnyObject]
                        
                        let foodType = userfoodDonationsData![DonateFoodListFBKeys.foodType.key]
                        let foodQuantity = userfoodDonationsData![DonateFoodListFBKeys.foodQuantity.key]
                        let timestamp = (userfoodDonationsData![DonateFoodListFBKeys.timeStamp.key])
                        
                        let foodDonationsData = NAUserFoodDonations(foodQuantity: foodQuantity as! String, foodType: foodType as! String, timeStamp: Int(truncating: timestamp! as! NSNumber))
                        
                        self.userFoodDonationDetails.append(foodDonationsData)
                        NAActivityIndicator.shared.hideActivityIndicator()
                        self.collectionView.reloadData()
                    })
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorUserFoodDonations())
            }
        }
    }
}
