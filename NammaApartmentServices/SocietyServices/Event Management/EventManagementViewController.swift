//
//  EventManagementViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/16/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var lbl_EventTitle: UILabel!
    @IBOutlet weak var lbl_ChooseCategory: UILabel!
    @IBOutlet weak var lbl_EventDate: UILabel!
    @IBOutlet weak var lbl_ChooseTimeSlot: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    
    @IBOutlet weak var txt_EventTitle: UITextField!
    @IBOutlet weak var txt_EventDate: UITextField!
    
    //Select slot array of buttons for color changing purpose
    var selectSlotbuttons : [UIButton] = []
    var isValidSelectSlotButtonClicked: [Bool] = []
    var selectEventbuttons : [UIButton] = []
    var isValidSelectEventButtonClicked: [Bool] = []
    
    //To set navigation title
    var navTitle : String?
    
    //created date picker programtically
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Passing NavigationBar Title
        super.ConfigureNavBarTitle(title: navTitle!)    
        
        //Apply Label Fonts
        lbl_EventTitle.font = NAFont().headerFont()
        lbl_ChooseCategory.font = NAFont().headerFont()
        lbl_EventDate.font = NAFont().headerFont()
        lbl_ChooseTimeSlot.font = NAFont().headerFont()
        lbl_description.font = NAFont().headerFont()
        
        //Label formatting & setting
        lbl_EventTitle.text = NAString().event_title()
        lbl_ChooseCategory.text = NAString().choose_category()
        lbl_EventDate.text = NAString().event_date()
        lbl_ChooseTimeSlot.text = NAString().choose_time_slot()
        lbl_description.text = NAString().query_time_slot()
        
        //TextField formatting & setting
        txt_EventTitle.font = NAFont().textFieldFont()
        txt_EventDate.font = NAFont().textFieldFont()
        txt_EventTitle.underlined()
        txt_EventDate.underlined()
        
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
        
        //Calling Button Color Function
        self.selectedEventButtonsColor(tag: btn_Parties.tag)
        self.selectedTimeSlotColor(tag: btn_8AMto12PM.tag)
        
        //Creating History icon on Navigation bar
        let historyButton = UIButton(type: .system)
        historyButton.setImage(#imageLiteral(resourceName: "historyButton"), for: .normal)
        historyButton.frame = CGRect(x: 0, y: 0, width: 34, height: 30)
        historyButton.addTarget(self, action: #selector(gotoSocietyServiceHistoryVC), for: .touchUpInside)
        let history = UIBarButtonItem(customView: historyButton)
        self.navigationItem.setRightBarButtonItems([history], animated: true)
    }
    
    //for datePicker
    func createDatePicker(dateTextField : UITextField) {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = picker
        
        // format picker for date
        picker.datePickerMode = .dateAndTime
        picker.minimumDate = NSDate() as Date
    }
    
    @objc func donePressed() {
        // format date
        let date = DateFormatter()
        date.dateFormat = (NAString().dateFormat() + "\t\t " + NAString().timeFormat())
        let dateString = date.string(from: picker.date)
        txt_EventDate.text = dateString
        self.view.endEditing(true)
        txt_EventDate.underlined()
    }
    
    //To Navigate to Society Service History VC
    @objc func gotoSocietyServiceHistoryVC() {
        let dv = NAViewPresenter().societyServiceHistoryVC()
        dv.titleName = NAString().history().capitalized
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
    //creating function to highlight select Event button color
    func selectedEventButtonsColor(tag: Int) {
        for button in selectEventbuttons as [UIButton] {
            isValidSelectSlotButtonClicked = [true]
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
    
    //creating function to highlight Select Slot button color
    func selectedTimeSlotColor(tag: Int) {
        for button in selectSlotbuttons as [UIButton] {
            isValidSelectEventButtonClicked = [true]
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
    
    //MARK : Create Button Actions
    
    //Create Button SelectSlot Function
    @IBAction func btnSelectSlotFunction(_ sender: UIButton) {
        selectedTimeSlotColor(tag: sender.tag)
    }
    //Create Button SelectEvent Function
    @IBAction func btnSelectEventFunction(_ sender: UIButton) {
        selectedEventButtonsColor(tag: sender.tag)
    }
    //Calling Book Button Function
    @IBAction func btn_bookAction() {
    }
}
