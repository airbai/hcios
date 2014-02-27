//
//  HealthCheckDetailViewController.h
//  hc
//
//  Created by bai on 13-5-29.
//  Copyright (c) 2013年 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@interface HealthCheckDetailViewController : UITableViewController

@property (strong, nonatomic) Post *detailItem;

//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
