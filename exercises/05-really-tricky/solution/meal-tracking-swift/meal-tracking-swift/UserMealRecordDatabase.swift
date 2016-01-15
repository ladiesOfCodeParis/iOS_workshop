//
//  UserMealRecordDatabase.swift
//  meal-tracking-swift
//
//  Created by Hy-tsoung Chang on 15/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

import UIKit

class UserMealRecordDatabase: NSObject {
    
    static func loadUserMealDataForDay(dayString:String?) -> [String] {
        
        if let aDay = dayString {
            if let allData = NSUserDefaults.standardUserDefaults().objectForKey("userdata") {
                if let dayData = allData.objectForKey(aDay) {
                    return dayData as! [String]
                }
            }
        }
        
        return []
    }
    
    static func saveUserData(dayRecordData:[String], forDay dayString:String?) {
        
        if (dayRecordData.count > 0 && dayString != nil) {
            var allDataToSave:Dictionary<String,[String]>!
            if let allData = NSUserDefaults.standardUserDefaults().objectForKey("userdata") {
                allDataToSave = allData.copy() as! Dictionary<String, [String]>
            } else {
                allDataToSave = Dictionary<String,[String]>()
            }
            allDataToSave[dayString!] = dayRecordData
            NSUserDefaults.standardUserDefaults().setObject(allDataToSave, forKey: "userdata")
        }
    }

}
