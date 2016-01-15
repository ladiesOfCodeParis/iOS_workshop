//
//  DayRecordViewController.m
//  meal-tracking
//
//  Created by Hy-tsoung Chang on 12/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import "DayRecordViewController.h"
#import "MealInventoryTableViewController.h"
#import "UserMealRecordDatabase.h"

@interface DayRecordViewController () <UITableViewDelegate, UITableViewDataSource, MealInventoryDelegate>

@property NSMutableArray* dayRecordArray;

@end

static NSString* dayRecordCellIdentifier = @"dayRecord";

@implementation DayRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // load user meal data
    [self loadUserMealData];

    // setup tableview
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:dayRecordCellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.allowsSelectionDuringEditing = YES;
    
    // setup edit button
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - getters/setters
- (void)setDay:(NSString *)day {
    _day = day;
    self.title = day;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dayRecordArray.count + (self.tableView.isEditing?1:0);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:dayRecordCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dayRecordCellIdentifier];
    }
    
    if (indexPath.row < self.dayRecordArray.count) {
        cell.textLabel.text = [self.dayRecordArray objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = @"[add]";
    }
    return cell;
}

// remove/insert an 'add' row if going from/to the edit mode
-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if(editing) {
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.dayRecordArray.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
    } else {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.dayRecordArray.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        
    }
}

// setup edit style on the rows, in on edit mode
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dayRecordArray.count) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

#pragma mark - UITableViewDelegate
// wire actions if user taps on a edit part of a row in edit mode
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.dayRecordArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance, insert it into the array, and add a new row to the table view
        [self.dayRecordArray insertObject:@"[new]" atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.isEditing && indexPath.row != self.dayRecordArray.count) {
        MealInventoryTableViewController* inventory = [[MealInventoryTableViewController alloc] init];
        inventory.delegate = self;
        inventory.view.frame = self.navigationController.view.frame;
        [self.navigationController pushViewController:inventory animated:YES];
    } else if (self.tableView.isEditing && indexPath.row == self.dayRecordArray.count) {
        [self.dayRecordArray insertObject:@"new" atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

#pragma mark - MealInventoryDelegate
- (void)userDidSelect:(NSString *)meal from:(id)sender {
    NSIndexPath* selectedRecord = self.tableView.indexPathForSelectedRow;
    if (self.tableView.isEditing && selectedRecord && selectedRecord.row < self.dayRecordArray.count && meal) {
        [self.dayRecordArray setObject:meal atIndexedSubscript:selectedRecord.row];
        [self.tableView reloadRowsAtIndexPaths:@[selectedRecord] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - save on back
- (void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        [self saveUserData];
    }
    [super viewWillDisappear:animated];
}

#pragma mark - load/save user data
- (void)loadUserMealData {
    self.dayRecordArray = [UserMealRecordDatabase loadUserMealDataForDay:self.day];
}


- (void)saveUserData {
    if (self.dayRecordArray.count > 0) {
        [UserMealRecordDatabase saveUserData:self.dayRecordArray forDay:self.day];
    }
}

@end
