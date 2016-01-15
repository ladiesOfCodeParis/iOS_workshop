//
//  UserMealRecordDatabase.m
//  meal-tracking
//
//  Created by Hy-tsoung Chang on 13/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import "UserMealRecordDatabase.h"

@implementation UserMealRecordDatabase

+ (NSMutableArray*)loadUserMealDataForDay:(NSString*)dayString {
    
    NSMutableArray* dayRecordData = nil;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"]) {
        NSDictionary* allData = (NSDictionary *)[[NSUserDefaults standardUserDefaults]
                                                 objectForKey:@"userdata"] ;
        NSArray* dayData = [allData objectForKey:dayString];
        dayRecordData = [NSMutableArray arrayWithArray:dayData];
        
    } else {
        dayRecordData = [NSMutableArray array];
    }
    
    return dayRecordData;
}

+ (void)saveUserData:(NSArray*)dayRecordData forDay:(NSString*)dayString {
    
    if (dayRecordData.count > 0) {
        
        NSMutableDictionary* allData =
        [NSMutableDictionary dictionaryWithDictionary:
         (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"userdata"]];
        
        if (!allData) {
            allData = [NSMutableDictionary dictionary];
        }
        [allData setObject:[NSArray arrayWithArray:dayRecordData] forKey:dayString];
        
        [[NSUserDefaults standardUserDefaults] setObject:allData forKey:@"userdata"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



@end
