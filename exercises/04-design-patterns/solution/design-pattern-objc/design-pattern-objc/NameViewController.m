//
//  NameViewController.m
//  design-pattern-objc
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didPressCancel:(id)sender {
    
    // call the delegate, he should know what to do
    [self.delegate cancelPressed:self];
}

- (IBAction)didPressOK:(id)sender {
    
    // call the delegate, he should know what to do with this data.
    [self.delegate okPressed:self withFirstName:self.firstNameText.text lastName:self.lastNameText.text];
}

@end
