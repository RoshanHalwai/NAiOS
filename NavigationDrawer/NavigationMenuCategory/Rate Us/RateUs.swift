//
//  RateUs.swift
//  nammaApartment
//
//  Created by Sundir Talari on 16/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit
import StoreKit

class RateUs {
    
    /**  UserDefauls dictionary key where we store number of launching the app. **/
    let launchCountUserDefaultsKey = "noOfLaunches"
    
    func isReviewViewToBeDisplayed(minimumLaunchCount:Int) -> Bool {
        
        let launchCount = UserDefaults.standard.integer(forKey: launchCountUserDefaultsKey)
        if launchCount >= minimumLaunchCount {
            return true
        } else {
            /** Increase launch count by '1' after every launch.**/
            UserDefaults.standard.set((launchCount + 1), forKey: launchCountUserDefaultsKey)
        }
        print(launchCount)
        
        return false
    }
    
    /** This method is called from any class with minimum launch count needed. **/
    func showReviewView(afterMinimumLaunchCount:Int){
        if(self.isReviewViewToBeDisplayed(minimumLaunchCount: afterMinimumLaunchCount)){
            SKStoreReviewController.requestReview()
        }
    }
}


