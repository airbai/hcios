//
//  HealthCheckFilterViewController.m
//  hc
//
//  Created by bai on 13-6-21.
//  Copyright (c) 2013年 Websense. All rights reserved.
//

#import "HealthCheckFilterViewController.h"
#import "Post.h"
#import "PostTableViewCell.h"

@interface HealthCheckFilterViewController ()

@end

@implementation HealthCheckFilterViewController{
    @private
    NSMutableArray* _posts;
}
@synthesize nav;
@synthesize btnDone;
@synthesize delegate;
@synthesize selectedRow;
@synthesize selectedIndexPath;
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

    if (self.delegate && [self.delegate respondsToSelector:@selector(prepareFilterData:)]) {
        NSArray* posts = [self.delegate prepareFilterData:self];
        Post *post = [[Post alloc] init];
        post.serviceGroup = @"All";
        _posts = [[NSMutableArray alloc]init];
        [_posts addObject: post];
        
        for (int i=0;i<[posts count];i++)
        {
            Post* item=[posts objectAtIndex:i];
            [_posts addObject:item];
        }
    }
    
    selectedRow = -1;
    
    UIImage* settingImage = [UIImage imageNamed:@"RoundedButtonDone.png"];;
    CGRect frameSettingImg = CGRectMake(0, 0, settingImage.size.width, settingImage.size.height);
    UIButton * settingButton = [[UIButton alloc] initWithFrame:frameSettingImg];
    [settingButton setBackgroundImage:settingImage forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(btnDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(btnDoneClicked:)] ;
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(btnCancelClicked:)] ;
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.hidesBackButton = YES;
    
    [self.navigationController.navigationBar.topItem setRightBarButtonItem: doneButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int row = [indexPath row];
    
    if(row == selectedRow)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    Post* post = [_posts objectAtIndex:indexPath.row];
    cell.textLabel.text = post.serviceGroup;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = [indexPath row];
    selectedIndexPath = indexPath;
    [tableView reloadData];
}

- (void)btnDoneClicked:(id)sender {
    if (self.delegate ) {
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
        NSMutableArray* selectedGroups = [[NSMutableArray alloc]init];
        if(cell != nil)
        {
            NSString* group = cell.textLabel.text;
            [selectedGroups addObject:cell.textLabel.text];
        }
        [self.delegate cancelButtonClicked :nil selectedGroups:selectedGroups];
    }
}

- (void)btnCancelClicked:(id)sender {
    if (self.delegate ) {
        [self.delegate dismissPopupView];
    }
}
@end
