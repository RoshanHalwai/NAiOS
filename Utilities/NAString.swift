//
//  NAString.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 04/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//
import Foundation
import UIKit

class NAString : NSObject {
    //Splash screen strings
    func splash_NammaHeader_Title() -> String {
        return String("Namma Apartments")
    }
    
    func society_Services_Title() -> String {
        return String("Society Services")
    }
    
    func Apartment_Services_Title() -> String {
        return String("Apartment  Services")
    }
    
    func splash_NammaApartements_Description() -> String {
        return String("One stop shop solution for all your Society needs.")
    }
    
    func splash_SocietyServices_Title() -> String {
        return String("Society Services")
    }
    
    func splash_SocietyServices_Description() -> String {
        return String("A smarter way to manage your daily needs from our dedicated service team.")
    }
    
    func splash_ApartementServices_Title() -> String {
        return String("Apartment Services")
    }
    
    func splash_ApartementServices_Description() -> String {
        return String("Enjoy benefits of all Digital Apartment Services under one umbrella with ease and control.")
    }
    
    func splash_ApartementServices_Button() -> String {
        return String("Let\'s Get Started")
    }
    
    //OTP Screen strings
    func phone_verification_activity_title() -> String {
        return String("Phone Verification")
    }
    
    func enter_verification_code(first : String ,second : String) -> String {
        return String("We need to verify \(first) account. Please enter the 6 digit verification code sent to \(second) mobile number.")
    }
    
    
    func verify_otp_button() -> String {
        return String("VERIFY OTP")
    }
    
    func incorrect_otp() -> String {
        return String("Wrong OTP has been entered")
    }
    
    func connectivity_Validation() -> String {
        return String("Please check your Network Connection")
    }
    
    //Flat Details Screen
    func My_flat_Details_title() -> String {
        return String("My Flat Details")
    }
    
    func city() -> String {
        return String("CITY")
    }
    
    func tableView_Content_size() -> String {
        return String("contentSize")
    }
    
    func society() -> String {
        return String("SOCIETY")
    }
    
    func apartment() -> String {
        return String("APARTMENT")
    }
    
    func flat() -> String {
        return String("FLAT")
    }
    
    func resident_type() -> String {
        return String("RESIDENT TYPE")
    }
    
    func owner() -> String {
        return String("Owner")
    }
    
    func tenant() -> String {
        return String("Tenant")
    }
    
    func verification_message() -> String {
        return String("Our team will verify the details provided by you. We will notify you once the verification is completed.")
    }
    
    func continue_button() -> String {
        return String("CREATE ACCOUNT")
    }
    
    func your_city() -> String {
        return String("Your City")
    }
    
    func your_society() -> String {
        return String("Your Society")
    }
    
    func your_apartment() -> String {
        return String("Your Apartment")
    }
    
    func your_flat() -> String {
        return String("Your Flat")
    }
    
    //SignUp screen
    func full_name() -> String {
        return String("FULL NAME")
    }
    
    func _91() -> String {
        return String("+91")
    }
    
    func phone_numbe() -> String {
        return String("MOBILE NUMBER")
    }
    
    func email_id() -> String {
        return String("EMAIL-ID")
    }
    
    func signup() -> String {
        return String("SIGN UP")
    }
    
    func i_agree_to_terms_and_conditions() -> String {
        return String("By clicking on SignUp I agree to NammaApartments Privacy Policy and Terms & Conditions")
    }
    
    func i_already_have_an_account() -> String {
        return String("I already have an Account")
    }
    
    func update_Alert_Title() -> String {
        return String("Update Message")
    }
    func update_Successfull_Alert_Message() -> String {
        return String("You have successfully updated your profile")
    }
    func update_Failure_Alert_Message() -> String {
        return String("You have not made any changes to your profile")
    }
    
    func change_Admin_Alert_Title() -> String {
        return String("Change Admin")
    }
    func you_are_the_Administrator() -> String {
        return String("You are the Administrator")
    }
    func change_Admin_Alert_Message() -> String {
        return String("Sorry there are no Flat members Added to your flat")
    }
    
