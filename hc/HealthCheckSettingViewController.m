//
//  HealthCheckSettingViewController.m
//  hc
//
//  Created by bai on 13-5-30.
//  Copyright (c) 2013年 Websense. All rights reserved.
//

#import "HealthCheckSettingViewController.h"
#import "Setting.h"
#import "DataHolder.h"

@interface HealthCheckSettingViewController ()

@end
@implementation HealthCheckSettingViewController
@synthesize txtUsername;
@synthesize txtPassword;
@synthesize btnGenerateToken;
__strong UIActivityIndicatorView *_activityIndicatorView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [txtPassword setSecureTextEntry:YES];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onClickedGenerate:(id)sender {
    [_activityIndicatorView startAnimating];
    NSString* userName = [txtUsername text];
    NSString* password = [txtPassword text];
    [Setting generateToken:userName :password done:^(NSString *token, NSDictionary* messages, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else if([messages count] == 0){
            [[[UIAlertView alloc] initWithTitle:@"Token Generated" message:token delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
            
            DataHolder* data = [DataHolder sharedInstance];
            data.username = userName;
            data.token = token;
        }
        else{
            NSString* title = [messages valueForKey:@"Name"][0];
            NSString* message = [messages valueForKey:@"Message"][0];
            
            [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        }
        
        [_activityIndicatorView stopAnimating];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}
@end
