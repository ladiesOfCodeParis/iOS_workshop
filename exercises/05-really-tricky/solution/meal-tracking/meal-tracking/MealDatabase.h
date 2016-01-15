//
//  MealDatabase.h
//  meal-tracking
//
//  Created by Hy-tsoung Chang on 13/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MealDatabase : NSObject

+ (id)sharedDatabase;
- (NSArray*)mealArray;

@end
