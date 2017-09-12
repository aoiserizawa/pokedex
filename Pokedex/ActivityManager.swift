//
//  ActivityManager.swift
//  Pokedex
//
//  Created by Alvin Joseph Valdez on 11/09/2017.
//  Copyright © 2017 Alvin Joseph Valdez. All rights reserved.
//

import UIKit

struct ActivityManager {
    
    static var numberOfActivity = 0
    
    static func addActivity() {
        if self.numberOfActivity > -1 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.numberOfActivity += 1
        }
    }
    
    static func removeActivity() {
        if self.numberOfActivity > -1 {
            if self.numberOfActivity > 0 {
                self.numberOfActivity -= 1
            }
            if self.numberOfActivity == 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
