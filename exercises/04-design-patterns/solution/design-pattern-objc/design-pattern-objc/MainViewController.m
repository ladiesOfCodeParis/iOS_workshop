//
//  ViewController.m
//  design-pattern-objc
//
//  Created by Hy-tsoung Chang on 09/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import "MainViewController.h"
#import "NameViewController.h"

@interface MainViewController () <NameViewControllerDelegate>

@property IBOutlet UILabel* firstNameLabel;
@property IBOutlet UILabel* lastNameLabel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    // instanciate the NameViewController
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NameViewController *nameVC = (NameViewController*)[sb instantiateViewControllerWithIdentifier:@"nameVC"];
    nameVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    nameVC.modalPresentationStyle = UIModalPresentationFormSheet;
    
    // set himself (self) as nameVC's delegate
    nameVC.delegate = self;
    
    // displays nameVC in a modal way
    [self presentViewController:nameVC animated:YES completion:nil];
}

#pragma mark - NameViewControllerDelegate
// implement delegate function ok, with firstName and lastName info
- (void)okPressed:(id)sender withFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    
    // retrieve and use data
    self.firstNameLabel.text = firstName;
    self.lastNameLabel.text = lastName;
    
    // dismiss the current modal view.
    [self dismissViewControllerAnimated:YES completion:nil];
}

// implement delegate function cancel
- (void)cancelPressed:(id)sender {
    // dismiss the current modal view.
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
