//
//  ViewController.m
//  meal-tracking
//
//  Created by Hy-tsoung Chang on 12/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

#import "DiaryViewController.h"
#import "DayRecordViewController.h"

static NSInteger kPreTodayDayCount = 2;
static NSInteger kMaxDayCount = 100;
static NSString* kDayCellID = @"DayCell";

@interface DiaryViewController () <UITableViewDelegate, UITableViewDataSource>

@property IBOutlet UITableView* tableView;
@property NSDate* today;

@end

@implementation DiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // title
    self.title = @"Diary";
    
    // setup tableview
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDayCellID];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // today
    self.today = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kMaxDayCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kDayCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kDayCellID];
    }
    
    //config cell
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [NSDate dateWithTimeInterval:(60 * 60 * 24)*(indexPath.row - kPreTodayDayCount) sinceDate:self.today];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [formatter stringFromDate:[NSDate dateWithTimeInterval:(60 * 60 * 24)*(indexPath.row - kPreTodayDayCount) sinceDate:self.today]];

    DayRecordViewController* dayRecord = (DayRecordViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"dayRecordID"];
    dayRecord.day = dateString;
    [self.navigationController pushViewController:dayRecord animated:YES];
}


@end
