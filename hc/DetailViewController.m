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
@synthesize lblActualHtml;
@synthesize btnGetLatest;
@synthesize btnRetest;
@synthesize detailItem;
__strong UIActivityIndicatorView *_activityIndicatorView;
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

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"Button-(Back)withText.png"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 54, 30);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStyleDone target:self action:@selector(goback)] ;
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.hidesBackButton = YES;
    UIColor* activeLabelColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    [self configureView];

}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
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
        
        self.txtUrlData.text = [self.detailItem urlData];
        self.txtGrep.text = [self.detailItem grep];
        self.txtActualHtml.text = [self.detailItem actualHtml];
    }
}

-(void)resizeLabel:(UILabel*)label{
    CGSize constraint = CGSizeMake(300, 2000.0f);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    [label setFrame:CGRectMake(10, 0, size.width, size.height)];
}

- (IBAction)btnGetLatestClicked:(UIBarButtonItem *)sender {
    [self testServer: @"1"];
}

- (IBAction)btnRetestClicked:(UIBarButtonItem *)sender {
    [self testServer: @"2"];
}

- (void)testServer:(NSString*)resultsFrom {
    [_activityIndicatorView startAnimating];
    
    
    [Post testServer:self.detailItem.Id :resultsFrom done: ^(NSObject *post, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            self.detailItem = post;
            [self configureView];
        }
        
        [_activityIndicatorView stopAnimating];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}
@end