    func change_Admin_Message_Alert_Title() -> String {
        return String("Change Admin Message")
    }
    func change_Admin_Message_Alert_Message(name: String) -> String {
        return String("Are you sure you want to make \(name) as Admin? \n Note: Your admin privileges will be transferred to \(name)")
    }
    //Signin screen and Visitor screen
    func create_an_account_button() -> String {
        return String("Create an Account")
    }
    
    func login_button() -> String {
        return String("LOGIN")
    }
    
    func please_enter_mobile_no() -> String{
        return String("Please enter your mobile number")
    }
    
    func please_enter_10_digit_no() -> String{
        return String("Please enter a valid 10 digit mobile number")
    }
    
    func please_enter_name() -> String{
        return String("Please enter name")
    }
    
    func please_upload_Image() -> String {
        return String("Please Upload Image")
    }
    
    func please_enter_email() -> String {
        return String("Please enter Email")
    }
    
    func please_select_your_relation() -> String {
        return String("Please Select Your Relation")
    }
    
    func please_enter_Valid_email() -> String {
        return String("Please enter a Valid Email address")
    }
    
    func required_mobileNo_Length() -> Int{
        return Int(10)
    }
    
    func zero_length() -> Int{
        return Int(0)
    }
    
    func one() -> Int{
        return Int(1)
    }
    
    //Home Screen
    func my_profile() -> String {
        return String("MyProfile")
    }
    func My_Profile() -> String {
        return String("My Profile")
    }
    
    func my_family_members() -> String {
        return String("My Family Members")
    }
    
    func notice_board() -> String {
        return String("Notice Board")
    }
    
    func help() -> String {
        return String("Help")
    }
    
    func rate_us() -> String {
        return String("Rate Us")
    }
    
    func logout() -> String {
        return String("Logout")
    }
    
    //Navigation Menu
    func frequently_asked_questions() -> String {
        return String("Frequently Asked Questions")
    }
    
    func using_namma_apartments_app() -> String {
        return String("Using Namma Apartments App")
    }
    
    func contact_us() -> String {
        return String("Contact Us")
    }
    
    func terms_and_conditions() -> String {
        return String("Terms and Conditions")
    }
    
    func privacy_policy() -> String {
        return String("Privacy Policy")
    }
    
    func general_settings() -> String {
        return String("General Settings")
    }
    
    func notification_settings() -> String {
        return String("Notification Settings")
    }
    
    func new_Message_Notification() -> String {
        return String("New Message Notifications")
    }
    
    func email_Notification() -> String {
        return String("Email Notifications")
    }
    
    func vibrate() -> String {
        return String("Vibrate")
    }
    
    func enable_inApp_Sound_Notification() -> String {
        return String("Enable in-app sound Notifications")
    }
    
    func product_Updates() -> String {
        return String("Product Updates")
    }
    
    func choose_Language() -> String {
        return String("Choose Language")
    }
    
    func location_services() -> String {
        return String("Location Services")
    }
    
    func report_bug() -> String {
        return String("Report A Bug")
    }
    
    func app_Version() -> String {
        return String("App Version 1.0")
    }
    
    //Particular ViewController Count
    func count_two() -> Int {
        return Int(2)
    }
    func count_four() -> Int {
        return Int(4)
    }
    
    //Society Services Activity
    func digital_gate() -> String {
        return String("Digi Gate")
    }
    
    func plumber() -> String {
        return String("Plumber")
    }
    
    func carpenter() -> String {
        return String("Carpenter")
    }
    
    func electrician() -> String {
        return String("Electrician")
    }
    
    func garbage_management() -> String {
        return String("Garbage Management")
    }
    
    func event_management() -> String
    {
        return String("Event Management")
    }
    
    func medical_emergency() -> String {
        return String("Medical Emergency")
    }
    
    func water_services() -> String {
        return String("Water Services")
    }
    
    //Apartment Services Activity
    func cook() -> String {
        return String("Cook")
    }
    
    func maid() -> String {
        return String("Maid")
    }
    
    func car_bike_cleaning() -> String {
        return String("Car/Bike Cleaning")
    }
    
    func child_day_care() -> String {
        return String("Child Day Care")
    }
    
    func daily_newspaper() -> String {
        return String("Daily NewsPaper")
    }
    
    func milk_man() -> String {
        return String("Milk Man")
    }
    
