//
//  HealthCheckSettingViewController.h
//  hc
//
//  Created by bai on 13-5-30.
//  Copyright (c) 2013年 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthCheckSettingViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnGenerateToken;
- (IBAction)onClickedGenerate:(id)sender;

@end
