//
//  SocietyServicesDataViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/3/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import HCSStarRatingView

class AwaitingResponseViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_Title : UILabel?
    @IBOutlet weak var lbl_message : UILabel?
    @IBOutlet weak var lbl_Accepted : UILabel?
    @IBOutlet weak var lbl_Name : UILabel?
    @IBOutlet weak var lbl_Mobile : UILabel?
    @IBOutlet weak var lbl_OTP: UILabel?
    @IBOutlet weak var lbl_ServiceName : UILabel?
    @IBOutlet weak var lbl_ServiceNumber : UILabel?
    @IBOutlet weak var lbl_ServiceOTP: UILabel?
    
    @IBOutlet weak var opacity_View: UIView!
    @IBOutlet weak var rating_Parent_View: UIView!
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView?
    @IBOutlet weak var img_Title : UIImageView?
    @IBOutlet weak var cardView : UIView?
    
    @IBOutlet weak var btn_Call: UIButton!
    @IBOutlet weak var btn_Cancel: UIButton!
    
    //To set navigation title
    var navTitle : String?
    var serviceType : String?
    var notificationUID = String()
    var societyServiceRating : SocietyServiceRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_Call.setTitle(NAString().call().capitalized, for: .normal)
        self.btn_Call.backgroundColor = NAColor().buttonBgColor()
        self.btn_Call.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_Call.titleLabel?.font = NAFont().buttonFont()
        
        self.btn_Cancel.setTitle(NAString().cancel().capitalized, for: .normal)
        self.btn_Cancel.backgroundColor = NAColor().buttonBgColor()
        self.btn_Cancel.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        self.btn_Cancel.titleLabel?.font = NAFont().buttonFont()
        
        //Passing NavigationBar Title
        super.ConfigureNavBarTitle(title: navTitle!)
        
        //assigning font & style to cell labels
        lbl_Title?.font = NAFont().headerFont()
        lbl_message?.font = NAFont().headerFont()
        lbl_ServiceName?.font = NAFont().headerFont()
        lbl_ServiceNumber?.font = NAFont().headerFont()
        lbl_ServiceOTP?.font = NAFont().headerFont()
        lbl_Name?.font = NAFont().textFieldFont()
        lbl_Mobile?.font = NAFont().textFieldFont()
        lbl_OTP?.font = NAFont().textFieldFont()
        
        //cardUIView
        cardView?.layer.cornerRadius = 3
        cardView?.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        cardView?.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardView?.layer.shadowRadius = 1.7
        cardView?.layer.shadowOpacity = 0.45
        
        //Hiding History NavigationBar  RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
        
        //Hiding CardView
        cardView?.isHidden = true
        opacity_View.isHidden = true
        rating_Parent_View.isHidden = true 
        //Calling Society Service Messages Function
        self.changingSocietyServiceMessages()
        
        //created custom back button for goto MainScreen view Controller
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backBarButton"), style: .plain, target: self, action: #selector(goBackToMainScreenVC))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
    }
    
    //Navigating Back to Main Screen View Controller.
    @objc func goBackToMainScreenVC() {
        let mainScreenVC = NAViewPresenter().mainScreenVC()
        self.navigationController?.pushViewController(mainScreenVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Retrieving Society Service Accepted Data
        if !(notificationUID.isEmpty) {
            let societyServiceReference = Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL
                .child(notificationUID)
            
            societyServiceReference.observe(DataEventType.value, with: { (snapshot) in
                let societyServiceData = snapshot.value as? [String: AnyObject]
                
                //Checking whether Service Person Accepted the User Request or not
                if (societyServiceData?[NASocietyServicesFBKeys.takenBy.key] != nil &&
                    societyServiceData?[NASocietyServicesFBKeys.endOTP.key] != nil) {
                    let societyServiceUID: String = societyServiceData?[NASocietyServicesFBKeys.takenBy.key] as! String
                    let societyServiceType: String = societyServiceData?[NASocietyServicesFBKeys.societyServiceType.key] as! String
                    
                    let societyServiceDataRef = Constants.FIREBASE_SOCIETY_SERVICES
                        .child(societyServiceType)
                        .child(Constants.FIREBASE_CHILD_PRIVATE)
                        .child(Constants.FIREBASE_CHILD_DATA)
                        .child(societyServiceUID)
                    
                    //Getting Service Person Name and Mobile Number
                    societyServiceDataRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        self.lbl_Title?.isHidden = true
                        self.lbl_message?.isHidden = true
                        self.activityIndicator?.isHidden = true
                        self.cardView?.isHidden = false
                        
                        let serviceData = snapshot.value as? [String: AnyObject]
                        let societyServiceName: String = serviceData?[NASocietyServicesFBKeys.fullName.key] as! String
                        let societyServiceNumber: String = serviceData?[NASocietyServicesFBKeys.mobileNumber.key] as! String
                        
                        self.lbl_ServiceName?.text = societyServiceName
                        self.lbl_ServiceNumber?.text = societyServiceNumber
                        let endOTP: String = societyServiceData?[NASocietyServicesFBKeys.endOTP.key] as! String
                        self.lbl_ServiceOTP?.text = endOTP
                    })
                }
                let societyServiceStatus: String = societyServiceData?[NASocietyServicesFBKeys.status.key] as! String
                let societyServiceType: String = societyServiceData?[NASocietyServicesFBKeys.societyServiceType.key] as! String
                
                //ensuring if the Status is Complete.
                if societyServiceStatus == NAString().complete() {
                    self.lbl_Title?.isHidden = true
                    self.lbl_message?.isHidden = true
                    self.activityIndicator?.isHidden = true
                    self.cardView?.isHidden = true
                    self.opacity_View.isHidden = false
                    var serviceImage = UIImage()
                    var servicesType = String()
                    switch societyServiceType {
                    case NAString().plumber().lowercased():
                        serviceImage = #imageLiteral(resourceName: "plumber")
                        servicesType = NAString().plumber()
                    case NAString().carpenter().lowercased():
                        servicesType = NAString().carpenter()
                        serviceImage = #imageLiteral(resourceName: "carpenter")
                    case NAString().electrician().lowercased():
                        servicesType = NAString().carpenter().lowercased()
                        serviceImage = #imageLiteral(resourceName: "electrician")
                    default:
                        break
                        
                    }
                    self.showingRatingView(serviceTypeImage: serviceImage, serviceType: servicesType)
                }
            })
        }
    }
    
    //Create Changing the Society Service Messages Function
    func changingSocietyServiceMessages() {
        if ( serviceType == NAString().plumber()) {
            lbl_message?.text = NAString().societyServiceMessage(name: NAString().plumber())
        } else if (serviceType == NAString().carpenter()) {
            lbl_message?.text = NAString().societyServiceMessage(name: NAString().carpenter())
        } else if (serviceType == NAString().electrician()) {
            lbl_message?.text = NAString().societyServiceMessage(name: NAString().electrician())
        } else {
            lbl_message?.text = NAString().societyServiceMessage(name: NAString().garbage_Collection())
        }
    }
    
    //on Click of Submit Button
    @objc func storeRating() {
        
        let rating = self.societyServiceRating.ratingValue
        var serviceRating = Double()
        if rating == 0 {
            serviceRating = 5
        } else {
            serviceRating = Double(rating)
        }
        
        self.opacity_View.isHidden = true
        self.societyServiceRating.isHidden = true
        
        let societyServiceNotificationRef = Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL.child(notificationUID)
        societyServiceNotificationRef.child(Constants.FIREBASE_CHILD_RATING).setValue(serviceRating)
        societyServiceNotificationRef.observeSingleEvent(of: .value) { (snapshot) in
            let societyServiceData = snapshot.value as? [String: AnyObject]
            let societyServiceUID: String = societyServiceData?[NASocietyServicesFBKeys.takenBy.key] as! String
            let societyServiceType: String = societyServiceData?[NASocietyServicesFBKeys.societyServiceType.key] as! String
            
            let societyServiceDataRef = Database.database().reference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICE)
                .child(societyServiceType)
                .child(Constants.FIREBASE_CHILD_PRIVATE)
                .child(Constants.FIREBASE_CHILD_DATA)
                .child(societyServiceUID)
            societyServiceDataRef.child(Constants.FIREBASE_CHILD_RATING).observeSingleEvent(of: .value, with: { (presentRatingSnapshot) in
                if presentRatingSnapshot.exists() {
                    let presentRating = presentRatingSnapshot.value
                    let rating = presentRating as! Double
                    
                    let ratingCountRef = societyServiceDataRef.child(Constants.FIREBASE_NOTIFICATIONS).child(Constants.FIREBASE_HISTORY)
                    ratingCountRef.observeSingleEvent(of: .value, with: { (ratingSnapshot) in
                        
                        let noOfRatingsGiven = Double(ratingSnapshot.childrenCount)
                        let presentAveragerating = rating * (noOfRatingsGiven - 1)
                        let averageServiceRating = (presentAveragerating + serviceRating)/noOfRatingsGiven
                        
                        societyServiceDataRef.child(Constants.FIREBASE_CHILD_RATING).setValue(averageServiceRating)
                        self.navigationController?.popViewController(animated: true)
                    })
                } else {
                    societyServiceDataRef.child(Constants.FIREBASE_CHILD_RATING).setValue(serviceRating)
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    //Function to show Rate Us View.
    func showingRatingView(serviceTypeImage: UIImage, serviceType: String) {
        societyServiceRating = SocietyServiceRatingView(frame: CGRect(x: 0, y: 0, width: 260, height: 350))
        societyServiceRating.center.x = self.view.bounds.width/2
        societyServiceRating.center.y = self.view.bounds.height/2
        societyServiceRating.btn_Submit.titleLabel?.font = NAFont().buttonFont()
        societyServiceRating.btn_Submit.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        societyServiceRating.btn_Submit.backgroundColor = NAColor().buttonBgColor()
        societyServiceRating.lbl_Plumber.font = NAFont().headerFont()
        societyServiceRating.plumber_ImageView.image = serviceTypeImage
        societyServiceRating.lbl_Plumber.text = serviceType
        societyServiceRating.lbl_RateYour_Service.font = NAFont().labelFont()
        societyServiceRating.layer.cornerRadius = 10
        societyServiceRating.layer.masksToBounds = true
        societyServiceRating.btn_Submit.addTarget(self, action: #selector(storeRating), for: .touchUpInside)
        
        //Customized Code for Star rating
        let starRatingView: HCSStarRatingView = HCSStarRatingView()
        starRatingView.maximumValue = 5
        starRatingView.minimumValue = 0
        starRatingView.value = 1
        starRatingView.tintColor = UIColor.yellow
        starRatingView.allowsHalfStars = false
        starRatingView.emptyStarImage = UIImage(named: "EmptyStar")?.withRenderingMode(.alwaysTemplate)
        starRatingView.filledStarImage = UIImage(named: "FullStar")?.withRenderingMode(.alwaysTemplate)
        starRatingView.center = self.view.center
        societyServiceRating.view.addSubview(starRatingView)
        starRatingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(societyServiceRating)
    }
}
