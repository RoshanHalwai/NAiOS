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
    
    func chooseCategory() -> String {
        return String("Please choose Category")
    }
    
    func chooseTimeSlot() -> String {
        return String("Please choose Time Slot")
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
        return String("By clicking on Sign Up, I agree to Namma Apartments Privacy Policy and Terms & Conditions")
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
        return String("Please Enter Mobile Number")
    }
    
    func please_enter_your_mobile_no() -> String{
        return String("Please Enter Your Mobile Number")
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
    
    func please_select_your_problem() -> String {
        return String("Please Select Your Problem")
    }
    
    func please_enter_your_problem() -> String {
        return String("Please Enter Your Problem")
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
    
    func two() -> Int{
        return Int(2)
    }
    
    func three() -> Int{
        return Int(3)
    }
    
    func four() -> Int{
        return Int(4)
    }
    
    func fifteen() -> Int{
        return Int(15)
    }
    
    //Home Screen
    func My_Profile() -> String {
        return String("My Profile")
    }
    
    func my_family_members() -> String {
        return String("My Family Members")
    }
    
    func my_vehicles() -> String {
        return String("My Vehicles")
    }
    
    func my_guards() -> String {
        return String("My Guards")
    }
    
    func notice_board() -> String {
        return String("Notice Board")
    }
    func logout_Confirmation_Title() -> String {
        return String("Logout Message")
    }
    func logout_Confirmation_Message() -> String {
        return String("Are you sure you want to logout?")
    }
    
    func help() -> String {
        return String("Help")
    }
    
    func rate_us() -> String {
        return String("Rate Us")
    }
    
    func signout() -> String {
        return String("SIGN OUT")
    }
    
    //Navigation Menu
    func frequently_asked_questions() -> String {
        return String("Frequently Asked Questions")
    }
    
    func faqs() -> String {
        return String("FAQs")
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
    
    func sound_settings() -> String {
        return String("Sound Settings")
    }
    
    func language() -> String {
        return String("Language")
    }
    
    func signOut() -> String {
        return String("SIGN OUT")
    }
    
    func eIntercom() -> String {
        return String("E-Intercom")
    }
    
    func eIntercom_Notification() -> String {
        return String("E-Intercom Notifications")
    }
    
    func guest_Notification() -> String {
        return String("Guest Notifications")
    }
    
    func cab_Notification() -> String {
        return String("Cab Notifications")
    }
    
    func package_Notification() -> String {
        return String("Package Notifications")
    }
    
    func vibrate() -> String {
        return String("Vibrate")
    }
    
    func dailyService_Notification() -> String {
        return String("Daily Service Notifications")
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
    
    func full_Address() -> String {
        return String("Full Address:")
    }
    
    func address_Detail() -> String {
        return String("For any queries, contact: \n\n Full Address: \n #59/2, \n Kirtan Labs, \n 9th Cross, Tulasi Theatre Road, \n Marathahalli,\n Bengaluru - 560037, \n Karanataka \n\n Landmark: Behind Innovative Multiplex \n\n Contact No: \n Ashish Jha \n Mob No: +91-9986553474 \n E-mail: iamashishjha@gmail.com")
    }
    
    func privacy_policy_Detail() -> String {
        return String("Namma Apartments respects the privacy of our users and has developed this Privacy Policy to demonstrate its commitment to protecting your privacy. \n\n These privacy policies (the 'Privacy Policy') are intended to describe for you, as an individual who is a user of Namma Apartments or any of our related sites, mobile and connected applications, or other online services, the information we collect, how that information may be used, with whom it may be shared, and your choices about such uses and disclosures. \n\n  We encourage you to read this Privacy Policy carefully when using our website or services or transacting business with us. By using our websites or any of our applications, you are accepting the practices described in this Privacy Policy.")
    }
    
    func termsAndConditions_Detail() -> String {
        return String(" Please read these terms and conditions carefully before using Namma Apartments Mobile Application, operated by Kirtan Labs. \n\n Conditions of Use: \n We will provide their services to you, which are subject to the conditions stated below in this document. Every time you visit this application, use its services or make a purchase, you accept the following conditions. This is why we urge you to read them carefully. \n\n Privacy Policy: \n Before you continue using our application, we advise you to read our privacy policy regarding our user data collection. It will help you better understand our practices. Copyright Content published on this website (digital downloads, images, texts, graphics, logos) is the property of Kirtan Labs and/or its content creators and protected by international copyright laws. The entire compilation of the content found on this website is the exclusive property of Kirtan Labs, with copyright authorship for this compilation by Kirtan Labs. \n\n Communications: \n The entire communication with us is electronic. Every time you send us an email or visit our application, you are going to be communicating with us. You hereby consent to receive communications from us. If you subscribe to the news on our website, you are going to receive regular emails from us. We will continue to communicate with you by posting news and notices on our application and by sending you emails. You also agree that all notices, disclosures, agreements and other communications we provide to you electronically meet the legal requirements that such communications be in writing. \n\n Law: \n By visiting this website, you agree that the laws of the Government of India, without regard to principles of conflict laws, will govern these terms and conditions, or any dispute of any sort that might come between Kirtan Labs and you, or its business partners and associates. \n\n Disputes: \n Any dispute related in any way to your visit to this website or to products you purchase from us shall be arbitrated by state or federal court of Government of India and you consent to exclusive jurisdiction and venue of such courts. Comments, Reviews, and Emails Visitors may post content as long as it is not obscene, illegal, defamatory, threatening, infringing. \n\n User Account: \n If you are an owner of an account on this application, you are solely responsible for maintaining the confidentiality of your private user details. You are responsible for all activities that occur under your account or password. We reserve all rights to terminate accounts, edit or remove content and cancel orders in their sole discretion. Create your own professional terms and conditions tailored to your website or app.")
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
    
    func garbage() -> String {
        return String("Garbage")
    }
    
    func garbage_management() -> String {
        return String("Garbage Management")
    }
    
    func garbageManagement() -> String {
        return String("garbageManagement")
    }
    
    func event_management() -> String
    {
        return String("Event Management")
    }
    
    func eventManagement() -> String {
        return String("eventManagement")
    }
    
    func medical_emergency() -> String {
        return String("Emergency")
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
    
    func invite_Guests() -> String {
        return String("Invite Guests")
    }
    
    func my_visitors_list() -> String {
        return String("My Visitors List")
    }
    
    func my_daily_services() -> String {
        return String("My Daily Services")
    }
    
    func notify_digital_gate() -> String {
        return String("Notify Digi Gate")
    }
    
    func my_sweet_home() -> String {
        return String("My Sweet Home")
    }
    
    func emergency() -> String {
        return String("Emergency")
    }
    
    func visitorName() -> String {
        return String("Guest Name")
    }
    
    func visitorMobile() -> String {
        return String("Guest Mobile")
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
        return String("You have successfully invited your Guest")
    }
    
    func inviteButtonAlertViewTitle() -> String {
        return String("Invitation Message")
    }
    
    func inviteButtonloadViewTitle() -> String {
        return String("Inviting Your Guest")
    }
    
    func loadingProfile() -> String {
        return String("Loading Profile")
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
        return String ("Add Flat Member")
    }
    
    func addFamilyMemberTitle(name : String) -> String {
        return String ("Adding \(name) Details")
    }
    
    func addFamilyMember_AlertView_Title() -> String {
        return String ("Flat Member Message")
    }
    
    func addFamilyMember_AlertView_Message(name: String) -> String{
        return String("You have successfully added your \(name).")
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
    
    func medicalEmergency_Title() -> String {
        return String("Medical Emergency")
    }
    func raise_Fire_Alarm_Title() -> String {
        return String("Raise Fire Alarm")
    }
    func raise_Theft_Alarm_Title() -> String {
        return String("Raise Theft Alarm")
    }
    func raise_water_Alarm_Title() -> String {
        return String("Raise Water Alarm")
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
    
    func medical() -> String {
        return String("Medical")
    }
    func fire() -> String {
        return String("Fire")
    }
    func theft() -> String {
        return String("Theft")
    }
    func water() -> String {
        return String("Water")
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
    
    func dateInNumberFormat() -> String {
        return("dd-MM-yyyy")
    }
    
    func convertedDateInFormat() -> String {
        return("MM/dd/yyyy")
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
        return String("Sorry you cannot edit this flat member since you are not the admin of this flat")
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
        return String ("Please add your Flat Members to approve visitors on your behalf.")
    }
    
    func layoutFeatureErrorApartmentServices(serviceType: String) -> String {
        return String ("Sorry you cannot use this feature since currently there are no \(serviceType) service available at your Society.")
    }
    
    func layoutFeatureErrorGroceriesServices() -> String {
        return String("We are setting up soon in your Society. We will notify you when once we are there.")
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
    
    func Please_select_time() -> String {
        return String("Please select time")
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
    
    func doneButtonTagValue() -> Int {
        return Int (108)
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
    
    func societyServiceNotAvailable(serviceName: String) -> String {
        return String("Sorry you cannot use this feature since you haven't raised any \(serviceName) request at your flat yet")
    }
    
    func verifyingOTPDescription() -> String {
        return String ("Verifying Account")
    }
    
    func eventMessage() -> String {
        return String ("Event Message")
    }
    
    func searchingForBook() -> String {
        return String ("Searching for booked slots")
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
    
    func selectLanguage() -> String {
        return String ("Select Language")
    }
    
    func addVehicle() -> String {
        return String ("ADD VEHICLE")
    }
    
    func addMyVehicles() -> String {
        return String ("Add My Vehicles")
    }
    
    func societyService() -> String {
        return String ("Society Services")
    }
    
    func collectGarbage() -> String {
        return String ("Select Garbage")
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
    
    func garbage_Collector() -> String {
        return String("Garbage Collector")
    }
    
    func societyServiceMessage(name: String) -> String {
        return String ("\(name) has not Responded Yet")
    }
    
    func approver() -> String {
        return ("Approver:")
    }
    
    func in_Progress() -> String {
        return String("in progress")
    }
    
    // Apartment Services Cook
    func cookViewTitle() -> String {
        return ("Cook")
    }
    
    func accepted() -> String {
        return ("Accepted")
    }
    
    func rejected() -> String {
        return ("Rejected")
    }
    
    func notificationAcceptIdentifier() -> String {
        return ("acceptAction")
    }
    
    func notificationRejectIdentifier() -> String {
        return ("rejectAction")
    }
    
    func notificationActionCategory() -> String {
        return ("actionCategory")
    }
    
    //Add My Vehicles
    func car() -> String {
        return ("Car")
    }
    
    func bike() -> String {
        return ("Bike")
    }
    
    func please_Enter_Vehicle_Number() -> String {
        return ("Please Enter Vehicle Number")
    }
    
    func addVehicle_AlertMessage() -> String {
        return ("You have successfully added your Vehicle.")
    }
    
    func addVehicle_AlertTitle() -> String {
        return ("Vehicle Added Message")
    }
    
    func add_your_vehicle_message() -> String {
        return ("Please add your vehicles for Hassle Free entry into the society.")
    }
    
    // Event Management Activity
    func eventManagement_AlertTitle() -> String {
        return ("Event Message")
    }
    
    func eventManagement_AlertMessage() -> String {
        return ("You have successfully booked your Event.")
    }
    
    func event_title() -> String {
        return ("Event Title")
    }
    
    func choose_category() -> String {
        return ("Choose Category")
    }
    
    func choose_time_slot() -> String {
        return ("Choose Time Slot")
    }
    
    func event_date() -> String {
        return ("Event Date:")
    }
    
    func parties() -> String {
        return ("Parties")
    }
    
    func concerts() -> String {
        return ("Concerts")
    }
    
    func meetings() -> String {
        return ("Meetings")
    }
    
    func seminar_workshops() -> String {
        return ("Seminars/WorkShops")
    }
    
    func book() -> String {
        return ("BOOK")
    }
    
    func morning() -> String {
        return ("8AM - 12PM")
    }
    
    func noon() -> String {
        return ("12PM - 4PM")
    }
    
    func evening() -> String {
        return ("4PM - 8PM")
    }
    
    func night() -> String {
        return ("8PM - 12PM")
    }
    
    func query_time_slot() -> String {
        return ("For any queries related to time slot, Contact Admin.")
    }
    
    func referToSocietyServives() -> String {
        return ("Hey there! I got the reference of this Service from Namma Apartments app. You can also avail this Service by downloading..")
    }
    
    func sendMessageToSocietyServices() -> String {
        return("Hey there! I would like to have your Service at my Flat.Revert back so that we we can schedule and sort things out quickly.")
    }
    
    func sendMessageToSocietyServivesWhatsapp() -> String {
        return ("whatsapp://send?text=Hey%20there%20!%20I%20would%20like%20to%20have%20your%20Service%20at%20my%20Flat.%20Revert%20back%20so%20that%20we%20we%20can%20schedule%20and%20sort%20things%20out%20quickly.")
    }
    
    func your_Family_Member() -> String {
        return ("your Family Member")
    }
    
    func your_Friend() -> String {
        return ("your Friend")
    }
    
    func their() -> String {
        return "their"
    }
    
    func event_Validation_Message() -> String {
        return ("Please enter event title")
    }
    
    func event_Date() -> String {
        return ("Please select date")
    }
    
    func mobileNumberAlreadyExists() -> String {
        return ("Mobile Number already exists")
    }
    
    func resendOTP() -> String {
        return ("Resend OTP")
    }
    
    func changeMobileNumber() -> String {
        return ("Change Mobile Number")
    }
    
    func waitingForOTP() -> String {
        return ("Waiting for OTP...")
    }
    
    //Frequently Asked Questions
    func account_Delete_Query() -> String {
        return String("How do I delete My Account?")
    }
    
    func account_Deactivate_Query() -> String {
        return String("I am moving out of my current place. How can I Deactivate my Account?")
    }
    
    func visitors_Inviting_Query() -> String {
        return String("I faced an issue during inviting my Visitor. How can I raise a complaint?")
    }
    
    func visitors_UnexpectedNotifications() -> String {
        return String("I am getting a notification for a Visitor(e.g.Cab, Package, Guest) that i did not expect. What should I do?")
    }
    
    func visitors_Cancel_Query() -> String {
        return String("How can I cancel Invited Visitor?")
    }
    
    func visitors_Reschedule_Query() -> String {
        return String("How can I change Visitor Arrival Date/Time?")
    }
    
    func Valid_For_About() -> String {
        return String("What is 'Valid For' about?")
    }
    
    func dailyService_Adding_Query() -> String {
        return String("I faced an issue during adding my Daily Service. How can I raise a Complaint?")
    }
    
    func dailyService_Remove_Query() -> String {
        return String("How can I remove my Daily Services?")
    }
    
    func dailyService_Reschedule_Query() -> String {
        return String("How can I change Daily Service arrival time?")
    }
    
    func flatMembers_Delete_Query() -> String {
        return String("One of my Present Flat Member is moving out from my flat. How can I delete his/her Data?")
    }
    
    func flatMembers_Adding_Query() -> String {
        return String("Unfortunately, I added Friend as my Family Member. What should I Do?")
    }
    
    func flatMembers_AdminAccess_Query() -> String {
        return String("I want to give my Admin Access to one of my Flat Member. What should I do?")
    }
    
    func handedThings_Concept() -> String {
        return String("What is the concept of handed things to Daily Service/Guest?")
    }
    
    func handedThings_What_Things_can_be_Handed() -> String {
        return String("What things can be handed to DailyService/Guest?")
    }
    
    func handedThings_Guard_Notified_Query() -> String {
        return String("How guard will get notified when I handed things to Daily Service/Guest?")
    }
    
    func emergencyAlarm_raising_Query() -> String {
        return String("How can I raise an Emergency Alarm?")
    }
    
    func emergencyAlarm_Actions_Query() -> String {
        return String("What actions will take place once an Emergency Alarm is raised?")
    }
    
    func emergency_EstimatedTime_Query() -> String {
        return String("How much estimated time will it take for the Guard to take necessary action?")
    }
    
    func SocietyService_Approval_Query(Service: String) -> String {
        return String("I requested for a \(Service) service, but I din't get any approval yet. What should I do?")
    }
    
    func SocietyService_EstimatedTime_Query(Service: String) -> String {
        return String("What should I do if the \(Service) doesn't arrive within the expected time slot?")
    }
    
    func event_Reschedule_Query() -> String {
        return String("I want to reschedule my Event. What should I do?")
    }
    
    func notification_InternetConnection_Issue() -> String {
        return String("Why is the app showing no internet connection?")
    }
    
    func notification_Query() -> String {
        return String("I am not getting any notifications?")
    }
    
    func notification_InternetFine_But_NotificationIssue() -> String {
        return String("My internet connectivity is fine, still I am not receiving any notifications, what could be the issue?")
    }
    
    func notification_Setting_ON_But_Issue() -> String {
        return String("My notification settings are ‘ON’, I’m still not getting any notifications?")
    }
    
    func receiveNotifications_With_delay() -> String {
        return String("I did receive notifications but they are delayed. What is the reason for delay?")
    }
    
    func general_Updates() -> String {
        return String("How frequently I would get updates?")
    }
    
    func general_edit_userName() -> String {
        return String("How do I change my Username?")
    }
    
    func general_edit_emailAddress() -> String {
        return String("How do I change my EmailAddress?")
    }
    
    func general_edit_mobileNuber() -> String {
        return String("How do I change my registered Mobile Number?")
    }
    
    func general_Languages_Query() -> String {
        return String("Does 'Namma Apartments' Support Different Languages?")
    }
    
    func general() -> String {
        return String("General")
    }
    
    func account() -> String {
        return String("Account")
    }
    
    func Visitors() -> String {
        return String("Visitors")
    }
    
    func daily_Services() -> String {
        return String("Daily Services")
    }
    
    func flatMembers() -> String {
        return String("Flat Members")
    }
    
    func notification() -> String {
        return String("Notifications")
    }
    
    func eventManagementBottomDescription() -> String {
        return ("You will be notified once the 'Status' of your request changes.")
    }
    
    func eventManagementTopDescription() -> String {
        return ("Your request for the below Event has been initiated.")
    }
    
    func title() -> String {
        return ("Title:")
    }
    
    func timeSlot() -> String {
        return ("Time Slot:")
    }
    
    func your_Guest() -> String {
        return String("Your Guest ")
    }
    func your_Cab_Numbered() -> String {
        return String("Your Cab Numbered ")
    }
    func your_package_vendor() -> String {
        return String("Your Package vendor ")
    }
    
    func wants_to_enter_Society() -> String {
        return String(" wants to enter your society. Please confirm.")
    }
    
    func _message_() -> String {
        return String("message")
    }
    
    func _profile_photo() -> String {
        return String("profile_photo")
    }
    
    func current_Date_Format() -> String {
        return String("MMM dd, y\t\t HH:MM")
    }
    
    func flat_AlertTitle() -> String {
        return ("Registration unsuccessful")
    }
    
    func flat_AlertMessage(admin: String) -> String {
        return ("Sorry, we already have an Admin from your Flat. Please ask \(admin) to add you as a Family Member or Friend.")
    }
    
    func plumber_Service() -> String {
        return String("plumber")
    }
    
    func carpenter_Service() -> String {
        return String("carpenter")
    }
    
    func electrician_Service() -> String {
        return String("electrician")
    }
    
    //Maintenance Services Screen
    func SocietyServices() -> String {
        return String("Society Services")
    }
    
    func payNow() -> String {
        return String("PAY NOW")
    }
    
    func complete() -> String {
        return String("Completed")
    }
    
    func noticeBoardErrorLayoutMessage() -> String {
        return String("Currently there is no notice for your Society.")
    }
    
    func accountCreated() -> String {
        return String("Account Created")
    }
    
    func welcomeScreenDescription() -> String {
        return String("Thank you for Registering with Namma Apartments. Your flat details has been sent to Society Admin. We will notify you once your account gets Activated.")
    }
    
    func userDefault_USERUID() -> String {
        return String("USERUID")
    }
    
    func userDefault_Not_First_Time() -> String {
        return String("Not_First_Time")
    }
    
    func userDefault_Logged_In() -> String {
        return String("Logged_In")
    }
    
    func userDefault_Account_Created() -> String {
        return String("Account_Created")
    }
    
    func userDefault_Verified() -> String {
        return String("Verified")
    }
    
    //My Wallet
    func nammaApartments_E_Payment() -> String {
        return String("Namma Apartments E-Payment")
    }
    
    func wallet_Description() -> String {
        return String("Hola! Now we provide you an option to make online payments for your Society and Apartment Services.")
    }
    
    func make_payment_For() -> String {
        return String("Make Payment For")
    }
    
    func societyServices() -> String {
        return String("Society Services")
    }
    
    func ApartmentServices() -> String {
        return String("Apartment Services")
    }
    
    func myTransactions() -> String {
        return String("My Transaction")
    }
    
    func myWallet() -> String {
        return String("My Wallet")
    }
    
    func payments() -> String {
        return String("Payments")
    }

    func location_Permission() -> String {
        return String("Turn On Location Services to Allow 'Namma Apartments' to Determine Your Location")
    }
    
    func available() -> String {
        return String("Available")
    }
    
    func unavailable() -> String {
        return String("Unavailable")
    }
    
    func others() -> String {
        return String("Others")
    }
}