    func laundry() -> String {
        return String("Laundry")
    }
    
    func driver() -> String {
        return String("Driver")
    }
    
    func groceries() -> String {
        return String("Groceries")
    }
    
    func images_of_digital_gate_services() -> String {
        return String("Images of Digital Gate Services")
    }
    
    //Digital Gate Service Activity
    func digital_gate_title() -> String {
        return String("Digi Gate")
    }
    
    func invite_visitors() -> String {
        return String("Invite Visitors")
    }
    
    func my_visitors_list() -> String {
        return String("My Visitors List")
    }
    
    func my_daily_services() -> String {
        return String("My Daily Services")
    }
    
    func notify_digital_gate() -> String {
        return String("Notify Digital Gate")
    }
    
    func my_sweet_home() -> String {
        return String("My Sweet Home")
    }
    
    func emergency() -> String {
        return String("Emergency")
    }
    
    //Invite Visitor ViewController
    func visitorNameViewTitle() -> String {
        return String("Inviting Visitors")
    }
    
    func visitorName() -> String {
        return String("Visitor Name")
    }
    
    func visitorMobile() -> String {
        return String("Visitor Mobile")
    }
    
    func BtnselectFromContact() -> String {
        return String("Select From Contact")
    }
    
    func date_Time() -> String {
        return String("Date & Time")
    }
    
    func inviteVisitorOTPDesc(dailyServiceName : String) -> String {
        return String("We will send an OTP to your \(dailyServiceName) for authentication.")
    }
    
    func btnInvite() -> String {
        return String("INVITE")
    }
    
    func inviteButtonAlertViewMessage() -> String {
        return String("You have successfully invited your visitor")
    }
    
    func inviteButtonAlertViewTitle() -> String {
        return String("Invitation Message")
    }
    
    func inviteButtonloadViewTitle() -> String {
        return String("Inviting Your Visitor")
    }
    
    //MyVisitorList
    func myVisitorViewTitle() -> String {
        return String("Guests")
    }
    
    func myVisitorVisitor() -> String {
        return String("Visitor:")
    }
    
    func myVisitorType() -> String {
        return String("Type:")
    }
    
    func myVisitorDate() -> String {
        return String("Date:")
    }
    
    func myVisitorTime() -> String {
        return String("Time:")
    }
    
    func myVisitorInvitedBy() -> String {
        return String("Invited By:")
    }
    
    //notify Digi gate
    func notifyDigiGateHeader() -> String {
        return String("Notify Digi Gate")
    }
    
    func expecting_cab_arrival() -> String {
        return String("Expecting Cab Arrival")
    }
    
    func cab_arrival() -> String {
        return String("Cab Arrivals")
    }
    
    func package_arrival() -> String {
        return String("Package Arrivals")
    }
    
    func expecting_package_arrival() -> String {
        return String("Expecting Package Arrival")
    }
    
    func expecting_visitor() -> String {
        return String("Expecting Visitor")
    }
    
    func handed_things_to_my_guest() -> String {
        return String("Handed things to my Guest")
    }
    
    func handed_things_to_my_daily_services() -> String {
        return String("Handed things to my Daily Services")
    }
    
    func handed_Things() -> String {
        return String("Handed Things")
    }
    
    func history() -> String {
        return String("History")
    }
    
    func my_Daily_Services() -> String {
        return String("My Daily Services")
    }
    
    func package_vendor_name() -> String {
        return String("Package Vendor")
    }
    
    func notify_gate() -> String {
        return String("NOTIFY GATE")
    }
    
    func cab_number() -> String {
        return String("Cab Number")
    }
    
    func cab_no() -> String {
        return String("Cab No:")
    }
    
    func vendor() -> String {
        return String("Vendor:")
    }
    
    func valid_for() -> String {
        return String("Valid For")
    }
    
    func _1_hr() -> String {
        return String("1 hr")
    }
    
    func _2_hrs() -> String {
        return String("2 hrs")
    }
    
    func _4_hrs() -> String {
        return String("4 hrs")
    }
    
    func _6_hrs() -> String {
        return String("6 hrs")
    }
    
    func _8_hrs() -> String {
        return String("8 hrs")
    }
    
