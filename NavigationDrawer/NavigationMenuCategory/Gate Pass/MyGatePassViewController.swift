//
//  MyGatePassViewController.swift
//  nammaApartment
//
//  Created by kalpana on 10/9/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class MyGatePassViewController: NANavigationViewController {
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_SocietyName: UILabel!
    @IBOutlet weak var lbl_BlockNumber: UILabel!
    @IBOutlet weak var lbl_FlatNumber: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var btn_Download : UIButton!
    @IBOutlet weak var image_View : UIImageView!
    
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDataRef = Constants.FIREBASE_USERS_PRIVATE.child(userUID)
        //Adding observe event to each of user UID
        userDataRef.observeSingleEvent(of: .value, with: { (userDataSnapshot) in
            let usersData = userDataSnapshot.value as? [String: AnyObject]
            
            //Creating instance of UserPersonalDetails
            let userPersonalDataMap = usersData?["personalDetails"] as? [String: AnyObject]
            self.lbl_Name.text = userPersonalDataMap?[UserPersonalListFBKeys.fullName.key] as? String
            let profilePhoto = userPersonalDataMap?[UserPersonalListFBKeys.profilePhoto.key] as? String
            let queue = OperationQueue()
            
            queue.addOperation {
                //Calling function to get Profile Image from Firebase.
                if let urlString = profilePhoto {
                    NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: self.image_View)
                }
            }
            queue.waitUntilAllOperationsAreFinished()
            
            //Creating instance of UserFlatDetails
            let userFlatDataMap = usersData?["flatDetails"] as? [String: AnyObject]
            self.lbl_SocietyName.text = userFlatDataMap?[UserFlatListFBKeys.societyName.key] as? String
            self.lbl_FlatNumber.text = userFlatDataMap?[UserFlatListFBKeys.flatNumber.key] as? String
            self.lbl_BlockNumber.text = userFlatDataMap?[UserFlatListFBKeys.apartmentName.key] as? String
        })
        
        NAShadowEffect().shadowEffectForView(view: cardView)
        
        //Setting & Formatting Navigation bar
        super.ConfigureNavBarTitle(title: navTitle)
        
        //setting image round
        image_View.layer.cornerRadius = image_View.frame.size.width/2
        image_View.clipsToBounds = true
        
        //Button Formatting & settings
        btn_Download.setTitle(NAString().download(), for: .normal)
        btn_Download.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_Download.backgroundColor = NAColor().buttonBgColor()
        btn_Download.titleLabel?.font = NAFont().buttonFont()
        
        //Label formatting & setting
        lbl_Name.font = NAFont().headerFont()
        lbl_SocietyName.font = NAFont().labelFont()
        lbl_BlockNumber.font = NAFont().headerFont()
        lbl_FlatNumber.font = NAFont().headerFont()
        
        //Here Adding Observer Value Using NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(self.imageHandle(notification:)), name: Notification.Name("CallBack"), object: nil)
    }
    
    //Create image Handle  Function
    @objc func imageHandle(notification: Notification) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
        }
    }
    
    @IBAction func btnDownloadGatePass(_ sender: Any) {
        let imageData  = UIImagePNGRepresentation(UIApplication.shared.screenShot!)
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        
    }

}

extension UIApplication {
    
    var screenShot: UIImage?  {
        return keyWindow?.layer.screenShot
    }
}

extension CALayer {
    
    var screenShot: UIImage?  {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(cardView.frame.size, false, scale)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}
