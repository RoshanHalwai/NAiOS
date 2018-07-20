//
//  NADailyServices.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 20/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit
//Created enum instead of struct for App optimization and for getting values.
enum NADailyServicesListFBKeys: String {
    case fullName
    case phoneNumber
    case profilePhoto
    case numberOfFlats
    case rating
    case timeOfVisit
    case uid
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .fullName: return "fullName"
        case .phoneNumber: return "phoneNumber"
        case .profilePhoto: return "profilePhoto"
        case .numberOfFlats: return "numberOfFlats"
        case .rating: return "rating"
        case .timeOfVisit:return "timeOfVisit"
        case .uid: return "uid"
        }
    }
}
