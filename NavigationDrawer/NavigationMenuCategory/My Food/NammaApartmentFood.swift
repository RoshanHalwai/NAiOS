//
//  NammaApartmentFood.swift
//  nammaApartment
//
//  Created by kalpana on 9/17/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum DonateFoodListFBKeys: String {
    case foodQuantity
    case foodType
    case status
    case timeStamp
    case uid
    case userUID
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .foodQuantity: return "foodQuantity"
        case .foodType: return "foodType"
        case .status: return "status"
        case .timeStamp:return "timeStamp"
        case .uid: return "uid"
        case .userUID:return "userUID"
        }
    }
}

class NAUserFoodDonations {
    
    /* ------------------------------------------------------------- *
     * Class Members Declaration
     * ------------------------------------------------------------- */
    
    private var foodQuantity: String
    private var foodType: String
    private var timeStamp = Int()
    
    /* ------------------------------------------------------------- *
     * Constructor
     * ------------------------------------------------------------- */
    
    init(foodQuantity: String, foodType: String, timeStamp: Int) {
        self.foodQuantity = foodQuantity
        self.foodType = foodType
        self.timeStamp = timeStamp
    }
    
    func getFoodQuantity() -> String {
        return foodQuantity
    }
    
    func getFoodType() -> String {
        return foodType
    }
    
    func getTimeStamp() -> Int {
        return timeStamp
    }
    
}


