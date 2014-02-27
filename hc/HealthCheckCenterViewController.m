//
//  HealthCheckCenterViewController.m
//  hc
//
//  Created by bai on 13-5-31.
//  Copyright (c) 2013年 Websense. All rights reserved.
//

#import "HealthCheckCenterViewController.h"

@interface HealthCheckCenterViewController ()

@end

@implementation HealthCheckCenterViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:@"middleViewController"]
                            leftViewController:[storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
    if (self) {
        // Add any extra init code here
    }
    return self;
}
@end
