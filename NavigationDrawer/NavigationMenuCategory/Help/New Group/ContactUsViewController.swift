//
//  ContactUsViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 07/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ContactUsViewController: NANavigationViewController,UITextViewDelegate {
    
    @IBOutlet weak var lbl_Select_Service_Category: UILabel!
    @IBOutlet weak var lbl_Select_Service_Type: UILabel!
    @IBOutlet weak var lbl_Describe_Your_Problem: UILabel!
    
    @IBOutlet weak var btn_Society_Services: UIButton!
    @IBOutlet weak var btn_Apartment_Services: UIButton!
    @IBOutlet weak var btn_Submit_Request: UIButton!
    
    @IBOutlet weak var txt_Choose_One: UITextField!
    
    @IBOutlet weak var txt_Describe_Your_Problem: UITextView!
    
    @IBOutlet weak var card_View: UIView!
    
    @IBOutlet weak var lbl_SelectServiceType_Validation: UILabel!
    @IBOutlet weak var lbl_DescribeYourProblem_Validation: UILabel!
    
    var navTitle = String()
    var selectedItem = String()
    
    var selectServicebuttons : [UIButton] = []
    var isValidSelectServiceButtonClicked: [Bool] = []
    
    var getServiceButton_Text = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getServiceButton_Text = NAString().societyService()
        txt_Choose_One.inputView = UIView()
        txt_Choose_One.placeholder = NAString().chooseOne()
        
        btn_Society_Services.tag = 1
        btn_Apartment_Services.tag = 2
        
        NAShadowEffect().shadowEffectForView(view: card_View)
        lbl_Select_Service_Category.text = NAString().selectServiceCategory()
        lbl_Select_Service_Type.text = NAString().selectServiceType()
        lbl_Describe_Your_Problem.text = NAString().describeYourProblem()
        lbl_SelectServiceType_Validation.text = NAString().contactUsServiceProblemValidationErrorMessage()
        lbl_DescribeYourProblem_Validation.text = NAString().contactUsServiceValidationErrorMessage()
        lbl_Select_Service_Category.font = NAFont().headerFont()
        lbl_Select_Service_Type.font = NAFont().headerFont()
        lbl_Describe_Your_Problem.font = NAFont().headerFont()
        lbl_SelectServiceType_Validation.font = NAFont().descriptionFont()
        lbl_DescribeYourProblem_Validation.font = NAFont().descriptionFont()
        
        txt_Choose_One.font = NAFont().textFieldFont()
        txt_Describe_Your_Problem.font = NAFont().textFieldFont()
        
        txt_Choose_One.delegate = self
        txt_Describe_Your_Problem.delegate = self
        
        self.view.layoutIfNeeded()
        txt_Choose_One.underlined()
        
        lbl_SelectServiceType_Validation.isHidden = true
        lbl_DescribeYourProblem_Validation.isHidden = true
        
        //Apply Button Text
        btn_Society_Services.setTitle(NAString().societyService(), for: .normal)
        btn_Apartment_Services.setTitle(NAString().ApartmentServices(), for: .normal)
        
        //color set on selected
        btn_Society_Services.setTitleColor(UIColor.black, for: .selected)
        btn_Apartment_Services.setTitleColor(UIColor.black, for: .selected)
        
        //Creating History icon on Navigation bar
        let historyButton = UIButton(type: .system)
        historyButton.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        historyButton.addTarget(self, action: #selector(gotoContactUsHistoryVC), for: .touchUpInside)
        let history = UIBarButtonItem(customView: historyButton)
        //Creating info icon on Navigation bar
        let infoButton = UIButton(type: .system)
        infoButton.setImage(#imageLiteral(resourceName: "infoButton"), for: .normal)
        infoButton.addTarget(self, action: #selector(gotofrequentlyAskedQuestionsVC), for: .touchUpInside)
        let info = UIBarButtonItem(customView: infoButton)
        
        //created Array for history and info button icons
        self.navigationItem.setRightBarButtonItems([info,history], animated: true)
        
        self.ConfigureNavBarTitle(title: navTitle)
        self.navigationItem.rightBarButtonItem = nil
        
        btn_Society_Services.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_Society_Services.layer.borderWidth = CGFloat(NAString().two())
        btn_Apartment_Services.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_Apartment_Services.layer.borderWidth = CGFloat(NAString().two())
        
        txt_Describe_Your_Problem.layer.borderColor = UIColor.black.cgColor
        txt_Describe_Your_Problem.layer.borderWidth = 2
        
        //for changing Garbage buttons color
        selectServicebuttons.removeAll()
        selectServicebuttons.append(btn_Society_Services)
        selectServicebuttons.append(btn_Apartment_Services)
        
        self.selectedServiceColor(tag: btn_Society_Services.tag)
        
        //Button Formatting & settings
        btn_Submit_Request.setTitle(NAString().submit_request(), for: .normal)
        btn_Submit_Request.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_Submit_Request.backgroundColor = NAColor().buttonBgColor()
        btn_Submit_Request.titleLabel?.font = NAFont().buttonFont()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    // Navigate to FAQ's WebSite
    @objc override func gotofrequentlyAskedQuestionsVC() {
        UIApplication.shared.open(URL(string: NAString().faqWebsiteLink())!, options: [:], completionHandler: nil)
    }
    
    @objc func gotoContactUsHistoryVC() {
        let dv = NAViewPresenter().contactUsHistoryVC()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if self.view.frame.origin.y >= 0 {
            self.view.frame.origin.y -= 100
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 100
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //creating function to highlight garbage button color
    func selectedServiceColor(tag: Int) {
        for button in selectServicebuttons as [UIButton] {
            isValidSelectServiceButtonClicked = [true]
            if button.tag == tag {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
            let color = button.isSelected ? NAColor().buttonFontColor() : UIColor.white
            button.backgroundColor = color
            button.tintColor = color
        }
    }
    
    @IBAction func btn_ServiceAction(_ sender: UIButton) {
        getServiceButton_Text = (sender.titleLabel?.text)!
        selectedServiceColor(tag: sender.tag)
        txt_Choose_One.text = ""
        txt_Describe_Your_Problem.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if selectedItem.isEmpty {
            self.txt_Choose_One.text = ""
        } else {
            self.txt_Choose_One.text = selectedItem
            selectedItem = ""
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txt_Choose_One {
            let listVC = self.storyboard!.instantiateViewController(withIdentifier: "ContactUsList") as! ContactUsListViewController
            let nav : UINavigationController = UINavigationController(rootViewController: listVC)
            listVC.navigationTitle = NAString().selectProblem()
            listVC.contactUsVC = self
            self.navigationController?.present(nav, animated: true, completion: nil)
            lbl_SelectServiceType_Validation.isHidden = true
            txt_Choose_One.underlined()
        }
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        lbl_DescribeYourProblem_Validation.isHidden = true
        return true
    }
    
    @IBAction func btn_Submit_request_Action(_ sender: UIButton) {
        if (txt_Choose_One.text?.isEmpty)! {
            lbl_SelectServiceType_Validation.isHidden = false
            txt_Choose_One.redunderlined()
        } else {
            txt_Choose_One.underlined()
            lbl_SelectServiceType_Validation.isHidden = true
        }
        if (txt_Describe_Your_Problem.text?.isEmpty)! {
            lbl_DescribeYourProblem_Validation.isHidden = false
        } else {
            lbl_DescribeYourProblem_Validation.isHidden = true
        }
        if !(txt_Choose_One.text?.isEmpty)! && !(txt_Describe_Your_Problem.text.isEmpty) {
            
            self.txt_Describe_Your_Problem.resignFirstResponder()
            storingSupportDetails()
            
            self.txt_Choose_One.text = ""
            self.txt_Describe_Your_Problem.text = ""
            
            btn_Submit_Request.tag = NAString().submittRequestButtonTagValue()
            OpacityView.shared.addButtonTagValue = btn_Submit_Request.tag
            
            OpacityView.shared.showingOpacityView(view: self)
            OpacityView.shared.showingPopupView(view: self)
        }
    }
    
    //AlertView For navigation
    func inviteAlertView() {
        //creating alert controller
        let alert = UIAlertController(title: NAString().requestRaised() , message: NAString().successfull_Support_request_Message(), preferredStyle: .alert)
        
        //creating Accept alert actions
        let okAction = UIAlertAction(title:NAString().ok(), style: .default) { (action) in
            let dv = NAViewPresenter().contactUsHistoryVC()
            dv.serviceType = self.txt_Choose_One.text!
            self.navigationController?.pushViewController(dv, animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    //Storing User problems in Firebase
    func storingSupportDetails() {
        let userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_SUPPORT)
        let problemUID : String?
        problemUID = (userDataRef.childByAutoId().key)
        
        userDataRef.child(problemUID!).setValue(NAString().gettrue())
        
        let supportRef = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_SUPPORT).child(problemUID!)
        
        let problemDetails = [
            SupportDetailsFBKeys.problemDescription.key : txt_Describe_Your_Problem.text,
            SupportDetailsFBKeys.serviceCategory.key : getServiceButton_Text.capitalized,
            SupportDetailsFBKeys.serviceType.key: selectedItem,
            SupportDetailsFBKeys.status.key : NAString().pending(),
            SupportDetailsFBKeys.timestamp.key : (Int64(Date().timeIntervalSince1970 * 1000)),
            SupportDetailsFBKeys.uid.key : problemUID as Any,
            SupportDetailsFBKeys.userUID.key : userUID]
        
        supportRef.setValue(problemDetails, withCompletionBlock: { (error, snapshot) in
            //Hiding popView & Showing AlertView after adding all the data in firebase.
            OpacityView.shared.hidingOpacityView()
            OpacityView.shared.hidingPopupView()
            self.inviteAlertView()
        })
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        txt_Choose_One.underlined()
        lbl_SelectServiceType_Validation.isHidden = true
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        lbl_DescribeYourProblem_Validation.isHidden = true
        return true
    }
}
