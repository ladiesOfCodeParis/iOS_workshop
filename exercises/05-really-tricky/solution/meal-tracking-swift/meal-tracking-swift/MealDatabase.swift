//
//  MealDatabase.swift
//  meal-tracking-swift
//
//  Created by Hy-tsoung Chang on 15/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

import UIKit

class MealDatabase: NSObject {
    
    var mealArray : [String]!
    
    class var sharedInstance : MealDatabase {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : MealDatabase? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = MealDatabase()
        }
        return Static.instance!
    }
    
    override init()  {
        super.init()
        self.mealArray = ["Bread", "Rice", "Pasta", "Vegetables", "French Fries"]
    }
    
    func getMeals() -> [String] {
        return self.mealArray
    }
}
