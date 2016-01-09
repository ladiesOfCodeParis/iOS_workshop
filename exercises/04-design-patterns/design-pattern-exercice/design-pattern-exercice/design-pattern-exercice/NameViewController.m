//
//  NameViewController.m
//  design-pattern-exercice
//
//  Created by Hy-tsoung Chang on 09/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController ()

@property IBOutlet UITextField* firstNameText;
@property IBOutlet UITextField* lastNameText;

@property IBOutlet UIButton* okButton;
@property IBOutlet UIButton* cancelButton;

@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didPressCancel:(id)sender {
    // call the delegate, he should know what to do
}

- (IBAction)didPressOK:(id)sender {
    // call the delegate, he should know what to do with this data.
}

@end
