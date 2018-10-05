//
//  MyVehiclesViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/13/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyVehiclesViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btn_AddVehicle: UIButton!
    
    @IBOutlet weak var opacity_View: UIView!
    
    @IBOutlet weak var popUp_Parent_View: UIView!
    
    @IBOutlet weak var popUp_View: UIView!
    @IBOutlet weak var lbl_PopUp_Vehicle_No: UILabel!
    
    @IBOutlet weak var txt_VehicleState_Code: UITextField!
    
    @IBOutlet weak var txt_Vehicle_SerialNumberOne: UITextField!
    
    @IBOutlet weak var txt_Vehicle_SerialNumberTwo: UITextField!
    @IBOutlet weak var txt_Vehicle_Rto_Number: UITextField!
    
    @IBOutlet weak var btn_PopUp_Update: UIButton!
    @IBOutlet weak var btn_PopUp_Cancel: UIButton!
    
    @IBOutlet weak var lbl_VehicleNumber_Validation: UILabel!
    
    var navTitle = String()
    var updatedVehicleNumber = String()
    var vehicleNumber = String()
    var expectedVehicleString = String()
    var fromHomeScreenVC = false
    
    //Database References
    var userDataRef : DatabaseReference?
    var vehiclesPublicRef : DatabaseReference?
    
    var myExpectedVehicleList = [NAExpectingVehicle]()
    var vehicleUID : NAExpectingVehicle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opacity_View.isHidden = true
        popUp_Parent_View.isHidden = true
        popUp_View.isHidden = true
        lbl_VehicleNumber_Validation.isHidden = true
        
        popUp_View.layer.cornerRadius = 10
        
        text_Field_Underlined()
        
        lbl_PopUp_Vehicle_No.font = NAFont().headerFont()
        txt_VehicleState_Code.font = NAFont().textFieldFont()
        txt_Vehicle_Rto_Number.font = NAFont().textFieldFont()
        txt_Vehicle_SerialNumberOne.font = NAFont().textFieldFont()
        txt_Vehicle_SerialNumberTwo.font = NAFont().textFieldFont()
        lbl_VehicleNumber_Validation.font = NAFont().descriptionFont()
        
        txt_VehicleState_Code.delegate = self
        txt_Vehicle_SerialNumberOne.delegate = self
        txt_Vehicle_SerialNumberTwo.delegate = self
        
        btn_PopUp_Cancel.titleLabel?.font = NAFont().lato_Light_16()
        btn_PopUp_Cancel.backgroundColor = NAColor().buttonBgColor()
        btn_PopUp_Cancel.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        
        btn_PopUp_Update.titleLabel?.font = NAFont().lato_Light_16()
        btn_PopUp_Update.backgroundColor = NAColor().buttonBgColor()
        btn_PopUp_Update.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        //Button Formatting & settings
        btn_AddVehicle.setTitle(NAString().addMyVehicles().capitalized, for: .normal)
        btn_AddVehicle.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_AddVehicle.backgroundColor = NAColor().buttonBgColor()
        btn_AddVehicle.titleLabel?.font = NAFont().buttonFont()
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToHomeScreenVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set cell item size here
        layout.itemSize = CGSize(width: width - 10, height: 150)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 10
        
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if self.view.frame.origin.y >= 0 {
            self.view.frame.origin.y -= 100
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 100
    }
    
    func text_Field_Underlined() {
        txt_VehicleState_Code.underlined()
        txt_Vehicle_Rto_Number.underlined()
        txt_Vehicle_SerialNumberOne.underlined()
        txt_Vehicle_SerialNumberTwo.underlined()
    }
    
    //Navigating Back to Home Screen according to Screen coming from
    @objc func goBackToHomeScreenVC() {
        if fromHomeScreenVC {
            let vcToPop = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-NAString().count_four()]
            self.navigationController?.popToViewController(vcToPop!, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK : UICollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myExpectedVehicleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! MyVehiclesCollectionViewCell
        
        let myVehicleList : NAExpectingVehicle
        myVehicleList = myExpectedVehicleList[indexPath.row]
        
        cell.lbl_MyVehicleNumber.text = myVehicleList.getvehicleNumber()
        cell.lbl_MyVehicleOwner.text = myVehicleList.getownerName()
        cell.lbl_MyVehicleAddedOn.text = myVehicleList.getaddedDate()
        
        if  myVehicleList.getvehicleType() == NAString().car() {
            cell.myVehicleImage.image = #imageLiteral(resourceName: "car")
            cell.lbl_VehicleNumber.text = NAString().car_No()
        } else {
            cell.myVehicleImage.image = #imageLiteral(resourceName: "motorCycle")
            cell.lbl_VehicleNumber.text = NAString().bike_No()
        }
        
        cell.index = indexPath
        cell.delegate = self
        
        //assigning font & style to cell labels
        cell.lbl_MyVehicleAddedOn.font = NAFont().headerFont()
        cell.lbl_MyVehicleOwner.font = NAFont().headerFont()
        cell.lbl_MyVehicleNumber.font = NAFont().headerFont()
        cell.lbl_VehicleNumber.font = NAFont().textFieldFont()
        cell.lbl_VehicleOwner.font = NAFont().textFieldFont()
        cell.lbl_VehicleAddedOn.font = NAFont().textFieldFont()
        
        //assigning title to cell Labels
        cell.lbl_VehicleOwner.text = NAString().owner_Name()
        cell.lbl_VehicleAddedOn.text = NAString().added_On()
        
        cell.btn_Edit.titleLabel?.font = NAFont().lato_Light_16()
        cell.btn_Edit.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        cell.btn_Edit.backgroundColor = NAColor().buttonBgColor()
        
        cell.btn_Remove.titleLabel?.font = NAFont().lato_Light_16()
        cell.btn_Remove.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        cell.btn_Remove.backgroundColor = NAColor().buttonBgColor()
        
        NAShadowEffect().shadowEffectForButton(button: cell.btn_Edit)
        NAShadowEffect().shadowEffectForButton(button: cell.btn_Remove)
        
        cell.actionEdit = {
            self.opacity_View.isHidden = false
            self.popUp_Parent_View.isHidden = false
            self.popUp_View.isHidden = false
            self.updateData(index: indexPath.row, cell: cell)
            
            self.btn_PopUp_Update.addTarget(self, action: #selector(self.UpdateAction), for: .touchUpInside)
        }
        
        //setting image round
        cell.myVehicleImage.layer.cornerRadius = cell.myVehicleImage.frame.size.width/2
        cell.myVehicleImage.clipsToBounds = true
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        return cell
    }
    
    //Create Add Vehicle Button Action
    @IBAction func addVehicleButtonAction() {
        let dv = NAViewPresenter().addMyVehiclesVC()
        dv.navTitle = NAString().addMyVehicles()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    @IBAction func btn_PopUp_Cancel_Action(_ sender: UIButton) {
        self.view.endEditing(true)
        opacity_View.isHidden = true
        popUp_Parent_View.isHidden = true
        popUp_View.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieviedVehicleDataInFirebase()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Validating PopUp Vehicle Number Text Fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true}
        let vehicle_New_TextLength = text.utf16.count + string.utf16.count - range.length
        if textField == txt_VehicleState_Code {
            text_Field_validation(textField: txt_VehicleState_Code, textLength: vehicle_New_TextLength)
            if shouldChangeCustomCharacters(textField: textField, string: string) {
                if vehicleStateCodeAndSerailCodeLength(isVehicleNumberLength: vehicle_New_TextLength) {
                    return vehicle_New_TextLength <= 2
                }
                return true
            }
        }
        if textField == txt_Vehicle_Rto_Number {
            text_Field_validation(textField: txt_Vehicle_Rto_Number, textLength: vehicle_New_TextLength)
            if shouldChangeCustomCharacters(textField: textField, string: string) {
                if vehicleStateCodeAndSerailCodeLength(isVehicleNumberLength: vehicle_New_TextLength) {
                    return vehicle_New_TextLength <= 2
                }
                return true
            }
        }
        if textField == txt_Vehicle_SerialNumberOne {
            text_Field_validation(textField: txt_Vehicle_SerialNumberOne, textLength: vehicle_New_TextLength)
            if shouldChangeCustomCharacters(textField: textField, string: string) {
                if vehicleStateCodeAndSerailCodeLength(isVehicleNumberLength: vehicle_New_TextLength) {
                    return vehicle_New_TextLength <= 2
                }
                return true
            }
        }
        if textField == txt_Vehicle_SerialNumberTwo {
            text_Field_validation(textField: txt_Vehicle_SerialNumberTwo, textLength: vehicle_New_TextLength)
            return vehicle_New_TextLength <= 4
        }
        return false
    }
    
    func text_Field_validation(textField: UITextField, textLength: Int) {
        if (textLength == NAString().zero_length()) {
            textField.redunderlined()
        } else {
            lbl_VehicleNumber_Validation.isHidden = true
            textField.underlined()
        }
    }
    
    // Creating VehicleStateCodeAndSerailCodeLength Validation and vehicleSerialNumberLength Validation
    func vehicleStateCodeAndSerailCodeLength(isVehicleNumberLength: Int) -> Bool{
        if (isVehicleNumberLength >= 2) {
            return true
        } else {
            return false
        }
    }
    
    func vehicleSerialNumberLength(isVehicleSerialNumberLength: Int) -> Bool {
        if (isVehicleSerialNumberLength >= 4) {
            return true
        } else {
            return false
        }
    }
}

extension MyVehiclesViewController {
    
    func retrieviedVehicleDataInFirebase() {
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        myExpectedVehicleList.removeAll()
        userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_VEHICLES)
        
        userDataRef?.observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists() {
                self.myExpectedVehicleList.removeAll()
                let vehiclesUID = snapshot.value as? NSDictionary
                for vehicleUID in (vehiclesUID?.allKeys)! {
                    
                    //Retrieving true Mapped UID's
                    self.vehiclesPublicRef = Constants.FIREBASE_VEHICLES_PRIVATE.child(vehicleUID as! String)
                    self.vehiclesPublicRef?.observe(.value, with: { (snapshot) in
                        if snapshot.exists() {
                            let vehicleData = snapshot.value as?[String: AnyObject]
                            let vehicleType = (vehicleData?[VehicleListFBKeys.vehicleType.key] as? String)!
                            let addedDate = vehicleData?[VehicleListFBKeys.addedDate.key] as? String
                            let ownerName = GlobalUserData.shared.personalDetails_Items.first?.getfullName()
                            let vehicleNumber = vehicleData?[VehicleListFBKeys.vehicleNumber.key] as? String
                            let vehicleUID = vehicleData?[VehicleListFBKeys.vehicleUID.key] as? String
                            let vehicleDetails = NAExpectingVehicle(addedDate: addedDate,ownerName: ownerName, vehicleNumber: vehicleNumber!,vehicleType: vehicleType, vehicleUID: vehicleUID)
                            
                            self.myExpectedVehicleList.append(vehicleDetails)
                            NAActivityIndicator.shared.hideActivityIndicator()
                            self.collectionView.reloadData()
                        }
                    })
                }
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().add_your_vehicle_message())
            }
        })
    }
    
    func updateData(index: Int, cell: UICollectionViewCell) {
        vehicleUID = myExpectedVehicleList[index]
        
        vehicleNumber = vehicleUID.getvehicleNumber()
        
        let vehicleNumberArray = vehicleNumber.split(separator: "-")
        
        txt_VehicleState_Code.text = String(vehicleNumberArray[0])
        txt_Vehicle_Rto_Number.text = String(vehicleNumberArray[1])
        txt_Vehicle_SerialNumberOne.text = String(vehicleNumberArray[2])
        txt_Vehicle_SerialNumberTwo.text = String(vehicleNumberArray[3])
        text_Field_Underlined()
        lbl_VehicleNumber_Validation.isHidden = true
    }
    
    //Performing Update Button Action Functionality
    @objc func UpdateAction() {
        
        let stateCodeString = txt_VehicleState_Code.text
        let rtoString = txt_Vehicle_Rto_Number.text
        let serialNumberOneString = txt_Vehicle_SerialNumberOne.text
        let serialNumberTwoString = txt_Vehicle_SerialNumberTwo.text
        let hyphen = "-"
        
        let firstHalfVehicleNumber = stateCodeString! + hyphen + rtoString!
        let secondHalfVehicleNumber = serialNumberOneString! + hyphen + serialNumberTwoString!
        
        updatedVehicleNumber  = firstHalfVehicleNumber + hyphen + secondHalfVehicleNumber
        if vehicleNumber != updatedVehicleNumber {
            let vehiclePrivateRef = Constants.FIREBASE_VEHICLES_PRIVATE.child(vehicleUID.getVehicleUID())
            let vehicleAllRef = Constants.FIREBASE_VEHICLES_ALL
            
            if !(txt_VehicleState_Code.text?.isEmpty)! && !(txt_Vehicle_Rto_Number.text?.isEmpty)! && !(txt_Vehicle_SerialNumberOne.text?.isEmpty)! && !(txt_Vehicle_SerialNumberTwo.text?.isEmpty)! {
                vehiclePrivateRef.child(VehicleListFBKeys.vehicleNumber.key).setValue(updatedVehicleNumber)
                vehicleAllRef.child(updatedVehicleNumber).setValue(vehicleUID.getVehicleUID())
                vehicleAllRef.child(vehicleUID.getvehicleNumber()).removeValue()
                
                vehiclePrivateRef.observe(.value) { (snapshot) in
                    self.retrieviedVehicleDataInFirebase()
                }
                
                self.opacity_View.isHidden = true
                self.popUp_Parent_View.isHidden = true
                self.popUp_View.isHidden = true
            } else {
                lbl_VehicleNumber_Validation.isHidden = false
            }
        }
        self.view.endEditing(true)
    }
}

