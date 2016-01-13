//
//  UserMealRecordDatabase.h
//  meal-tracking
//
//  Created by Hy-tsoung Chang on 13/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMealRecordDatabase : NSObject

+ (NSMutableArray*)loadUserMealDataForDay:(NSString*)dayString;
+ (void)saveUserData:(NSArray*)dayRecordData forDay:(NSString*)dayString;

@end
