//
//  MealDatabase.m
//  meal-tracking
//
//  Created by Hy-tsoung Chang on 13/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import "MealDatabase.h"

@interface MealDatabase ()

@property (nonatomic, strong) NSArray* mealArray;

@end

@implementation MealDatabase

/*
 // using GCD
 + (id)sharedDatabase {
 static UserMealRecordDatabase *sharedDatabase = nil;
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 sharedDatabase = [[self alloc] init];
 });
 return sharedDatabase;
 }
 */

+ (id)sharedDatabase {
    static MealDatabase *sharedDatabase = nil;
    @synchronized(self) {
        if (sharedDatabase == nil)
            sharedDatabase = [[self alloc] init];
    }
    return sharedDatabase;
}

- (id)init {
    if (self = [super init]) {
        _mealArray = @[@"Vegetables",
                      @"Bread",
                      @"Pasta",
                      @"French Fries",
                      @"Rice"];
    }
    return self;
}


-(NSArray*)mealArray {
    return _mealArray;
}

@end
