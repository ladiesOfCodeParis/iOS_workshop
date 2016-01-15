//
//  TableViewController.m
//  meal-tracking
//
//  Created by Hy-tsoung Chang on 12/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import "MealInventoryTableViewController.h"
#import "MealDataBase.h"

static NSString* mealCellID = @"mealCell";

@interface MealInventoryTableViewController ()

@property NSArray* mealArray;

@end

@implementation MealInventoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setup
    self.title = @"Meals ?";
    
    // data
    self.mealArray = [[MealDatabase sharedDatabase] mealArray];
    
    // tableview setup
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:mealCellID];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mealArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mealCellID forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mealCellID];
    }
    
    // Configure the cell
    cell.textLabel.text = [self.mealArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)sendData {
    NSString* selectedData = nil;
    NSIndexPath* selectedPath = [self.tableView indexPathForSelectedRow];
    if (selectedPath && selectedPath.row < self.mealArray.count) {
        selectedData = [self.mealArray objectAtIndex:selectedPath.row];
    }
    if (selectedData) {
        [self.delegate userDidSelectMeal:selectedData from:self];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self sendData];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
