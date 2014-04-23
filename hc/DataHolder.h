//
//  DataHolder.h
//  hc
//
//  Created by bai on 14-4-23.
//  Copyright (c) 2014年 Websense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHolder : NSObject
+ (DataHolder *)sharedInstance;

@property (assign) NSString* username;
@property (assign) NSString* token;

-(void) saveData;
-(void) loadData;
@end
