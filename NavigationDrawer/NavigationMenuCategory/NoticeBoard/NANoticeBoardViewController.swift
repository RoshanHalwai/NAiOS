//
//  NANoticeBoardViewController.swift
//  nammaApartment
//
//  Created by kalpana on 8/24/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

//Created enum instead of struct for App optimization and for getting values.
enum NoticeBoardListFBKeys: String {
    case title
    case description
    case nameOfAdmin
    case dateAndTime

    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .title: return "title"
        case .description: return "description"
        case .nameOfAdmin: return "nameOfAdmin"
        case .dateAndTime: return "dateAndTime"
        }
    }
}

class NAExpectingNoticeBoard {
    
    var title : String?
    var description : String?
    var nameOfAdmin : String?
    var dateAndTime : String?
    
    init(title : String?,description : String?,nameOfAdmin : String?,dateAndTime : String) {
        self.title = title
        self.description = description
        self.nameOfAdmin = nameOfAdmin
        self.dateAndTime = dateAndTime
    }
    
    func gettitle() -> String {
        return title!
    }
    
    func getdescription() -> String? {
        return description!
    }
    
    func getnameOfAdmin() -> String {
        return nameOfAdmin!
    }
    
    func getdateAndTime() -> String {
        return dateAndTime!
    }
}
