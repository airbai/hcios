//
//  HealthCheckMasterViewController.m
//  hc
//
//  Created by bai on 13-5-29.
//  Copyright (c) 2013年 Websense. All rights reserved.
//


#import "IIViewDeckController.h"
#import "UIViewController+MJPopupViewController.h"
#import "HealthCheckMasterViewController.h"
#import "HealthCheckDetailViewController.h"
#import "HealthCheckSettingViewController.h"
#import "HealthCheckFilterViewController.h"
#import "Post.h"
#import "PostTableViewCell.h"
#import "AKSegmentedControl.h"

@interface HealthCheckMasterViewController () {
    NSMutableArray *_objects;
}
- (void)reload:(id)sender resultFrom:(NSString*)resultFrom;
@end
@implementation HealthCheckMasterViewController{
    @private
    NSArray *_posts;
    NSMutableArray *_postsForCurrentStatus;
    NSMutableArray *_filteredPostsForCurrentServiceGroup;
    __strong UIActivityIndicatorView *_activityIndicatorView;
    
    AKSegmentedControl *segmentedControl1, *segmentedControl2, *segmentedControl3;
}
@synthesize segmentStatus;
@synthesize segStatus;
@synthesize btnReload;
@synthesize btnRetest;
- (void)reload:(id)sender resultFrom:(NSString*)resultFrom {
    [_activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [Post globalTimelinePostsWithBlock: resultFrom done: ^(NSArray *posts, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            _posts = posts;
            _filteredPostsForCurrentServiceGroup = [self filter:_posts:@"" serviceGroup:@""];
            _postsForCurrentStatus = [self filter:_filteredPostsForCurrentServiceGroup:[segStatus titleForSegmentAtIndex:segStatus.selectedSegmentIndex] serviceGroup:@""];
            
            [self.tableView reloadData];
        }
        
        [_activityIndicatorView stopAnimating];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

- (void)reloadAllServers {
    [_activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [Post reloadAllServers: @"0" done: ^(NSArray *posts, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            _posts = posts;
            _filteredPostsForCurrentServiceGroup = [self filter:_posts:@"" serviceGroup:@""];
            _postsForCurrentStatus = [self filter:_filteredPostsForCurrentServiceGroup:[segStatus titleForSegmentAtIndex:segStatus.selectedSegmentIndex] serviceGroup:@""];
            
            [self.tableView reloadData];
        }
        
        [_activityIndicatorView stopAnimating];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    
    //Set the toolbar to fit the width of the app.
    [toolbar sizeToFit];
    
    //Calculate the height of the toolbar
    CGFloat toolbarHeight = [toolbar frame].size.height;
    
    //Get the bounds of the parent view
    CGRect rootViewBounds = self.parentViewController.view.bounds;
    
    //Get the height of the parent view.
    CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
    
    //Get the width of the parent view,
    CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
    
    //Create a rectangle for the toolbar
    CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
    
    //Reposition and resize the receiver
    [toolbar setFrame:rectArea];
    
    //Create a button
    UIImage *image = [UIImage imageNamed:@"glyphicons_206_ok_2.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setTitle:@"Reload"forState:UIControlStateNormal];
    //button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    //button.bounds = CGRectMake( 0, 0, image.size.width, image.size.height );
    /*UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 35.0f, 50.0f, 28.0f)];///You can replace it with your own dimensions.
    [label setText: @"reload"];
    [button addSubview:label];
    */
    [button setFrame:CGRectMake(12, 8, 64, 68)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(myAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [toolbar setItems:[NSArray arrayWithObjects:barButtonItem,nil]];
    
    //Add the toolbar as a subview to the navigation controller.
    //[self.navigationController.view addSubview:toolbar];}
}
- (void)loadView {
    [super loadView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicatorView.hidesWhenStopped = YES;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 /*   self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
 */   
    [self reload:nil resultFrom:@"1"];
    
    UINavigationController *centerController = [[UINavigationController alloc] init];
    HealthCheckSettingViewController* leftController = [[HealthCheckSettingViewController alloc] init];
    HealthCheckMasterViewController* rightController = [[HealthCheckMasterViewController alloc] init];
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:centerController leftViewController:leftController
                                                                                   rightViewController:rightController];
    
    
    
    UIImage* infoButtonImage = [UIImage imageNamed:@"Reply.png"];;
    CGRect frameimg = CGRectMake(0, 0, infoButtonImage.size.width, infoButtonImage.size.height);
    UIButton * someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:infoButtonImage forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(actionOfButton)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * infoButton = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    //[self setToolbarItems:[NSArray arrayWithObject:infoButton]];
    
    
    UIImage* filterImage = [UIImage imageNamed:@"Cart.png"];;
    CGRect frameFilterImg = CGRectMake(0, 0, filterImage.size.width, filterImage.size.height);
    UIButton * filterButton = [[UIButton alloc] initWithFrame:frameFilterImg];
    [filterButton setBackgroundImage:filterImage forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(btnFilterClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    myButton.style = UIBarButtonItemStyleBordered;
    //self.navigationItem.rightBarButtonItem = myButton;
    UIBarButtonItem *filterButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleDone target:self action:@selector(btnFilterClicked)] ;
    
    self.navigationItem.rightBarButtonItem = filterButton1;
    
    UIImage* settingImage = [UIImage imageNamed:@"Setting.png"];;
    CGRect frameSettingImg = CGRectMake(0, 0, settingImage.size.width, settingImage.size.height);
    UIButton * settingButton = [[UIButton alloc] initWithFrame:frameSettingImg];
    [settingButton setBackgroundImage:settingImage forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(toggleDeck) forControlEvents:UIControlEventTouchUpInside];
    //UIBarButtonItem *mySettingButton = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    UIBarButtonItem *mySettingButton = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    //self.navigationItem.rightBarButtonItem = myButton;
    [self.navigationItem setLeftBarButtonItem: mySettingButton];
    
    UIBarButtonItem *configButton = [[UIBarButtonItem alloc] initWithTitle:@"Config" style:UIBarButtonItemStyleDone target:self action:@selector(toggleDeck)] ;
    
    self.navigationItem.leftBarButtonItem = configButton;
    
    segmentedControl3 = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(10.0, 80 + 10.0, 180, 32.0)];
    [segStatus addTarget:self action:@selector(segmentStatusChanged111:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl3 setSegmentedControlMode:AKSegmentedControlModeSticky];
    [segmentedControl3 setSelectedIndexes:[NSIndexSet indexSetWithIndex:0] byExpandingSelection:NO];
    
    //[self setupSegmentedControl3];
    
    //[self.navigationController.toolbar setBackgroundImage:[UIImage imageNamed:@"background.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];

    //self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:6.0/255.0 green:12.0/255.0 blue:19.0/255.0 alpha:1.0];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav.png"]
     //forBarMetrics:UIBarMetricsDefault];
    
    //leftController.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:6.0/255.0 green:12.0/255.0 blue:19.0/255.0 alpha:1.0];
    //[leftController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav.png"]
                                                  //forBarMetrics:UIBarMetricsDefault];
    //segmentStatus.selectedSegmentIndex = 0;
    self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (void)setupSegmentedControl3
{
    //UIImage *backgroundImage = [[UIImage imageNamed:@"tabs-bar-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    //[segmentedControl3 setBackgroundImage:backgroundImage];
    [segmentedControl3 setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
    [segmentedControl3 setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    
    [segmentedControl3 setSeparatorImage:[UIImage imageNamed:@"tabs-bar-devider.png"]];
    
    UIImage *buttonBackgroundImagePressedLeft = [[UIImage imageNamed:@"active.png"]
                                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedCenter = [[UIImage imageNamed:@"active.png"]
                                                   resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedRight = [[UIImage imageNamed:@"active.png"]
                                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 4.0)];
    
    
    UIImage *buttonBackgroundImageReleasedLeft = [[UIImage imageNamed:@"inactive.png"]
                                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImageReleasedCenter = [[UIImage imageNamed:@"inactive.png"]
                                                   resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImageReleasedRight = [[UIImage imageNamed:@"inactive.png"]
                                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 4.0)];
    
    UIColor* activeLabelColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    UIColor* normalLabelColor = [UIColor colorWithRed:22.0/255.0 green:166.0/255.0 blue:174.0/255.0 alpha:1.0];
    // Button 1
    UIButton *buttonSocial = [[UIButton alloc] init];
    [buttonSocial setTitle:@"DOWN" forState:UIControlStateNormal];
    [buttonSocial setTitleColor:normalLabelColor forState:UIControlStateNormal];
    [buttonSocial setTitleColor:activeLabelColor forState:UIControlStateSelected];
    [buttonSocial setTitleColor:activeLabelColor forState:UIControlStateHighlighted];
    [buttonSocial.titleLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15.0]];
    [buttonSocial setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    UIImage *buttonSocialImageNormal = [UIImage imageNamed:@"social-icon.png"];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateHighlighted];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateSelected];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [buttonSocial setBackgroundImage:buttonBackgroundImageReleasedLeft forState:UIControlStateNormal];
    /*
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateNormal];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateSelected];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateHighlighted];
    [buttonSocial setImage:buttonSocialImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    */
    // Button 2
    UIButton *buttonStar = [[UIButton alloc] init];
    UIImage *buttonStarImageNormal = [UIImage imageNamed:@"star-icon.png"];
    
    [buttonStar setTitle:@"UP" forState:UIControlStateNormal];
    [buttonStar setTitleColor:normalLabelColor forState:UIControlStateNormal];
    [buttonStar setTitleColor:normalLabelColor forState:UIControlStateNormal];
    [buttonStar setTitleColor:activeLabelColor forState:UIControlStateHighlighted];
    [buttonStar setTitleColor:activeLabelColor forState:UIControlStateSelected];
    [buttonStar.titleLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15.0]];
    [buttonStar setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateHighlighted];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateSelected];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [buttonStar setBackgroundImage:buttonBackgroundImageReleasedCenter forState:UIControlStateNormal];

    /*
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateNormal];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateSelected];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateHighlighted];
    [buttonStar setImage:buttonStarImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    */
    // Button 3
    UIButton *buttonSettings = [[UIButton alloc] init];
    
    [buttonSettings setTitle:@"ALL" forState:UIControlStateNormal];
    [buttonSettings setTitleColor:normalLabelColor forState:UIControlStateNormal];
    [buttonSettings setTitleColor:activeLabelColor forState:UIControlStateHighlighted];
    [buttonSettings setTitleColor:activeLabelColor forState:UIControlStateSelected];
    [buttonSettings.titleLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15.0]];
    [buttonSettings setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];

    UIImage *buttonSettingsImageNormal = [UIImage imageNamed:@"settings-icon.png"];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateHighlighted];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateSelected];
    [buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [buttonSettings setBackgroundImage:buttonBackgroundImageReleasedRight forState:UIControlStateNormal];

    /*
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateNormal];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateSelected];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateHighlighted];
    [buttonSettings setImage:buttonSettingsImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    */
    [segmentedControl3 setButtonsArray:@[buttonSocial, buttonStar, buttonSettings]];
    [segmentedControl3 setSelectedIndex:0];
    //[self.navigationItem setTitleView:segmentedControl3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _postsForCurrentStatus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[PostTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.post = [_postsForCurrentStatus objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PostTableViewCell heightForCellWithPost:[_postsForCurrentStatus objectAtIndex:indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _postsForCurrentStatus[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (void)toggleDeck {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (void)cancelButtonClicked: (HealthCheckFilterViewController *)healthCheckFilterViewController selectedGroups:(NSArray*)groups
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    if(groups.count > 0){
        NSArray* selectedGroups =  groups;
        NSMutableArray* filtered = [[NSMutableArray alloc]init];
        [groups enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [filtered addObjectsFromArray:[self filter:_posts: @"" /*[segStatus titleForSegmentAtIndex:segStatus.selectedSegmentIndex] */serviceGroup:obj ]];
        }];
        
        _filteredPostsForCurrentServiceGroup = filtered;
        _postsForCurrentStatus = [self filter:_filteredPostsForCurrentServiceGroup:[segStatus titleForSegmentAtIndex:segStatus.selectedSegmentIndex] serviceGroup:@""];
        [self.tableView reloadData];
    }
}

-(void)dismissPopupView
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(NSArray*)prepareFilterData:(HealthCheckFilterViewController *)healthCheckFilterViewController
{
    return _posts;
}

- (void)btnFilterClicked{
    HealthCheckFilterViewController *filter = [self.storyboard instantiateViewControllerWithIdentifier:@"filter"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"RoundedButtonDone.png"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(btnDoneClicked) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 54, 30);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:filter];
    filter.delegate = self;
    
    [self presentPopupViewController:navController animationType:MJPopupViewAnimationSlideBottomTop];
}

- (void)segmentStatusChanged111:(id)sender {
    
    UISegmentedControl *segmentedControl1 = (UISegmentedControl *)sender;
    NSString * status = @"";
    NSInteger selectedSegment = segmentedControl1.selectedSegmentIndex;
    switch (selectedSegment) {
        case 0:
            //Down
            status = @"DOWN";
            break;
        case 1:
            //Up
            status = @"UP";
        default:
            break;
    }
    
    _postsForCurrentStatus = [self filter: _filteredPostsForCurrentServiceGroup :status serviceGroup:@""];
    [self.tableView reloadData];

}



- (IBAction)btnGetLatestClicked:(id)sender {
    [self reload:nil resultFrom:@"1"];
}

-(IBAction)btnRetest:(UIBarButtonItem *)sender{
    [self reload:Nil resultFrom:@"2"];
}

-(IBAction)btnReloadClicked:(UIBarButtonItem *)sender
{
    [self reloadAllServers];
}

-(NSMutableArray*)filter:(NSArray *)posts: (NSString*)status serviceGroup:(NSString*)serviceGroup{
    NSMutableArray* filtered = [[NSMutableArray alloc] init];
    
    for (int i=0;i<[posts count];i++)
    {
        Post* item=[posts objectAtIndex:i];
        
        if (([status isEqualToString:item.status] || ([status isEqualToString:@"DOWN"] && ([item.status isEqualToString:@"DOWN"] || [item.status isEqualToString:@"N/A"])) || [status isEqualToString: @""] || [status isEqualToString: @"ALL"])
            && ([serviceGroup isEqualToString:item.serviceGroup] || [serviceGroup isEqualToString:@""] || [serviceGroup isEqualToString:@"All"]))
        {
            [filtered addObject:item];
        }
    }
    
    return filtered;
}

-(NSMutableArray*)filterByServiceGroup:(NSString*)group{
    NSMutableArray* filtered = [[NSMutableArray alloc] init];
    
    for (int i=0;i<[_posts count];i++)
    {
        Post* item=[_posts objectAtIndex:i];
        
        if ([group isEqualToString:item.serviceGroup]|| [group isEqualToString: @""])
        {
            [filtered addObject:item];
        }
    }
    
    return filtered;
}

- (void)action:(id)sender
{
    
}
- (IBAction)segmentStatus:(id)sender {
    
}
@end