    func _12_hrs() -> String {
        return String("12 hrs")
    }
    
    func _16_hrs() -> String {
        return String("16 hrs")
    }
    
    func _24_hrs() -> String {
        return String("24 hrs")
    }
    
    //Handed things to my guest
    func yes() -> String {
        return String("Yes")
    }
    
    func no() -> String {
        return String("No")
    }
    
    func given_things() -> String {
        return String("Given Things")
    }
    
    func description() -> String {
        return String("Description:(Optional)")
    }
    
    func feature_unavailable_message() -> String {
        return String("Sorry you cannot use this feature since currently you do not have any visitors at your resident.")
    }
    
    func feature_unavailable_image_desc() -> String {
        return String("Image to indicate feature is currently unavailable to the resident.")
    }
    
    func _title_activity_daily_services() -> String {
        return String("DailyServices")
    }
    
    func notify_btnClick_Alert_title() -> String {
        return String("Handed Things Message")
    }
    
    func notify_btnClick_Alert_message() -> String {
        return String("Handed Things Notification has been sent to your Security Guard.")
    }
    
    //My daily services
    func car_bike_cleaner() -> String {
        return String("Car/Bike cleaner")
    }
    
    func child_care_taker() -> String {
        return String("Child Caretaker")
    }
    
    func newspaper_paper_man() -> String {
        return String("NewsPaper man")
    }
    
    func laundry_man() -> String {
        return String("Laundry man")
    }
    
    func remove_myDailyService_alertView_Title() -> String {
        return String("Remove Daily Service")
    }
    
    func remove_myDailyService_alertView_Message() -> String {
        return String("Are you sure you want to remove this Daily Service?  \n \n NOTE: You will stop receiving notifications related to this Daily Service.")
    }
    
    //adding my daily services
    func addMyDailyService_AlertView_Title() -> String {
        return String("Daily Service Message")
    }
    
    func add_my_service() -> String {
        return String("Add My Daily Service")
    }
    
    func name() -> String {
        return String("Name:")
    }
    
    func mobile() -> String {
        return String("Mobile:")
    }
    
    func pick_time() -> String {
        return String("In Time:")
    }
    
    func add() -> String {
        return String("Add")
    }
    
    func addButtonDailyServicesloadViewTitle() -> String {
        return String("Adding Your Daily Service")
    }
    
    func dailyServicesOTPDescription() -> String {
        return String("We need to verify your account. Please enter the 6 digit verification code from the text message")
    }
    
    func addButtonAlertViewMessage() -> String {
        return String("You have successfully added your visitor")
    }
    
    func addButtonloadViewMessage() -> String{
        return String("Please wait a moment")
    }
    
    func addMyDailyService_AlertView_Message() -> String{
        return String("You have successfully added your Daily Service.")
    }
    
    //visitor list
    func visitor() -> String {
        return String("Visitor:")
    }
    
    func type() -> String {
        return String("Type:")
    }
    
    func date() -> String {
        return String("Date:")
    }
    
    func time() -> String {
        return String("In Time:")
    }
    
    func rating() -> String {
        return String("Rating:")
    }
    
    func flats() -> String {
        return String("Flats:")
    }
    
    func inviter() -> String {
        return String("Inviter:")
    }
    
    func call() -> String {
        return String("Call")
    }
    
    func message() -> String {
        return String("Message")
    }
    
    func reschedule() -> String {
        return String("Reschedule")
    }
    
    func cancel() -> String {
        return String("Cancel")
    }
    
    func edit() -> String {
        return String("Edit")
    }
    
    //my sweet home
    func btn_mySweet_home() -> String {
        return String ("Add My Family Members")
    }
    
    func addFamilyMemberTitle() -> String {
        return String ("Add Family Members Details")
    }
    
    func addFamilyMember_AlertView_Title() -> String {
        return String ("Family Member Message")
    }
    
    func addFamilyMember_AlertView_Message() -> String{
        return String("You have successfully added your Family Member.")
    }
    
    func relation() -> String {
        return String ("Relation:")
    }
    
    func grant_access() -> String {
        return String ("Grant Access:")
    }
    
    func access() -> String {
        return String ("Access:")
    }
    
    func remove() -> String {
        return String ("Remove")
    }
    
