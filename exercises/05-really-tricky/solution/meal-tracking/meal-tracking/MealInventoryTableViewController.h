//
//  TableViewController.h
//  meal-tracking
//
//  Created by Hy-tsoung Chang on 12/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MealInventoryDelegate <NSObject>

- (void)userDidSelectMeal:(NSString*)meal from:(id)sender;

@end

@interface MealInventoryTableViewController : UITableViewController

@property id<MealInventoryDelegate> delegate;

@end
