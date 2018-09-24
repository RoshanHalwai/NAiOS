//
//  EventManagementViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/16/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Razorpay

class EventManagementViewController: NANavigationViewController, RazorpayPaymentCompletionProtocol {
    
    @IBOutlet weak var btn_Parties : UIButton!
    @IBOutlet weak var btn_Concerts : UIButton!
    @IBOutlet weak var btn_Meetings : UIButton!
    @IBOutlet weak var btn_Seminars : UIButton!
    
    @IBOutlet var btn_EventHours : [UIButton]!
    
    @IBOutlet weak var btn_Book : UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btn_stackView: UIStackView!
    
    @IBOutlet weak var lbl_EventTitle: UILabel!
    @IBOutlet weak var lbl_ChooseCategory: UILabel!
    @IBOutlet weak var lbl_EventDate: UILabel!
    @IBOutlet weak var lbl_ChooseTimeSlot: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_eventValidation: UILabel!
    @IBOutlet weak var lbl_eventDateValidation: UILabel!
    @IBOutlet weak var lbl_partiesValidation: UILabel!
    @IBOutlet weak var lbl_timeSlotValidation: UILabel!
    
    @IBOutlet weak var txt_EventTitle: UITextField!
    @IBOutlet weak var txt_EventDate: UITextField!
    
    @IBOutlet weak var lbl_available: UILabel!
    @IBOutlet weak var lbl_unAvailable: UILabel!
    
    @IBOutlet weak var btn_FullDay: UIButton!
    
    //Select slot array of buttons for color changing purpose
    var selectSlotbuttons : [UIButton] = []
    var isValidSelectSlotButtonClicked: [Bool] = []
    var selectEventbuttons : [UIButton] = []
    var isValidSelectEventButtonClicked: [Bool] = []
    
    //To set navigation title
    var navTitle : String?
    
    var eventNotificationUID = String()
    var getButtonHour_Text = String()
    var getButtonCategory_Text = String()
    var eventSlot = String()
    var convertedDate = String()
    var selectedMutipleSlotsArray = [String]()
    var bookedSlotsArray = [String]()
    
    //created varible for razorPay
    var razorpay: Razorpay!
    var paymentDescription = String()
    var getUserMobileNumebr = String()
    var getUserEmailID = String()
    var getUserPendingAmount = String()
    
    var slotsCount = Int()
    var totalAmount = Int()
    var amountPerEachSlot = 100
    
    //created date picker programtically
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Payment Gateway Namma Apartment API KEY for Transactions
        razorpay = Razorpay.initWithKey("rzp_live_NpHSQJwSuvSIts", andDelegate: self)
        
        getUserMobileNumebr = (GlobalUserData.shared.personalDetails_Items.first?.getphoneNumber())!
        getUserEmailID = (GlobalUserData.shared.personalDetails_Items.first?.getemail())!
        
        for button in btn_EventHours {
            button.setTitleColor(UIColor.black, for: .selected)
            button.layer.cornerRadius = CGFloat(NAString().fifteen())
            button.layer.borderWidth = CGFloat(NAString().one())
        }
        
        //Create Event Title textfield first letter capital
        txt_EventTitle.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        //Passing NavigationBar Title
        super.ConfigureNavBarTitle(title: navTitle!)
        
        //Apply Label Fonts
        lbl_EventTitle.font = NAFont().headerFont()
        lbl_ChooseCategory.font = NAFont().headerFont()
        lbl_EventDate.font = NAFont().headerFont()
        lbl_ChooseTimeSlot.font = NAFont().headerFont()
        lbl_description.font = NAFont().headerFont()
        lbl_eventDateValidation.font = NAFont().descriptionFont()
        lbl_eventValidation.font = NAFont().descriptionFont()
        lbl_partiesValidation.font = NAFont().descriptionFont()
        lbl_timeSlotValidation.font = NAFont().descriptionFont()
        lbl_available.font = NAFont().descriptionFont()
        lbl_unAvailable.font = NAFont().descriptionFont()
        
        //Label formatting & setting
        lbl_EventTitle.text = NAString().event_title()
        lbl_ChooseCategory.text = NAString().choose_category()
        lbl_EventDate.text = NAString().event_date()
        lbl_ChooseTimeSlot.text = NAString().choose_time_slot()
        lbl_description.text = NAString().query_time_slot()
        lbl_eventValidation.text = NAString().event_Validation_Message()
        lbl_eventDateValidation.text = NAString().event_Date()
        lbl_partiesValidation.text = NAString().chooseCategory()
        lbl_timeSlotValidation.text = NAString().chooseTimeSlot()
        lbl_unAvailable.text = NAString().unavailable()
        lbl_available.text = NAString().available()
        
