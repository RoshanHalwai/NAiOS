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
    
    var key : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .title: return "title"
        case .description: return "description"
        }
    }
}

class NAExpectingNoticeBoard {
    
    var title : String?
    var description : String?
    
    init(title : String?,description : String?) {
        self.title = title
        self.description = description
    }
    
    func gettitle() -> String {
        return title!
    }
    
    func getdescription() -> String? {
        return description!
    }
}
