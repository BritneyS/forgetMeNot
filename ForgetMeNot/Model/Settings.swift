//
//  Settings.swift
//  ForgetMeNot
//
//  Created by Elle Gover on 9/26/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//

import Foundation
import UIKit

class Settings {
    
    /// modular class
    /// creates a Settings class / instance that allows backgroundColor to be called and changed in all views
    class var sharedService : Settings {
        struct Background {
            static let instance = Settings()
        }
        return Background.instance
    }
    
    init() { }
    
    var backgroundColor : UIColor {
        get { /// stores values and init a default value
            let data: NSData? = UserDefaults.standard.object(forKey: "backgroundColor") as? NSData
            var returnValue: UIColor?
            if data != nil {
                returnValue = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? UIColor
            } else {
                returnValue = UIColor(white: 1, alpha: 1);
            }
            return returnValue!
        }
        set (newValue) {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            UserDefaults.standard.set(data, forKey: "backgroundColor")
            UserDefaults.standard.synchronize()
        }
    }
}