        //TextField formatting & setting
        txt_EventTitle.font = NAFont().textFieldFont()
        txt_EventDate.font = NAFont().textFieldFont()
        
        scrollView.layoutIfNeeded()
        self.view.layoutIfNeeded()
        txt_EventTitle.underlined()
        txt_EventDate.underlined()
        
        lbl_eventValidation.isHidden = true
        lbl_eventDateValidation.isHidden = true
        lbl_partiesValidation.isHidden = true
        lbl_timeSlotValidation.isHidden = true
        
        //assigned delegate method on textFields
        txt_EventTitle.delegate = self
        txt_EventDate.delegate = self
        
        //for changing Event buttons color
        selectEventbuttons.removeAll()
        selectEventbuttons.append(btn_Parties)
        selectEventbuttons.append(btn_Concerts)
        selectEventbuttons.append(btn_Meetings)
        selectEventbuttons.append(btn_Seminars)
        
        //Apply Button Text
        btn_Parties.setTitle(NAString().parties(), for: .normal)
        btn_Concerts.setTitle(NAString().concerts(), for: .normal)
        btn_Meetings.setTitle(NAString().meetings(), for: .normal)
        btn_Seminars.setTitle(NAString().seminar_workshops(), for: .normal)
        
        //color set on selected
        btn_Parties.setTitleColor(UIColor.black, for: .selected)
        btn_Concerts.setTitleColor(UIColor.black, for: .selected)
        btn_Meetings.setTitleColor(UIColor.black, for: .selected)
        btn_Seminars.setTitleColor(UIColor.black, for: .selected)
        
        //Button Formatting & settings
        btn_Book.setTitle(NAString().book(), for: .normal)
        btn_Book.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_Book.backgroundColor = NAColor().buttonBgColor()
        btn_Book.titleLabel?.font = NAFont().buttonFont()
        
        //set tag values to Select Slot buttons
        btn_Parties.tag = NAString().one()
        btn_Concerts.tag = NAString().two()
        btn_Meetings.tag = NAString().three()
        btn_Seminars.tag = NAString().four()
        
        //make buttons rounded corner
        btn_Parties.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_Concerts.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_Meetings.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_Seminars.layer.cornerRadius = CGFloat(NAString().fifteen())
        
        //setting border width for buttons
        btn_Parties.layer.borderWidth = CGFloat(NAString().one())
        btn_Concerts.layer.borderWidth = CGFloat(NAString().one())
        btn_Meetings.layer.borderWidth = CGFloat(NAString().one())
        btn_Seminars.layer.borderWidth = CGFloat(NAString().one())
        
        //placing image calender imgage inside the Date&Time TextField
        self.txt_EventDate.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        let image = UIImage(named: "newCalender")
        imageView.image = image
        txt_EventDate.rightView = imageView
        