extension MyVehiclesViewController : dataRemoveProtocol {
    //Performing Remove Functionality on click of Remove Button
    func removeData(index: Int, cell: UICollectionViewCell) {
        let vehicleUID = myExpectedVehicleList[index]
        
        let userDataReference = GlobalUserData.shared.getUserDataReference()
            .child(Constants.FIREBASE_CHILD_VEHICLES)
            .child(vehicleUID.getVehicleUID())
        
        NAConfirmationAlert().showConfirmationDialog(VC: self, Title: NAString().remove_Alert_Title(), Message: NAString().remove_Alert_Message(), CancelStyle: .default, OkStyle: .destructive, OK: { (action) in
            userDataReference.removeValue()
            
            let vehiclePrivateRef = Constants.FIREBASE_VEHICLES_PRIVATE.child(vehicleUID.getVehicleUID())
            vehiclePrivateRef.removeValue()
            
            let vehicleAllRef = Constants.FIREBASE_VEHICLES_ALL.child(vehicleUID.getvehicleNumber())
            vehicleAllRef.removeValue()
            
            self.myExpectedVehicleList.remove(at: index)
            
            if self.myExpectedVehicleList.isEmpty {
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().add_your_vehicle_message())
            }
            
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
            UIView.animate(withDuration: 0.3) {
                cell.alpha = 0.0
                cell.transform = CGAffineTransform.identity
            }
            Timer.scheduledTimer(timeInterval: 0.24, target: self, selector: #selector(self.reloadCollectionData), userInfo: nil, repeats: false)
        }, Cancel: nil, cancelActionTitle: NAString().no(), okActionTitle: NAString().yes())
    }
    
    @objc func reloadCollectionData() {
        collectionView.reloadData()
    }
}
