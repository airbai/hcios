//
//  DetailViewController.m
//  hc
//
//  Created by bai on 13-7-11.
//  Copyright (c) 2013年 Websense. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize lblId;
@synthesize lblPing;
@synthesize lblStatus;
@synthesize lblIP;
@synthesize lblExeTime;
@synthesize lblGroup;
@synthesize lblHost;
@synthesize lblLastTested;
@synthesize lblName;
@synthesize lblUrlData;
@synthesize lblGrep;
@synthesize detailItem;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self configureView];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDetailItem:(id)newDetailItem
{
    if (detailItem != newDetailItem) {
        detailItem = newDetailItem;
        
        // Update the view.
        //[self configureView];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        self.lblId.text = [self.detailItem Id];
        self.lblPing.text = [self.detailItem ping];
        self.lblStatus.text = [self.detailItem status];
        self.lblIP.text = [self.detailItem ip];
        self.lblExeTime.text = [self.detailItem executionTime];
        self.lblGroup.text = [self.detailItem serviceGroup];
        self.lblHost.text = [self.detailItem host];
        self.lblLastTested.text = [self.detailItem lastTested];
        self.lblName.text = [self.detailItem name];
        
        self.lblUrlData.text = [self.detailItem urlData];
        self.lblGrep.text = [self.detailItem grep];
    }
}
@end
