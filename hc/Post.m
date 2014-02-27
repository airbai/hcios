// Post.m
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "Post.h"

#import "AFAppDotNetAPIClient.h"

@implementation Post
@synthesize Id = _Id;
@synthesize status = _status;
@synthesize serviceGroup = _serviceGroup;
@synthesize host = _host;
@synthesize urlData = _urlData;
@synthesize grep = _grep;
@synthesize executionTime = _executionTime;
@synthesize lastTested = _lastTested;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _Id = [attributes valueForKeyPath:@"Id"];
    _status = [attributes valueForKeyPath:@"Status"];
    _ip = [attributes valueForKey:@"ServerIP"];
    _ping = [attributes valueForKey:@"IPStatus"];
    _name = [attributes valueForKey:@"ServerName"];
    _host = [attributes valueForKeyPath:@"Host"];
    _serviceGroup = [attributes valueForKeyPath:@"ServiceGroup"];
    _urlData = [attributes valueForKeyPath:@"URLData"];
    _grep = [attributes valueForKeyPath:@"Grep"];
    _executionTime = [attributes valueForKeyPath:@"ExecutionTime"];
    _lastTested = [attributes valueForKeyPath:@"LastCheckedAt"];
    //_user = [[User alloc] initWithAttributes:[attributes valueForKeyPath:@"user"]];
    
    return self;
}

#pragma mark -

+ (void)globalTimelinePostsWithBlock:(NSString*)resultFrom done:(void (^)(NSArray *posts, NSError *error))block {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"bbai@websense.com", @"username", @"", @"token", @"1", @"resultsFrom", @"true", @"noActualHtmlOutput", @"json", @"format", nil];
    
    [[AFAppDotNetAPIClient sharedClient] postPath:@"/services/healthcheckservice.asmx/GetTestResults" parameters: parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        @try {
            
            id healthCheckMonitorResponses = [JSON valueForKeyPath:@"HealthCheckMonitorResponse"];

            id healthCheckMonitorMessage = [healthCheckMonitorResponses valueForKeyPath:@"healthCheckMonitorMessage"];
            NSArray *serverStatusDetails = [healthCheckMonitorMessage valueForKeyPath:@"serverStatusDetails"];
            
            NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[serverStatusDetails count]];
            for (NSDictionary *attributes in serverStatusDetails) {
                Post *post = [[Post alloc] initWithAttributes:attributes];
                [mutablePosts addObject:post];
            }
            
            if (block) {
                block([NSArray arrayWithArray:mutablePosts], nil);
            }
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

@end
