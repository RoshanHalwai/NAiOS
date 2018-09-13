//
//  EventManagementViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/16/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventManagementViewController: NANavigationViewController {
    
    @IBOutlet weak var btn_Parties : UIButton!
    @IBOutlet weak var btn_Concerts : UIButton!
    @IBOutlet weak var btn_Meetings : UIButton!
    @IBOutlet weak var btn_Seminars : UIButton!
    
    @IBOutlet weak var btn_8AMto12PM : UIButton!
    @IBOutlet weak var btn_12PMto4PM : UIButton!
    @IBOutlet weak var btn_4PMto8PM : UIButton!
    @IBOutlet weak var btn_8PMto12PM : UIButton!
    
    @IBOutlet weak var btn_Book : UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var timeSlot_stackView: UIStackView!
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
    
    //created date picker programtically
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hiding TimeSlot StackView
        timeSlot_stackView.isHidden = true
        
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
        
        //for changing Select Slot buttons color
        selectSlotbuttons.removeAll()
        selectSlotbuttons.append(btn_8AMto12PM)
        selectSlotbuttons.append(btn_12PMto4PM)
        selectSlotbuttons.append(btn_4PMto8PM)
        selectSlotbuttons.append(btn_8PMto12PM)
        
        //for changing Event buttons color
        selectEventbuttons.removeAll()
        selectEventbuttons.append(btn_Parties)
        selectEventbuttons.append(btn_Concerts)
        selectEventbuttons.append(btn_Meetings)
        selectEventbuttons.append(btn_Seminars)
        
        //Apply Button Text
        btn_8AMto12PM.setTitle(NAString().morning(), for: .normal)
        btn_12PMto4PM.setTitle(NAString().noon(), for: .normal)
        btn_4PMto8PM.setTitle(NAString().evening(), for: .normal)
        btn_8PMto12PM.setTitle(NAString().night(), for: .normal)
        btn_Parties.setTitle(NAString().parties(), for: .normal)
        btn_Concerts.setTitle(NAString().concerts(), for: .normal)
        btn_Meetings.setTitle(NAString().meetings(), for: .normal)
        btn_Seminars.setTitle(NAString().seminar_workshops(), for: .normal)
        
        //color set on selected
        btn_8AMto12PM.setTitleColor(UIColor.black, for: .selected)
        btn_12PMto4PM.setTitleColor(UIColor.black, for: .selected)
        btn_4PMto8PM.setTitleColor(UIColor.black, for: .selected)
        btn_8PMto12PM.setTitleColor(UIColor.black, for: .selected)
        btn_Parties.setTitleColor(UIColor.black, for: .selected)
        btn_Concerts.setTitleColor(UIColor.black, for: .selected)
        btn_Meetings.setTitleColor(UIColor.black, for: .selected)
        btn_Seminars.setTitleColor(UIColor.black, for: .selected)
        
        //Button Formatting & settings
        btn_Book.setTitle(NAString().book(), for: .normal)
        btn_Book.setTitleColor(NAColor().buttonFontColor(), for: .normal)
        btn_Book.backgroundColor = NAColor().buttonBgColor()
        btn_Book.titleLabel?.font = NAFont().buttonFont()
        
        //set tag values to Select Event buttons
        btn_8AMto12PM.tag = NAString().one()
        btn_12PMto4PM.tag = NAString().two()
        btn_4PMto8PM.tag = NAString().three()
        btn_8PMto12PM.tag = NAString().four()
        
        //set tag values to Select Slot buttons
        btn_Parties.tag = NAString().one()
        btn_Concerts.tag = NAString().two()
        btn_Meetings.tag = NAString().three()
        btn_Seminars.tag = NAString().four()
        
        //make buttons rounded corner
        btn_8AMto12PM.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_12PMto4PM.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_4PMto8PM.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_8PMto12PM.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_Parties.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_Concerts.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_Meetings.layer.cornerRadius = CGFloat(NAString().fifteen())
        btn_Seminars.layer.cornerRadius = CGFloat(NAString().fifteen())
        
        //setting border width for buttons
        btn_8AMto12PM.layer.borderWidth = CGFloat(NAString().one())
        btn_12PMto4PM.layer.borderWidth = CGFloat(NAString().one())
        btn_4PMto8PM.layer.borderWidth = CGFloat(NAString().one())
        btn_8PMto12PM.layer.borderWidth = CGFloat(NAString().one())
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
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = NAString().convertedDateInFormat()
        let showDate = inputFormatter.date(from: txt_EventDate.text!)
        inputFormatter.dateFormat = NAString().dateInNumberFormat()
        convertedDate = inputFormatter.string(from: showDate!)
        //Calling disable booked slot function here
        disableBookedSlot()
    }
    
    //To Navigate to Society Service History VC
    @objc func gotoSocietyServiceHistoryVC() {
        let dv = NAViewPresenter().societyServiceHistoryVC()
        dv.titleName = NAString().history().capitalized
        dv.navigationTitle = NAString().eventManagement()
        self.navigationController?.pushViewController(dv, animated: true)
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
    
    //MARK : Create Button Actions
    //Create Button SelectSlot Function
    @IBAction func btnSelectSlotFunction(_ sender: UIButton) {
        getButtonHour_Text = (sender.titleLabel?.text)!
        selectedTimeSlotColor(tag: sender.tag)
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
            self.storeEventManagementDetails()
        }
    }
}

