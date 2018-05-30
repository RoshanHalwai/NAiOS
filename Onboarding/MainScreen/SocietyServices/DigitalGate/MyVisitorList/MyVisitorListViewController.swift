//
//  MyVisitorListViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 07/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyVisitorListViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate
{
    //array for displaying card view data
    var cardImageList = [#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen"),#imageLiteral(resourceName: "splashScreen")]
    var MyVisitorName = ["Vikas Nayak","Chaitanya","Vinod Kumar","Avinash"]
    var MyVisitorDate = ["May 1 2018","May 2 2018","May 3 2018","Apr 30 2017"]
    var MyVisitorType = ["Guest","Guest","Guest","Guest"]
    var MyVisitorTime = ["12:14","14:09","09:12","05:50"]
    var InvitorName = ["Vinod Kumar","Rohit Mishra","Yuvaraj","Akash Patel"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: NAString().myVisitorViewTitle())
        self.navigationItem.title = ""
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyVistorListCollectionViewCell
        
        cell.lbl_InvitedName.text = InvitorName[indexPath.row]
        cell.lbl_MyVisitorDate.text = MyVisitorDate[indexPath.row]
        cell.lbl_MyVisitorTime.text = MyVisitorTime[indexPath.row]
        cell.lbl_MyVisitorName.text = MyVisitorName[indexPath.row]
        cell.lbl_MyVisitorType.text = MyVisitorType[indexPath.row]
        cell.myVisitorImage
        .image = cardImageList[indexPath.row]
        
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
        
        //assigning font & style to cell labels
        cell.lbl_InvitedName.font = NAFont().headerFont()
        cell.lbl_MyVisitorType.font = NAFont().headerFont()
        cell.lbl_MyVisitorName.font = NAFont().headerFont()
        cell.lbl_MyVisitorDate.font = NAFont().headerFont()
        cell.lbl_MyVisitorTime.font = NAFont().headerFont()
        
        //setting image round
        cell.myVisitorImage.layer.cornerRadius = cell.myVisitorImage.frame.size.width/2
        cell.myVisitorImage.clipsToBounds = true
    
        //delete particular cell from list
        cell.index = indexPath
        cell.delegate = self

        //calling Reschdule button action on particular cell
        cell.objReschduling = {
            self.rescheduling()
        }
        return cell
    }

    //create function to generate alert with UITextFields
    func rescheduling() {
        //creating alert controller
        let alert = UIAlertController(title: NAString().reschedule_alertBox() , message: nil, preferredStyle: .alert)
    
        //datePicker toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //adding UITextField to show Date & Time
        alert.addTextField { (txt_ReDate) in
            txt_ReDate.placeholder = "Modify Date from here"
            txt_ReDate.borderStyle = UITextBorderStyle.roundedRect
            txt_ReDate.borderStyle = .none
            txt_ReDate.addConstraint(txt_ReDate.heightAnchor.constraint(equalToConstant: 40))
            //textfield formatting & Setting
            txt_ReDate.font = NAFont().textFieldFont()
        
            txt_ReDate.rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            let image = UIImage(named: "newCalender")
            imageView.image = image
            txt_ReDate.rightView = imageView
            
            //datePicker show Date Only
            let pickerDate = UIDatePicker()
            pickerDate.locale = Locale(identifier: "en_GB")
            
            txt_ReDate.inputAccessoryView = toolbar
            txt_ReDate.inputView = pickerDate
            
            pickerDate.datePickerMode = .date
            
        alert.addTextField { (txt_ReTime) in
            txt_ReTime.placeholder = "Modify Time from here"
            txt_ReTime.borderStyle = .none
            txt_ReTime.addConstraint(txt_ReTime.heightAnchor.constraint(equalToConstant: 40))
            //textfield formatting & Setting
            txt_ReTime.font = NAFont().textFieldFont()
            
            txt_ReTime.rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            let image = UIImage(named: "newClock")
            imageView.image = image
            txt_ReTime.rightView = imageView
            
            //datePicker Show Time Only
            let pickerTime = UIDatePicker()
            pickerTime.locale = Locale(identifier: "en_GB")
            
            txt_ReTime.inputAccessoryView = toolbar
            txt_ReTime.inputView = pickerTime
            
            pickerTime.datePickerMode = .time
        }
        
        //creating Reject alert actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel")
        }
        
            
        //creating Accept alert actions
        let rescheduleAction = UIAlertAction(title: "Reschedule", style: .default) { (action) in
            print("Reschedule")
        }
        
        alert.addAction(cancelAction)
        alert.addAction(rescheduleAction)
        self.present(alert, animated: true, completion: nil)
    }
        
    }
    
    //date action fucntion
    @objc func donePressed(txtDate: UITextField, picker: UIDatePicker) {
        // format date
        let date = DateFormatter()
        date.dateFormat = "MMM d, YYYY"
        let dateString = date.string(from: picker.date)
        txtDate.text = dateString
        self.view.endEditing(true)
    }
}

extension MyVisitorListViewController : dataCollectionProtocol{

    func deleteData(ind: IndexPath) {
        cardImageList.remove(at: ind.row)
        collectionView.beginInteractiveMovementForItem(at: ind)
        
        collectionView?.performBatchUpdates({() -> Void in self.collectionView?.deleteItems(at: [ind])}, completion: nil)

        collectionView.reloadData()
    }
}

