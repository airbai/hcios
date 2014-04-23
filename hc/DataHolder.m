//
//  DataHolder.m
//  hc
//
//  Created by bai on 14-4-23.
//  Copyright (c) 2014年 Websense. All rights reserved.
//

#import "DataHolder.h"

NSString * const kUsername = @"kUsername";
NSString * const kToken = @"kToken";

@implementation DataHolder

- (id) init
{
    self = [super init];
    if (self)
    {
        _username = 0;
        _token = 0;
    }
    return self;
}

+ (DataHolder *)sharedInstance
{
    static DataHolder *_sharedInstance = nil;
    static dispatch_once_t onceSecurePredicate;
    dispatch_once(&onceSecurePredicate,^
                  {
                      _sharedInstance = [[self alloc] init];
                  });
    
    return _sharedInstance;
}

//in this example you are saving data to NSUserDefault's
//you could save it also to a file or to some more complex
//data structure: depends on what you need, really

-(void)saveData
{
    [[NSUserDefaults standardUserDefaults]
     setObject:self.username forKey:kUsername];
    
    [[NSUserDefaults standardUserDefaults]
     setObject:self.token forKey:kToken];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadData
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUsername])
    {
        self.username = [[NSUserDefaults standardUserDefaults]
                                   objectForKey:kUsername];
        
        self.token = [[NSUserDefaults standardUserDefaults]
                                   objectForKey:kToken];
    }
    else
    {
        self.username = 0;
        self.token = 0;
    } 
}

@end