        //scrollView
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0)
        
        //calling date picker function on view didload.
        createDatePicker(dateTextField: txt_EventDate)
        
        //set local date to Europe to show 24 hours
        picker.locale = Locale(identifier: "en_GB")
        
        //Creating History icon on Navigation bar
        let historyButton = UIButton(type: .system)
        historyButton.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        historyButton.addTarget(self, action: #selector(gotoSocietyServiceHistoryVC), for: .touchUpInside)
        let history = UIBarButtonItem(customView: historyButton)
        //Creating info icon on Navigation bar
        let infoButton = UIButton(type: .system)
        infoButton.setImage(#imageLiteral(resourceName: "infoButton"), for: .normal)
        infoButton.addTarget(self, action: #selector(gotofrequentlyAskedQuestionsVC), for: .touchUpInside)
        let info = UIBarButtonItem(customView: infoButton)
        
        //created Array for history and info button icons
        self.navigationItem.setRightBarButtonItems([info,history], animated: true)
    }
    
    func disabling_Slots() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
         for button in btn_EventHours {
            if button.titleLabel?.text == NAString().get_8AM_9AM() && hour >= 9 {
                 button_disabling(button: button)
                 button_disabling(button: btn_FullDay)
            }
            
            if button.titleLabel?.text == NAString().get_9AM_10AM() && hour >= 10 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_10AM_11AM() && hour >= 11 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_11AM_12PM() && hour >= 12 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_12PM_1PM() && hour >= 13 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_1PM_2PM() && hour >= 14 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_2PM_3PM() && hour >= 15 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_3PM_4PM() && hour >= 16 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_4PM_5PM() && hour >= 17 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_5PM_6PM() && hour >= 18 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_6PM_7PM() && hour >= 19 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_7PM_8PM() && hour >= 20 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_8PM_9PM() && hour >= 21 {
                button_disabling(button: button)
            }
            
            if button.titleLabel?.text == NAString().get_9PM_10PM() && hour >= 22 {
                button_disabling(button: button)
            }
        }
    }
    
    func button_disabling(button : UIButton) {
        button.isEnabled = false
        button.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    // Navigate to FAQ's WebSite
    @objc override func gotofrequentlyAskedQuestionsVC() {
        UIApplication.shared.open(URL(string: NAString().faqWebsiteLink())!, options: [:], completionHandler: nil)
    }
    
    //Create Event Title textfield first letter capital function
    @objc func valueChanged(sender: UITextField) {
        sender.text = sender.text?.capitalized
    }
    
    //for datePicker
    func createDatePicker(dateTextField : UITextField) {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        done.tag = NAString().doneButtonTagValue()
        OpacityView.shared.addButtonTagValue = done.tag
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = picker
        
        // format picker for date
        picker.datePickerMode = .date
        picker.minimumDate = NSDate() as Date
    }
    
    @objc func donePressed() {
        // format date
        let date = DateFormatter()
        date.dateFormat = NAString().dateFormat()
        let dateString = date.string(from: picker.date)
        txt_EventDate.text = dateString
        self.view.endEditing(true)
        lbl_eventDateValidation.isHidden = true
        txt_EventDate.underlined()
        OpacityView.shared.showingOpacityView(view: self)
        OpacityView.shared.showingPopupView(view: self)
        
        let getDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = NAString().dateInNumberFormat()
        let presentDate = dateFormatter.string(from: getDate)
        let dateArray = presentDate.split(separator: "-")
        let currentDay = dateArray[0]
        let currentMonth = dateArray[1]
        let currentYear = dateArray[2]
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = NAString().convertedDateInFormat()
        let showDate = inputFormatter.date(from: txt_EventDate.text!)
        inputFormatter.dateFormat = NAString().dateInNumberFormat()
        convertedDate = inputFormatter.string(from: showDate!)
        
        for button in btn_EventHours {
            button.isEnabled = true
            button.setTitleColor(UIColor.black, for: .normal)
        }
        let currentDate = currentDay + "-" + currentMonth + "-" + currentYear
        if convertedDate == currentDate {
            //Disabling Slots based on Current Date and Time
            disabling_Slots()
        }
        //Disabling Slots based on Firebase Retrieval
        disableSlots()
    }
    
    //To Navigate to Society Service History VC
    @objc func gotoSocietyServiceHistoryVC() {
        let dv = NAViewPresenter().eventManagementHistoryVC()
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    //This will call when any error occurred during transaction
    func onPaymentError(_ code: Int32, description str: String) {
        NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().failure(), Message: str, OkStyle: .default, OK: nil)
    }
    
    //This will call when transaction succeed
    func onPaymentSuccess(_ payment_id: String) {
        NAConfirmationAlert().showNotificationDialog(VC: self, Title: NAString().success(), Message: "Payment Id \(payment_id)", OkStyle: .default, OK: {action in
            let dv = NAViewPresenter().eventManagementHistoryVC()
            self.navigationController?.pushViewController(dv, animated: true)
        })
        self.storeEventManagements()
    }
    
    //This will show the default UI of RazorPay with some user’s informations.
    func showPaymentUI() {
        let options: [String:Any] = [
            //TODO: Need to give Actual Total Amount of event Slots before App Update.
            "amount" : "100",
            "description": paymentDescription,
            "name": NAString().splash_NammaHeader_Title(),
            "prefill": [
                "contact": getUserMobileNumebr,
                "email": getUserEmailID
            ],
            ]
        razorpay.open(options)
    }
    
    //creating function to highlight select Event button color
    func selectedEventButtonsColor(tag: Int) {
        for button in selectEventbuttons as [UIButton] {
            isValidSelectEventButtonClicked = [true]
            if button.tag == tag {
                button.isSelected = true
                lbl_partiesValidation.isHidden = true
            } else {
                button.isSelected = false
            }
            let color = button.isSelected ? NAColor().buttonFontColor() : UIColor.white
            button.backgroundColor = color
            button.tintColor = color
        }
    }
    
    //creating function to highlight Select Slot button color
    func selectedTimeSlotColor(tag: Int) {
        for button in selectSlotbuttons as [UIButton] {
            isValidSelectSlotButtonClicked = [true]
            if button.tag == tag {
                button.isSelected = true
                lbl_timeSlotValidation.isHidden = true
            } else {
                button.isSelected = false
            }
            let color = button.isSelected ? NAColor().buttonFontColor() : UIColor.white
            button.backgroundColor = color
            button.tintColor = color
        }
    }
    
    //creating function to highlight Select Slot button color
    func selectedMultipleTimeSlotColor(sender: UIButton) {
        let button = sender
        isValidSelectSlotButtonClicked = [true]
        if sender.isSelected {
            button.isSelected = false
            button.setTitleColor(UIColor.black, for: .selected)
        } else {
            button.isSelected = true
            //lbl_Validation_Message_Event_Slots.isHidden = true
            button.setTitleColor(UIColor.black, for: .normal)
        }
        let color = button.isSelected ? NAColor().buttonFontColor() : UIColor.white
        button.backgroundColor = color
        button.tintColor = UIColor.clear
    }
    
    //MARK : Create Button Actions
    //Create Button SelectSlot Function
    @IBAction func btnSelectSlotFunction(_ sender: UIButton) {
        selectedMultipleTimeSlotColor(sender: sender)
        sender.setTitleColor(UIColor.black, for: .selected)
        
        if sender.backgroundColor == NAColor().buttonFontColor() {
            selectedMutipleSlotsArray.append((sender.titleLabel?.text)!)
        } else {
            if selectedMutipleSlotsArray.contains((sender.titleLabel?.text)!) {
                let index = selectedMutipleSlotsArray.index(of: (sender.titleLabel?.text)!)
                selectedMutipleSlotsArray.remove(at: index!)
            }
        }
        
        if sender.titleLabel?.text == NAString().fullDaySlot() {
            if sender.backgroundColor == NAColor().buttonFontColor() {
                for button in btn_EventHours {
                    if button.titleLabel?.text != NAString().fullDaySlot() {
                        button.isEnabled = false
                        button.setTitleColor(UIColor.lightGray, for: .normal)
                        button.backgroundColor = UIColor.white
                    }
                }
            } else {
                disableSlots()
                for button in btn_EventHours {
                    button.isEnabled = true
                    button.setTitleColor(UIColor.black, for: .normal)
                }
            }
        }
        print(selectedMutipleSlotsArray)
    }
    
    //Create Button SelectEvent Function
    @IBAction func btnSelectEventFunction(_ sender: UIButton) {
        getButtonCategory_Text = (sender.titleLabel?.text)!
        selectedEventButtonsColor(tag: sender.tag)
    }
    
    //Calling Book Button Function
    @IBAction func btn_bookAction() {
        if (isValidSelectSlotButtonClicked.index(of: true) == nil) {
            lbl_timeSlotValidation.isHidden = false
            lbl_timeSlotValidation.text = NAString().chooseTimeSlot()
        } else {
            lbl_timeSlotValidation.isHidden = true
        }
        if (txt_EventTitle.text?.isEmpty)! {
            txt_EventTitle?.redunderlined()
            lbl_eventValidation.isHidden = false
        } else {
            txt_EventTitle?.underlined()
            lbl_eventValidation.isHidden = true
        }
        if (txt_EventDate.text?.isEmpty)! {
            txt_EventDate?.redunderlined()
            lbl_eventDateValidation.isHidden = false
        } else {
            txt_EventDate?.underlined()
            lbl_eventDateValidation.isHidden = true
        }
        if (isValidSelectEventButtonClicked.index(of: true) == nil) {
            lbl_partiesValidation.isHidden = false
            lbl_partiesValidation.text = NAString().chooseCategory()
        } else {
            lbl_partiesValidation.isHidden = true
        }
        if !(txt_EventTitle.text?.isEmpty)! && !(txt_EventDate.text?.isEmpty)! && (isValidSelectSlotButtonClicked.index(of: true) != nil) && (isValidSelectEventButtonClicked.index(of: true) != nil) {
            
            if selectedMutipleSlotsArray.contains(NAString().fullDaySlot()) {
                totalAmount = 1400
                slotsCount = 14
            } else {
                totalAmount = selectedMutipleSlotsArray.count * amountPerEachSlot
                slotsCount = selectedMutipleSlotsArray.count
            }
            
            NAConfirmationAlert().showConfirmationDialog(VC: self, Title: NAString().eventBill(), Message: NAString().eventSlotsAmountAlert_Message(slotsCount: slotsCount, totalAmount: totalAmount), CancelStyle: .default, OkStyle: .default, OK: { (action) in
                self.showPaymentUI()
            }, Cancel: nil, cancelActionTitle: NAString().cancel(), okActionTitle: NAString().payNow().capitalized)
        }
    }
    
    func disableSlots() {
        let evenManagementRef = Constants.FIREBASE_EVENT_MANAGEMENT.child(Constants.FIREBASE_CHILD_PRIVATE).child(convertedDate)
        evenManagementRef.observe(.value) { (snapshot) in
            if snapshot.exists() {
                let bookedSlots = snapshot.value as! NSDictionary
                self.bookedSlotsArray = bookedSlots.allKeys as! [String]
                
                for button in self.btn_EventHours {
                    if button.titleLabel?.text == NAString().fullDaySlot()  {
                        button.isEnabled = false
                        button.setTitleColor(UIColor.lightGray, for: .normal)
                        button.backgroundColor = UIColor.white
                    }
                    if self.bookedSlotsArray.contains((button.titleLabel?.text)!) {
                        button.isEnabled = false
                        button.setTitleColor(UIColor.lightGray, for: .normal)
                        button.backgroundColor = UIColor.white
                    }
                }
            }
        }
        OpacityView.shared.hidingPopupView()
        OpacityView.shared.hidingOpacityView()
    }
}

extension EventManagementViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txt_EventTitle {
            lbl_eventValidation.isHidden = true
            txt_EventTitle.underlined()
        }
        return true
    }
    
    func storeEventManagements() {
        let eventManagementRef = Constants.FIREBASE_EVENT_MANAGEMENT.child(Constants.FIREBASE_CHILD_PRIVATE).child(convertedDate)
        for slots in selectedMutipleSlotsArray {
            eventManagementRef.child(slots).setValue(NAString().gettrue())
        }
        
        let serviceType = NAString().eventManagement()
        
        let eventManagementNotificationRef = Constants.FIREBASE_SOCIETY_SERVICE_NOTIFICATION_ALL
        eventNotificationUID = eventManagementNotificationRef.childByAutoId().key
        
        let notificationUIDRef = Constants.FIREBASE_DATABASE_REFERENCE.child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION).child(Constants.FIREBASE_CHILD_EVENT_MANAGEMENT)
        notificationUIDRef.child(eventNotificationUID).setValue(NAString().gettrue())
        
        let userDataRef = GlobalUserData.shared.getUserDataReference().child(Constants.FIREBASE_CHILD_SOCIETYSERVICENOTIFICATION)
        userDataRef.child(serviceType).child(eventNotificationUID).setValue(NAString().gettrue())
        
        let eventManagementNotificationData = [
            NAEventManagementFBKeys.eventTitle.key : self.txt_EventTitle.text! as String,
            NAEventManagementFBKeys.eventDate.key : self.txt_EventDate.text! as String,
            NAEventManagementFBKeys.category.key : getButtonCategory_Text,
            NAEventManagementFBKeys.userUID.key: userUID,
            NAEventManagementFBKeys.societyServiceType.key : serviceType,
            NAEventManagementFBKeys.notificationUID.key : eventNotificationUID,
            NAEventManagementFBKeys.status.key : NAString().in_Progress()]
        eventManagementNotificationRef.child(eventNotificationUID).setValue(eventManagementNotificationData) { (error, snapshot) in
            
            for slots in self.selectedMutipleSlotsArray {
                eventManagementNotificationRef.child(self.eventNotificationUID).child(NAEventManagementFBKeys.timeSlots.key).child(slots).setValue(NAString().gettrue())
            }
            eventManagementNotificationRef.child(self.eventNotificationUID).child(Constants.FIREBASE_CHILD_TIMESTAMP).setValue(Int64(Date().timeIntervalSince1970 * 1000), withCompletionBlock: { (error, snapshot) in
            })
        }
    }
}

