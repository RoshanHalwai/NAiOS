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
        
        //Setting & Assigning User Details in the Gate Pass Card View
        let profilePhoto = GlobalUserData.shared.personalDetails_Items.first?.getprofilePhoto()
        if let urlString = profilePhoto {
            NAFirebase().downloadImageFromServerURL(urlString: urlString,imageView: self.image_View)
        }
        
        lbl_Name.text = GlobalUserData.shared.personalDetails_Items.first?.getfullName()
        lbl_SocietyName.text = GlobalUserData.shared.flatDetails_Items.first?.getsocietyName()
        lbl_FlatNumber.text = GlobalUserData.shared.flatDetails_Items.first?.getflatNumber()
        lbl_BlockNumber.text = GlobalUserData.shared.flatDetails_Items.first?.getapartmentName()
        lbl_Description.text = NAString().gatePassDescription()
        
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
        
        //Taking Snapshot of Particular UIView for storing Gate Pass in gallery
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 1.0)
        let renderer = UIGraphicsImageRenderer(size: cardView.bounds.size)
        
        renderer.image(actions: { context in
            cardView.drawHierarchy(in: cardView.bounds, afterScreenUpdates: true)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            let imageData  = UIImagePNGRepresentation(screenshot!)
            let compressedImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
            
            NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().downloadCompleted(), Message: NAString().downloadCompletedMessage(), buttonTitle: NAString().ok(), OkStyle: .default, OK: nil)
        })
    }
}
