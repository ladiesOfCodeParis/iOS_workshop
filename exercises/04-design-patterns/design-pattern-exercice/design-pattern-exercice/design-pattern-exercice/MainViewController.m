//
//  ViewController.m
//  design-pattern-exercice
//
//  Created by Hy-tsoung Chang on 09/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import "MainViewController.h"
#import "NameViewController.h"

@interface MainViewController () /* (protocol conformation here) */

@property IBOutlet UILabel* firstNameLabel;
@property IBOutlet UILabel* lastNameLabel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPressed:(id)sender {
    
    // instanciate the NameViewController
    // displays nameVC in a modal way

    // set himself (self) as nameVC's delegate
}

#pragma mark - NameViewControllerDelegate
// implement delegate function ok, with firstName and lastName info
    // retrieve and use data
    // dismiss the current modal view.

// implement delegate function cancel
    // dismiss the current modal view.

@end
