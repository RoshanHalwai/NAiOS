////
////  GetContactsViewController.swift
////  nammaApartment
////
////  Created by Vikas Nayak on 05/05/18.
////  Copyright © 2018 Vikas Nayak. All rights reserved.
////
//
//import UIKit
//import Contacts
//
//
//class GetContactsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//    
//    //tableview outlets
//    @IBOutlet weak var tableView: UITableView!
//    
//    
//    //for taking contacts from Default app
//    var contactStore = CNContactStore()
//    var contacts = [GetContacts]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //hide
//        
//        
//    
//        //hide navigation bar
//        self.navigationController?.isNavigationBarHidden = true
//    
//        
//        //fuction to take data from contact app from IOS
//        contactStore.requestAccess(for: .contacts){(success, error)in
//            if success
//            {
//                print("Authorized successfull")
//            }
//        }
//            fetchContacts()
//    }
//
//    
//    override func didReceiveMemoryWarning()
//        {
//        super.didReceiveMemoryWarning()
//       
//    }
//    
//   
//    func fetchContacts()
//    {
//        let key = [CNContactGivenNameKey , CNContactPhoneNumbersKey] as [CNKeyDescriptor]
//        let request = CNContactFetchRequest(keysToFetch: key)
//        
//        try! contactStore.enumerateContacts(with: request) { (contact, stoppingPointer)in
//            
//            let contactName = contact.givenName
//            let contactMobile = contact.phoneNumbers.first?.value.stringValue
//            
//            let contactToAppend = GetContacts(contactName: contactName, contactMobile: contactMobile!)
//            self.contacts.append(contactToAppend)
//            
//        }
//    }
//    
//    
//    
//        func btnBackToInviteVisitor(_ sender: Any) {
//        
//         let lv : InviteVisitorViewController = self.storyboard?.instantiateViewController(withIdentifier: "inviteVisitorVC") as! InviteVisitorViewController
//        self.navigationController?.setNavigationBarHidden(true, animated: true);
//        self.navigationController?.pushViewController(lv, animated: true)
//        
//        }
//    
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return contacts.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GetContactTableViewCell
//        let contactToDisplay = contacts[indexPath.row]
//        
//        cell.lblContactName?.text = contactToDisplay.contactName
//        cell.lblContactNo?.text = contactToDisplay.contactMobile
//        
//        return cell
//        
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//
//        
//         let contactToDisplay = contacts[indexPath.row]
//        
//        let lv : InviteVisitorViewController = self.storyboard?.instantiateViewController(withIdentifier: "inviteVisitorVC") as! InviteVisitorViewController
//        
//        lv.dataName = contactToDisplay.contactName
//        lv.dataMobile = contactToDisplay.contactMobile
//
//      
//        self.navigationController?.pushViewController(lv, animated: true)
//        
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 80
//    
//    }
//
//}
