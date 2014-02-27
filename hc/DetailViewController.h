//
//  DetailViewController.h
//  hc
//
//  Created by bai on 13-7-11.
//  Copyright (c) 2013年 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface DetailViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *lblId;

@property (weak, nonatomic) IBOutlet UILabel *lblPing;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblIP;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblHost;
@property (weak, nonatomic) IBOutlet UILabel *lblGroup;
@property (weak, nonatomic) IBOutlet UILabel *lblExeTime;
@property (weak, nonatomic) IBOutlet UILabel *lblLastTested;
@property (weak, nonatomic) IBOutlet UILabel *lblUrlData;
@property (weak, nonatomic) IBOutlet UILabel *lblGrep;

@property (strong, nonatomic) Post *detailItem;

@end