    func otp_message_family_member(name : String) -> String {
        return String ("We will send an OTP to your \(name) for Authentication.")
    }
    func family_Member() -> String {
        return String("Family Member")
    }
    func friend() -> String {
        return String("Friend")
    }
    
    //Emergency Screen
    func tap_on_bell_icon_to_create_alert() -> String {
        return String ("Tap on bell icon to create alert")
    }
    
    func emergency_alert_Title() -> String {
        return String("Emergency Alert")
    }
    
    func emergency_Alert_Message() -> String {
        return String("Emergency notification will be sent to the Guard. Press OK to confirm")
    }
    
    func emergency_alarm_raised() -> String {
        return String ("Emergency alarm raised")
    }
    
    func medical_emergency_Title() -> String {
        return String ("Medical Emergency")
    }
    
    func raise_Fire_Alarm_Title() -> String {
        return String ("Raise Fire Alarm")
    }
    
    func raise_Theft_Alarm_Title() -> String {
        return String ("Raise Theft Alarm")
    }
    func medical() -> String {
        return String("Medical")
    }
    func fire() -> String {
        return String("Fire")
    }
    func theft() -> String {
        return String("Theft")
    }
    
    //Edit My daily services
    func edit_my_daily_service_details() -> String {
        return String ("Edit My Daily Service Details")
    }
    
    func update() -> String {
        return String ("Update")
    }
    
    func reschedule_alertBox() -> String {
        return String ("Reschedule")
    }
    
    func edit_my_family_member_details() -> String {
        return String ("Edit My Family Member Details")
    }
    
    //settings permission
    func setting_Permission_AlertBox() -> String {
        return String ("Please allow permission from settings")
    }
    
    func settings() -> String {
        return String ("Settings")
    }
    
    func edit_my_family_member_grantAccess_alertBox(first : String) -> String {
        return String ("Please note that this member will \(first) have access to all notifications.")
    }
    
    //date & time format
    func dateFormat() -> String {
        return String("MMM d, YYYY")
    }
    
    func timeFormat() -> String {
        return String("HH:mm")
    }
    
    //Misc
    func gallery() -> String {
        return String("Gallery")
    }
    
    func camera() -> String {
        return String("Camera")
    }
    
    func ok() -> String {
        return String("OK")
    }
    
    func warning() -> String {
        return String("Warning")
    }
    
    func message_warning_text() -> String {
        return String("The device can't send SMS")
    }
    
    func accept() -> String {
        return String("Accept")
    }
    
    func reject() -> String {
        return String("Reject")
    }
    
    func delete_FamilyMembers_AlertMessage() -> String {
        return String("This feature is currently unavailable")
    }
    
    func remove_invitation_message() -> String {
        return String("Are you sure you want to cancel this Invitation?")
    }
    func remove_guests_message() -> String {
        return String("Are you sure you want to remove this Guest data from the list?")
    }
    
    func edit_Message_Alert_Title() -> String {
        return String("Edit Message")
    }
    
    func add_Family_Members_Alert_Title() -> String {
        return String("Add Family Members Message")
    }
    
    func edit_Alert_Message() -> String {
        return String("Sorry you cannot edit this family member since you are not the admin of this flat")
    }
    
    func add_Family_Members_Alert_Message() -> String {
        return String("Sorry you cannot add family members to this flat since you are not the admin of this flat")
    }
    
    func delete() -> String {
        return String("Delete")
    }
    
    func cancel_invitation() -> String {
        return String("Cancel Invitation")
    }
    func remove_guest() -> String {
        return String("Remove Guests")
    }
    
    func mobile_number_not_available() -> String {
        return String("Not Available")
    }
    
    func not_granting_access() -> String {
        return String("not")
    }
    
    func granting_access() -> String {
        return String("now")
    }
    
    func guest() -> String {
        return String("Guest")
    }
    
    func cellID() -> String {
        return String ("Cell")
    }
    
    func layoutFeatureErrorVisitorList() -> String {
        return String ("Sorry you cannot use this feature since currently there are no guests at your flat.")
    }
    
    func layoutFeatureErrorCabArrivalList() -> String {
        return String ("Sorry you cannot use this feature since currently there are no cab arrivals scheduled for your flat.")
    }
    
