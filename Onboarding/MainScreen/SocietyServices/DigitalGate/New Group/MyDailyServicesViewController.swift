//
//  MyDailyViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 14/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyDailyServicesViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    //array to display items on collectionView
    var myDailyImages = [#imageLiteral(resourceName: "splashScreen")]
    var myDailyName =  ["Vikas"]
    var myDailyType = ["Cook"]
    var myDailyIntime = ["08:40"]
    var myDailyFlats = ["4"]
    var myDailyRating = ["4.2"]
    
    //for floating Button
    private var roundButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //created backbuttom custome to go to digi gate screen
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backk24"), style: .plain, target: self, action: #selector(goBackToDigiGate))
        self.navigationItem.leftBarButtonItem = backButton

        self.navigationItem.hidesBackButton = true
        
        //for creating floating button
        self.roundButton = UIButton(type: .custom)
        self.roundButton.setTitleColor(UIColor.orange, for: .normal)
        self.roundButton.layer.cornerRadius = roundButton.layer.frame.size.width/2
        self.roundButton.addTarget(self, action: #selector(self.ButtonClick(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(self.roundButton)
    
        //Formatting & setting Navigation bar
        super.ConfigureNavBarTitle(title: NAString().my_daily_services().capitalized)
    }
    
    //created custome back button to go back to digi gate
    @objc func goBackToDigiGate()
    {
        let vcName = UIStoryboard(name: "Main", bundle: nil)
        let destVC = vcName.instantiateViewController(withIdentifier: "digiGateVC")
        self.navigationController?.pushViewController(destVC, animated: true)
    }

    //for setting & formatting floating button
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        roundButton.layer.cornerRadius = roundButton.layer.frame.size.width/2
        roundButton.backgroundColor = UIColor.black
        roundButton.clipsToBounds = true
        roundButton.setImage(UIImage(named:"Floating3"), for: .normal)
        roundButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
             roundButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            roundButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            roundButton.widthAnchor.constraint(equalToConstant: 60),
            roundButton.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    //for appearing floating button on screen load
    override func viewWillAppear(_ animated: Bool) {
        self.roundButton.isHidden = false
    }
    
    //for creating action sheet to select my daily services
    @IBAction func ButtonClick(_ sender: UIButton)
    {
        let actionSheet = UIAlertController(title: "My Daily Services", message: "Choose Your Services From Here.", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Cook", style: .default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            //passing string
            let lv : AddMyDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyDetailsViewController
            
            //passing
            let cookString = NAString().inviteVisitorOTPDesc()
            let replaced = cookString.replacingOccurrences(of: "visitor", with: "Cook")
            lv.AddOtpString = replaced
            
            //temp variable
            let tempVar = "Cook account"
            lv.holdString = tempVar
            
            //passing value to my services VC
            let passVC = "myDailyServicesVC"
            lv.vcValue = passVC
            
             lv.navTitle =  NAString().add_my_service().capitalized
           self.navigationController?.setNavigationBarHidden(false, animated: true);
            self.navigationController?.pushViewController(lv, animated: true)
        })
        
        let action2 = UIAlertAction(title: "Maid", style: .default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            //passing string
            let lv : AddMyDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyDetailsViewController
            
            //passing
            let cookString = NAString().inviteVisitorOTPDesc()
            let replaced = cookString.replacingOccurrences(of: "visitor", with: "Maid")
            lv.AddOtpString = replaced
            
            // //temp variable
            let tempVar = "Maid account"
            lv.holdString = tempVar
            
            //passing value to my services VC
            let passVC = "myDailyServicesVC"
            lv.vcValue = passVC
            
             lv.navTitle =  NAString().add_my_service().capitalized
            self.navigationController?.setNavigationBarHidden(false, animated: true);
            self.navigationController?.pushViewController(lv, animated: true)
        })
        
        let action3 = UIAlertAction(title: "Car/Bike Cleaning", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //passing string
            let lv : AddMyDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyDetailsViewController
            
            //passing
            let cookString = NAString().inviteVisitorOTPDesc()
            let replaced = cookString.replacingOccurrences(of: "visitor", with: "Car/Bike Clearner")
            lv.AddOtpString = replaced
            
            //temp variable
            let tempVar = "Car/Bike Cleaner account"
            lv.holdString = tempVar
            
            //passing value to my services VC
            let passVC = "myDailyServicesVC"
            lv.vcValue = passVC
            
             lv.navTitle =  NAString().add_my_service().capitalized
            self.navigationController?.setNavigationBarHidden(false, animated: true);
            self.navigationController?.pushViewController(lv, animated: true)
        })
        
        let action4 = UIAlertAction(title: "Child Day Care", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //passing string
            let lv : AddMyDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyDetailsViewController
            
            //passing
            let cookString = NAString().inviteVisitorOTPDesc()
            let replaced = cookString.replacingOccurrences(of: "visitor", with: "Child Day Care")
            lv.AddOtpString = replaced
           
           //temp variable
            let tempVar = "Child Day Care account"
            lv.holdString = tempVar
            
            //passing value to my services VC
            let passVC = "myDailyServicesVC"
            lv.vcValue = passVC
            
             lv.navTitle =  NAString().add_my_service().capitalized
            self.navigationController?.setNavigationBarHidden(false, animated: true);
            self.navigationController?.pushViewController(lv, animated: true)
        })
        
        let action5 = UIAlertAction(title: "Daily Newspaper", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //passing string
            let lv : AddMyDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyDetailsViewController
            
            //passing
            let cookString = NAString().inviteVisitorOTPDesc()
            let replaced = cookString.replacingOccurrences(of: "visitor", with: "Newspaper Man")
            lv.AddOtpString = replaced
            
            //temp variable
            let tempVar = "Newspaper Man account"
            lv.holdString = tempVar
            
            //hide segment cotroller
            lv.segment.isHidden = true
            
            //passing value to my services VC
            let passVC = "myDailyServicesVC"
            lv.vcValue = passVC
            
             lv.navTitle =  NAString().add_my_service().capitalized
            self.navigationController?.setNavigationBarHidden(false, animated: true);
            self.navigationController?.pushViewController(lv, animated: true)
        })
        
        let action6 = UIAlertAction(title: "Milk Man", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //passing string
            let lv : AddMyDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyDetailsViewController
            
            //passing
            let cookString = NAString().inviteVisitorOTPDesc()
            let replaced = cookString.replacingOccurrences(of: "visitor", with: "Milk Man")
            lv.AddOtpString = replaced
            
            //extra
            let tempVar = "Milk man account"
            lv.holdString = tempVar
            
            //passing value to my services VC
            let passVC = "myDailyServicesVC"
            lv.vcValue = passVC
            
             lv.navTitle =  NAString().add_my_service().capitalized
            self.navigationController?.setNavigationBarHidden(false, animated: true);
            self.navigationController?.pushViewController(lv, animated: true)
        })
        
        let action7 = UIAlertAction(title: "Laundry", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //passing string
            let lv : AddMyDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyDetailsViewController
            
            //passing
            let cookString = NAString().inviteVisitorOTPDesc()
            let replaced = cookString.replacingOccurrences(of: "visitor", with: "Laundry Man")
            lv.AddOtpString = replaced
            
            //extra
            let tempVar = "Laundry man account"
            lv.holdString = tempVar
            
            //passing value to my services VC
            let passVC = "myDailyServicesVC"
            lv.vcValue = passVC
            
            lv.navTitle =  NAString().add_my_service().capitalized
            self.navigationController?.setNavigationBarHidden(false, animated: true);
            self.navigationController?.pushViewController(lv, animated: true)
        })
        
        let action8 = UIAlertAction(title: "Driver", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //passing string
            let lv : AddMyDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMyDailyServicesVC") as! AddMyDetailsViewController
            
            //passing
            let cookString = NAString().inviteVisitorOTPDesc()
            let replaced = cookString.replacingOccurrences(of: "visitor", with: "Driver")
            lv.AddOtpString = replaced
            
            //extra
            let tempVar = "Driver account"
            lv.holdString = tempVar
            
            //passing value to my services VC
            let passVC = "myDailyServicesVC"
            lv.vcValue = passVC
            
             lv.navTitle =  NAString().add_my_service().capitalized
            
            self.navigationController?.setNavigationBarHidden(false, animated: true);
            self.navigationController?.pushViewController(lv, animated: true)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
            self.roundButton.isHidden = false
        })
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(action4)
        actionSheet.addAction(action5)
        actionSheet.addAction(action6)
        actionSheet.addAction(action7)
        actionSheet.addAction(action8)
        
        actionSheet.addAction(cancel)
        
        actionSheet.view.tintColor = UIColor.black

        self.present(actionSheet, animated: true, completion: nil)
        
        self.roundButton.isHidden = true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return myDailyImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyDailyServicesCollectionViewCell
        
        cell.lbl_MyDailyServiceName.text = myDailyName[indexPath.row]
        cell.lbl_MyDailyServiceType.text = myDailyType[indexPath.row]
        cell.lbl_MyDailyServicesInTime.text = myDailyIntime[indexPath.row]
        cell.lbl_MyDailyServicesRating.text = myDailyRating[indexPath.row]
        cell.lbl_MyDailyServicesFlats.text =  myDailyFlats[indexPath.row]
    
        cell.myDailyServicesImage.image = myDailyImages[indexPath.row]
        
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
        
        //set button images in center
        cell.btn_Call.contentMode = .center
        cell.btn_Edit.contentMode = .center
        cell.btn_Cancel.contentMode = .center
        cell.btn_Message.contentMode = .center
        
        //to display image in round shape
        cell.myDailyServicesImage.layer.cornerRadius = cell.myDailyServicesImage.frame.size.width/2
        cell.myDailyServicesImage.clipsToBounds = true
        
        //Labels Formatting & setting
        cell.lbl_myDailytype.font = NAFont().headerFont()
        cell.lbl_MyDailyServiceName.font = NAFont().headerFont()
        cell.lbl_MyDailyServiceType.font = NAFont().headerFont()
        cell.lbl_MyDailyServicesInTime.font = NAFont().headerFont()
        cell.lbl_MyDailyServicesFlats.font = NAFont().headerFont()
        cell.lbl_MyDailyServicesRating.font = NAFont().headerFont()
        cell.lbl_myDailyTime.font = NAFont().headerFont()
        cell.lbl_myDailyFlats.font = NAFont().headerFont()
        cell.lbl_myDailyName.font = NAFont().headerFont()
        cell.lbl_myDailyRating.font = NAFont().headerFont()
        
        cell.lbl_myDailyName.text = NAString().name()
        cell.lbl_myDailytype.text = NAString().type()
        cell.lbl_myDailyFlats.text = NAString().flats()
        cell.lbl_myDailyTime.text = NAString().time()
        cell.lbl_myDailyRating.text = NAString().rating()
        
        //buttons formatting & setting
        cell.btn_Call.setTitle(NAString().call(), for: .normal)
        cell.btn_Message.setTitle(NAString().message(), for: .normal)
        cell.btn_Cancel.setTitle(NAString().cancel(), for: .normal)
        cell.btn_Edit.setTitle(NAString().edit(), for: .normal)
        
        return cell
    }
}
