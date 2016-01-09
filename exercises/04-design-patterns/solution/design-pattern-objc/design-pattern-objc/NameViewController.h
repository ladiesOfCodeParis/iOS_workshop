//
//  NameViewController.h
//  design-pattern-objc
//
//  Created by Hy-tsoung Chang on 09/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

// Delegate of NameViewController, so we can pass info and event
@protocol NameViewControllerDelegate <NSObject>

-(void)okPressed:(id)sender withFirstName:(NSString*)firstName lastName:(NSString*)lastName;
-(void)cancelPressed:(id)sender;

@end

// NameViewController class
@interface NameViewController : UIViewController

// member 'delegate' that implements the NameViewController protocol
@property id<NameViewControllerDelegate> delegate;

@end
