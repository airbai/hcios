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

@interface HealthCheckMasterViewController () {
    NSMutableArray *_objects;
}
- (void)reload:(id)sender resultFrom:(NSString*)resultFrom;
@end

@implementation HealthCheckMasterViewController{
    @private
    NSArray *_posts;
    NSMutableArray *_postsForCurrentStatus;
    __strong UIActivityIndicatorView *_activityIndicatorView;
}
@synthesize segmentStatus;
@synthesize btnFilter;
- (void)reload:(id)sender resultFrom:(NSString*)resultFrom {
    [_activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [Post globalTimelinePostsWithBlock: resultFrom done: ^(NSArray *posts, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            _posts = posts;
            _postsForCurrentStatus = [self filter:@"DOWN" serviceGroup:@""];
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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"ButtonMenu.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0.0, 100.0, 60.0, 30.0);
    [button setTitle:@"Green" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnFilterClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationController.navigationItem.rightBarButtonItem = myButton;
    
    [self.navigationController.toolbar setBackgroundImage:[UIImage imageNamed:@"background.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    UIImage *image = [UIImage imageNamed:@"nav.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"nav.png"]
     forBarMetrics:UIBarMetricsDefault];
    //segmentStatus.selectedSegmentIndex = 0;

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
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _posts[indexPath.row];
    cell.textLabel.text = [object description];*/
    static NSString *CellIdentifier = @"Cell";
    
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[PostTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.post = [_postsForCurrentStatus objectAtIndex:indexPath.row];    return cell;
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


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



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

- (IBAction)toggleDeck:(UIBarButtonItem *)sender {        [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (void)cancelButtonClicked: (HealthCheckFilterViewController *)healthCheckFilterViewController selectedGroups:(NSArray*)groups
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    if(groups.count > 0){
        NSArray* selectedGroups =  groups;
        NSMutableArray* filtered = [[NSMutableArray alloc]init];
        [groups enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [filtered addObjectsFromArray:[self filter:[segmentStatus titleForSegmentAtIndex:segmentStatus.selectedSegmentIndex] serviceGroup:obj ]];
        }];
    
        _postsForCurrentStatus = filtered;
        [self.tableView reloadData];
    }
}

-(NSArray*)prepareFilterData:(HealthCheckFilterViewController *)healthCheckFilterViewController
{
    return _posts;
}

- (IBAction)btnFilterClicked:(id)sender{
    //HealthCheckFilterViewController* filter = [[HealthCheckFilterViewController alloc] init];
    //UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:filter];
    //filter.delegate = self;
    //[[self navigationController] presentModalViewController:navController animated:YES];
    //[self presentPopupViewController:filter animationType:MJPopupViewAnimationSlideBottomTop];
    HealthCheckFilterViewController *filter = [self.storyboard instantiateViewControllerWithIdentifier:@"filter"];
    filter.delegate = self;
    [self presentPopupViewController:filter animationType:MJPopupViewAnimationSlideBottomTop];
}

- (IBAction)segmentStatusChanged:(UISegmentedControl*)sender {
    
    NSString * status = @"";
    switch (sender.selectedSegmentIndex) {
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
    
    _postsForCurrentStatus = [self filter:status serviceGroup:@""];
    [self.tableView reloadData];

}



- (IBAction)btnGetLatestClicked:(id)sender {
    [self reload:nil resultFrom:@"1"];
}

-(NSMutableArray*)filter:(NSString*)status serviceGroup:(NSString*)serviceGroup{
    NSMutableArray* filtered = [[NSMutableArray alloc] init];
    
    for (int i=0;i<[_posts count];i++)
    {
        Post* item=[_posts objectAtIndex:i];
        
        if (([status isEqualToString:item.status]|| [status isEqualToString: @""])
            && ([serviceGroup isEqualToString:item.serviceGroup] || [serviceGroup isEqualToString:@""] ))
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