extension EventManagementViewController {
    
    //Storing User requests of Society service Problems
    func storeEventManagementDetails() {
        
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
            NAEventManagementFBKeys.timeSlot.key : getButtonHour_Text,
            NAEventManagementFBKeys.userUID.key: userUID,
            NAEventManagementFBKeys.societyServiceType.key : serviceType,
            NAEventManagementFBKeys.notificationUID.key : eventNotificationUID,
            NAEventManagementFBKeys.status.key : NAString().in_Progress()]
        
        eventManagementNotificationRef.child(eventNotificationUID).setValue(eventManagementNotificationData) { (error, snapshot) in
            //Storing Current System time in milli seconds for time stamp.
            eventManagementNotificationRef.child(self.eventNotificationUID).child(Constants.FIREBASE_CHILD_TIMESTAMP).setValue(Int64(Date().timeIntervalSince1970 * 1000), withCompletionBlock: { (error, snapshot) in
                
                self.storeEventManagementSlot()
                let lv = NAViewPresenter().showEventManagementVC()
                lv.navTitle = NAString().event_management()
                lv.getEventUID = self.eventNotificationUID
                self.navigationController?.pushViewController(lv, animated: true)
            })
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txt_EventTitle {
            lbl_eventValidation.isHidden = true
            txt_EventTitle.underlined()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        timeSlot_stackView.isHidden = false
    }
    
    func storeEventManagementSlot() {
        
        switch getButtonHour_Text {
        case NAString().morning():
            eventSlot = Constants.FIREBASE_CHILD_SLOT1
        case NAString().noon():
            eventSlot = Constants.FIREBASE_CHILD_SLOT2
        case NAString().evening():
            eventSlot = Constants.FIREBASE_CHILD_SLOT3
        case NAString().night():
            eventSlot = Constants.FIREBASE_CHILD_SLOT4
        default:
            break
        }
        
        var eventSlotRef : DatabaseReference?
        eventSlotRef = Constants.FIREBASE_EVENT_MANAGEMENT.child(convertedDate)
        eventSlotRef?.child(eventSlot).setValue(NAString().gettrue())
    }
    
    //Created Function to get booked slot for the selected date.
    func disableBookedSlot() {
        
        let bookedEventSlotRef = Constants.FIREBASE_EVENT_MANAGEMENT.child(convertedDate)
        
        bookedEventSlotRef.observeSingleEvent(of: .value) { (slotSnapshot) in
            if slotSnapshot.exists() {
                let slotNumbers = slotSnapshot.value as? NSDictionary
                for slots in (slotNumbers?.allKeys)! {
                    
                    switch slots as! String {
                    case Constants.FIREBASE_CHILD_SLOT1 :
                        self.btn_8AMto12PM.isEnabled = false
                        self.btn_8AMto12PM.setTitleColor(UIColor.gray, for: .normal)
                        
                    case Constants.FIREBASE_CHILD_SLOT2 :
                        self.btn_12PMto4PM.isEnabled = false
                        self.btn_12PMto4PM.setTitleColor(UIColor.gray, for: .normal)
                        
                    case Constants.FIREBASE_CHILD_SLOT3 :
                        self.btn_4PMto8PM.isEnabled = false
                        self.btn_4PMto8PM.setTitleColor(UIColor.gray, for: .normal)
                        
                    case Constants.FIREBASE_CHILD_SLOT4 :
                        self.btn_8PMto12PM.isEnabled = false
                        self.btn_8PMto12PM.setTitleColor(UIColor.gray, for: .normal)
                        
                    default:
                        break
                    }
                }
            }
            OpacityView.shared.hidingOpacityView()
            OpacityView.shared.hidingPopupView()
        }
    }
}

