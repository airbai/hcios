//
//  Setting.h
//  hc
//
//  Created by bai on 14-3-12.
//  Copyright (c) 2014年 Websense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Setting : NSObject
+ (void)generateToken: (NSString*)userName: (NSString*)password done:(void (^)(NSString* token, NSDictionary* messages, NSError *error))block;
@end
