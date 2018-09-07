//
//  CookViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/10/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import MessageUI
import FirebaseDatabase
import MapKit

class ApartmentServicesViewController: NANavigationViewController,UICollectionViewDelegate,UICollectionViewDataSource, MFMessageComposeViewControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var titleName = String()
    var isActivityIndicatorRunning = false
    
    //Created Instance of Model Class To get data in card view
    var allDailyServicesList = [NammaApartmentDailyServices]()
    
    //Location Related Variables
    var locationManager = CLLocationManager()
    var longitude = String()
    var latitude = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Asking permissions for Location
        let status  = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            if (CLLocationManager.locationServicesEnabled()) {
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
            }
        } else {
            if status == .restricted || status == .denied {
                let alert = UIAlertController(title:NAString().location_Permission() , message: nil, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title:NAString().cancel(), style: .cancel) { (action) in}
                let settingAction = UIAlertAction(title:NAString().settings(), style: .default) { (action) in
                    UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)}
                alert.addAction(cancelAction)
                alert.addAction(settingAction)
                present(alert, animated: true, completion: nil)
            }
        }
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: titleName)
        
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        
        switch titleName {
            
        case NAString().cook():
            retrieveApartmentServicesData(serviceType: Constants.FIREBASE_DSTYPE_COOKS)
            
        case NAString().maid():
            retrieveApartmentServicesData(serviceType: Constants.FIREBASE_DSTYPE_MAIDS)
            
        case NAString().car_bike_cleaning():
            retrieveApartmentServicesData(serviceType: Constants.FIREBASE_DSTYPE_CARBIKE_CLEANER)
            
        case NAString().child_day_care():
            retrieveApartmentServicesData(serviceType: Constants.FIREBASE_DSTYPE_CHILDDAY_CARE)
            
        case NAString().daily_newspaper():
            retrieveApartmentServicesData(serviceType: Constants.FIREBASE_DSTYPE_DAILY_NEWSPAPER)
            
        case NAString().milk_man():
            retrieveApartmentServicesData(serviceType: Constants.FIREBASE_DSTYPE_MILKMEN)
            
        case NAString().laundry():
            retrieveApartmentServicesData(serviceType: Constants.FIREBASE_DSTYPE_LAUNDRIES)
            
        case NAString().driver():
            retrieveApartmentServicesData(serviceType: Constants.FIREBASE_DSTYPE_DRIVERS)
            
        case NAString().groceries():
            NAActivityIndicator.shared.hideActivityIndicator()
            NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorGroceriesServices())
            
        default:
            break
        }
        //Here Adding Observer Value Using NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(self.imageHandle(notification:)), name: Notification.Name("CallBack"), object: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let status  = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            var currentLocation: CLLocation!
            currentLocation = locationManager.location
            let latitude = currentLocation.coordinate.latitude
            let longitude = currentLocation.coordinate.longitude
            
            //Storing latitude & longitute in Firebase
            var userLocation : DatabaseReference?
            userLocation = Constants.FIREBASE_USERS_PRIVATE.child(userUID).child(Constants.FIREBASE_CHILD_OTHER_DETAILS)
            userLocation?.child(Constants.FIREBASE_CHILD_LONGITUDE).setValue(longitude)
            userLocation?.child(Constants.FIREBASE_CHILD_LATITUDE).setValue(latitude)
        }
    }
    
    //Create image Handle  Function
    @objc func imageHandle(notification: Notification) {
        DispatchQueue.main.async {
            self.isActivityIndicatorRunning = true
            self.collectionView.reloadData()
        }
    }
    
    //MARK : UICollectionView Delegate & DataSource Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allDailyServicesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! ApartmentServicesCollectionViewCell
        let dailyServicesData: NammaApartmentDailyServices
        dailyServicesData = allDailyServicesList[indexPath.row]
        
        cell.lbl_MyCookName.text = dailyServicesData.getfullName()
        
        //TODO: Need to get Actual Rating of that particular service person.
        cell.lbl_MyCookRating.text = "\(dailyServicesData.getrating())"
        //TODO: Need to Implement Time slot.
        cell.lbl_MyCookTimeSlot.text = dailyServicesData.gettimeOfVisit()
        cell.lbl_MyCookFlat.text = "\(dailyServicesData.getNumberOfFlats())"
        let queue = OperationQueue()
        
        queue.addOperation {
            if let urlString = dailyServicesData.getprofilePhoto() {
                NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: cell.myCookImage)
            }
        }
        queue.waitUntilAllOperationsAreFinished()
        
        if isActivityIndicatorRunning == false {
            cell.activity_Indicator.startAnimating()
        } else if (isActivityIndicatorRunning == true) {
            cell.activity_Indicator.stopAnimating()
            cell.activity_Indicator.isHidden = true
        }
        
        cell.lbl_CookName.font = NAFont().textFieldFont()
        cell.lbl_CookRating.font = NAFont().textFieldFont()
        cell.lbl_CookTimeSlot.font = NAFont().textFieldFont()
        cell.lbl_CookFlat.font = NAFont().textFieldFont()
        
        cell.lbl_MyCookName.font = NAFont().headerFont()
        cell.lbl_MyCookRating.font = NAFont().headerFont()
        cell.lbl_MyCookTimeSlot.font = NAFont().headerFont()
        cell.lbl_MyCookFlat.font = NAFont().headerFont()
        
        NAShadowEffect().shadowEffect(Cell: cell)
        
        //setting image round
        cell.myCookImage.layer.cornerRadius = cell.myCookImage.frame.size.width/2
        cell.myCookImage.clipsToBounds = true
        
        //Implementing Calling Function here on Phone click
        cell.actionCall = {
             UIApplication.shared.open(NSURL(string: "tel://\(dailyServicesData.getphoneNumber())")! as URL, options: [:], completionHandler: nil)
        }
        
        //Implementing Message Function here on Message click
        cell.actionMessage = {
            MFMessageComposeViewController.canSendText()
            let messageSheet : MFMessageComposeViewController = MFMessageComposeViewController()
            messageSheet.messageComposeDelegate = self
            messageSheet.recipients = [dailyServicesData.getphoneNumber()]
            messageSheet.body = NAString().sendMessageToSocietyServices()
            self.present(messageSheet, animated: true, completion: nil)
        }
        
        //Implementing Calling ShareUI here on Refer click
        //TODO: Need to remove hardcoded text
        cell.actionRefer = {
            let shareUI = UIActivityViewController(activityItems: [NAString().referToSocietyServives()], applicationActivities: nil)
            self.present(shareUI, animated: true, completion: nil)
        }
        
        //Implementing Whatsapp UI Function here on whatsapp click
        cell.actionWhatsAPP = {
            let url  = NSURL(string: NAString().sendMessageToSocietyServivesWhatsapp())
            if UIApplication.shared.canOpenURL(url! as URL) {
                UIApplication.shared.open(url! as URL, options: [:]) { (success) in
                    if success {
                        //Used print statement here, so other develper can also know if something wrong.
                        print("WhatsApp accessed successfully")
                    } else {
                        print("Error accessing WhatsApp")
                    }
                }
            }
        }
        return cell
    }
    
    //Message UI default function to dismiss UI after calling.
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func retrieveApartmentServicesData(serviceType: String) {
        NAActivityIndicator.shared.showActivityIndicator(view: self)
        let serviceDataRef = Database.database().reference().child(Constants.FIREBASE_CHILD_DAILY_SERVICES)
        serviceDataRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                
                let serviceTypeRef = serviceDataRef.child(Constants.FIREBASE_USER_CHILD_ALL).child(Constants.FIREBASE_USER_PUBLIC).child(serviceType)
                serviceTypeRef.observeSingleEvent(of: .value, with: { (serviceTypeSnapshot) in
                    if serviceTypeSnapshot.exists() {
                        
                        if let servicesTypeUID = serviceTypeSnapshot.value as? [String: Any] {
                            let servicesTypeUIDKeys = Array(servicesTypeUID.keys)
                            for serviceTypeUID in servicesTypeUIDKeys {
                                
                                let serviceOwnerRef = serviceTypeRef.child(serviceTypeUID)
                                serviceOwnerRef.observeSingleEvent(of: .value, with: { (ownerUIDSnapshot) in
                                    
                                    let flatCount = ownerUIDSnapshot.childrenCount - 1
                                    if let serviceOwnersUID = ownerUIDSnapshot.value as? [String: Any] {
                                        
                                        var servicesOwnerUIDKeys = [String]()
                                        servicesOwnerUIDKeys = Array(serviceOwnersUID.keys)
                                        let ownersUID = servicesOwnerUIDKeys[1]
                                        let serviceDataRef = serviceOwnerRef.child(ownersUID)
                                        serviceDataRef.observeSingleEvent(of: .value, with: { (dataSnapshot) in
                                            
                                            let dailyServiceData = dataSnapshot.value as? [String: AnyObject]
                                            let flats : Int = Int(flatCount)
                                            
                                            let fullName = dailyServiceData?[DailyServicesListFBKeys.fullName.key]
                                            let phoneNumber = dailyServiceData?[DailyServicesListFBKeys.phoneNumber.key]
                                            let profilePhoto = dailyServiceData?[DailyServicesListFBKeys.profilePhoto.key]
                                            let rating = dailyServiceData?[DailyServicesListFBKeys.rating.key]
                                            let timeOfVisit = dailyServiceData?[DailyServicesListFBKeys.timeOfVisit.key]
                                            let uid = dailyServiceData?[DailyServicesListFBKeys.uid.key]
                                            
                                            let serviceData = NammaApartmentDailyServices(fullName: (fullName as! String), phoneNumber: phoneNumber as? String, profilePhoto: profilePhoto as? String, providedThings: nil, rating: rating as? Int, timeOfVisit: timeOfVisit as? String, uid: (uid as! String), type: nil, numberOfFlat: flats, status: nil)
                                            
                                            self.allDailyServicesList.append(serviceData)
                                            NAActivityIndicator.shared.hideActivityIndicator()
                                            self.collectionView.reloadData()
                                        })
                                    }
                                })
                            }
                        }
                    } else {
                        NAActivityIndicator.shared.hideActivityIndicator()
                        NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorApartmentServices(serviceType: self.titleName))
                    }
                })
            } else {
                NAActivityIndicator.shared.hideActivityIndicator()
                NAFirebase().layoutFeatureUnavailable(mainView: self, newText: NAString().layoutFeatureErrorApartmentServices(serviceType: self.titleName))
            }
        }
    }
}
