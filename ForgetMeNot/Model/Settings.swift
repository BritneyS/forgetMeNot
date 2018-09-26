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
    
    var forgetMeColor = UIColor(red: 120/255.0, green: 148/255.0, blue: 255/255.0, alpha: 1.0)
    
    class var sharedService : Settings {
        struct Background {
            static let instance = Settings()
        }
        return Background.instance
    }
    
    init() { }
    
    func backgroundColorChanged(color : UIColor) {
        Settings.sharedService.backgroundColor = forgetMeColor
    }
    
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
