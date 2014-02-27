//
//  HealthCheckMasterViewController.h
//  hc
//
//  Created by bai on 13-5-29.
//  Copyright (c) 2013年 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthCheckMasterViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnFilter;

- (IBAction)btnFilterClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentStatus;
- (IBAction)segmentStatusChanged:(UISegmentedControl*)sender;
- (IBAction)btnGetLatestClicked:(id)sender;

@end