    func layoutFeatureErrorpackageArrivalList() -> String {
        return String ("Sorry you cannot use this feature since currently there are no package arrivals scheduled for your flat.")
    }
    
    func layoutFeatureErrorHandedThingsList() -> String {
        return String ("Sorry you cannot use this feature since currently there are no guests at your flat.")
    }
    
    func layoutFeatureErrorFamilyMembersList() -> String {
        return String ("Please add your Family Members to approve visitors on your behalf.")
    }
    
    func statusNotEntered() -> String {
        return String ("Not Entered")
    }
    
    //Cab Arrival and Package Arrival Validation
    func please_fill_details(name : String) -> String {
        return String("Please Enter \(name)")
    }
    
    func Please_select_date() -> String {
        return String("Please select date and time")
    }
    
    func Please_select_expected_Hours() -> String {
        return String("Please select at least one button")
    }
    
    func Please_select_atleast_oneRelation() -> String {
        return String("Please select At least One Relation")
    }
    
    func notifyButtonAlertViewMessage() -> String {
        return String("Arrival Notification has been sent to your Security Guard.")
    }
    
    func notifyButtonAlertViewTitle() -> String {
        return String("Security Guard Notification")
    }
    
    func imageContentType() -> String {
        return String ("image/jpeg")
    }
    
    func gettrue() -> Bool {
        return Bool (true)
    }
    
    func getfalse() -> Bool {
        return Bool (false)
    }
    
    func notEntered() -> String {
        return String ("Not Entered")
    }
    func entered() -> String {
        return String("Entered")
    }
    
    //Create Button Tag Values
    func inviteButtonTagValue() -> Int {
        return Int (101)
    }
    
    func addMyFamilyMemberButtonTagValue() -> Int {
        return Int (102)
    }
    
    func addMyDailyServicesButtonTagValue() -> Int {
        return Int (103)
    }
    
    func verifyOTPButtonTagValue() -> Int {
        return Int (104)
    }
    
    func continueButtonTagValue() -> Int {
        return Int (105)
    }
    
    func editButtonTagValue() -> Int {
        return Int (106)
    }
    
    func rescheduleButtonTagValue() -> Int {
        return Int (107)
    }
    
    //Create Popup View Corner Radius
    func popupViewCornerRadius() -> Int {
        return Int (10)
    }
    
    func status() -> String {
        return String ("status")
    }
    
    func dailyServiceNotAvailable() -> String {
        return String ("Please add your Daily Services for their hassle free entry at your Society")
    }
    
    func dailyServiceNotAvailableHandedThings() -> String {
        return String ("Sorry you cannot use this feature since currently there are no daily service at your flat.")
    }
    
    func verifyingOTPDescription() -> String {
        return String ("Verifying Account")
    }
    
    func verifyingAccountDescription() -> String {
        return String ("Creating your Account")
    }
    
    //Create Society Service Plumber Screen Strings
    func selectSlot() -> String {
        return String ("Select Slot")
    }
    
    func selectProblem() -> String {
        return String ("Select Problem")
    }
    
    func immediately() -> String {
        return String ("Immediately")
    }
    
    func _9AM_12PM() -> String {
        return String ("9AM - 12PM")
    }
    
    func _12PM_3PM() -> String {
        return String ("12PM - 3PM")
    }
    
    func _3PM_5PM() -> String {
        return String ("3PM - 5PM")
    }
    
    func requestPlumber(name : String) -> String {
        return String ("REQUEST  \(name)")
    }
    
    func selectAnyProblem() -> String {
        return String ("Select Problem")
    }
    
    func societyService() -> String {
        return String ("Society Services")
    }
    
    func collectGarbage(name: String) -> String {
        return String ("\(name) Garbage")
    }
    
    func selectAnyOne() -> String {
        return String ("Select Any One")
    }
    
    func dryWaste() -> String {
        return String ("Dry Waste")
    }
    
    func wetWaste() -> String {
        return String ("Wet Waste")
    }
    
    func societyServiceLabelMessage(name: String) -> String {
        return String ("Please wait \(name) has not Responded")
    }
    
    func approver() -> String {
        return ("Approver:")
    }
}
