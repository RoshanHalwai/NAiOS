//
//  NAString.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 04/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class NAString : NSObject
{
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
    
    func enter_verification_code() -> String {
        return String("We need to verify your account. Please enter the 6 digit verification code from the text message.")
    }
    func verify_otp_button() -> String {
        return String("VERIFY OTP")
    }
    
    func incorrect_otp() -> String {
        return String("You have entered an incorrect OTP")
    }
    
    //Flat Details Screen
    
    func My_flat_Details_title() -> String {
        return String("My Flat Details")
    }
    
    func city() -> String {
        return String("CITY")
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
        return String("CONTINUE")
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
        return String("By clicking on SignUp I agree to Terms And Conditions")
    }
    func i_already_have_an_account() -> String {
        return String("I already have an Account")
    }
    
    //Signin screen
    
    func create_an_account_button() -> String {
        return String("Create an Account")
    }
    
    func login_button() -> String {
        return String("LOGIN")
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
        return String("Digital Gate")
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
        return String("Invite Visitor")
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
    
    func inviteVisitorOTPDesc() -> String {
        return String("We will send an OTP to your visitor allowing them to enter into your society.")
    }
    func btnInvite() -> String {
        return String("INVITE")
    }
    
    //MyVisitorList
    func myVisitorViewTitle() -> String {
        return String("My Visitor List")
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
    
    func package_number() -> String {
        return String("Package Number")
    }
    
    func notify_gate() -> String {
        return String("NOTIFY GATE")
    }
    
    func cab_number() -> String {
        return String("Cab Number")
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
        return String("Description")
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
    
    //adding my daily services
    
    func add_my_service() -> String {
        return String("Add My Service")
    }
    func name() -> String {
        return String("Name")
    }
    func mobile() -> String {
        return String("Mobile")
    }
    func pick_time() -> String {
        return String("Time")
    }
    func add() -> String {
        return String("Add")
    }
        
    func dailyServicesOTPDescription() -> String {
        return String("We need to verify your account. Please enter the 6 digit verification code from the text message")
    }
    
    //visitor list
    func visitor() -> String {
        return String("Visitor")
    }
    func type() -> String {
        return String("Type:")
    }
    func date() -> String {
        return String("Date:")
    }
    func time() -> String {
        return String("Time:")
    }
    func invited_by() -> String {
        return String("Invited By:")
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
    
}

