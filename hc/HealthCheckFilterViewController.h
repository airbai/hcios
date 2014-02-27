//
//  HealthCheckFilterViewController.h
//  hc
//
//  Created by bai on 13-6-21.
//  Copyright (c) 2013年 Websense. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJSecondPopupDelegate;

@interface HealthCheckFilterViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDone;
@property int selectedRow;
@property NSIndexPath* selectedIndexPath;
@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;
- (void)btnDoneClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *nav;

@end

@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(HealthCheckFilterViewController*)healthCheckFilterViewController selectedGroups:(NSArray*)selectedGroups;
- (NSArray*)prepareFilterData:(HealthCheckFilterViewController*)healthCheckFilterViewController;
-(void)dismissPopupView;
@end