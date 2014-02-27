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
@synthesize actualHtml = _actualHtml;

static NSString * _token = @"[your token]";
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
    _actualHtml = [attributes valueForKey:@"ActualHtmlOutput"];
    
    return self;
}

#pragma mark -

+ (void)globalTimelinePostsWithBlock:(NSString*)resultFrom done:(void (^)(NSArray *posts, NSError *error))block {
    /*NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"bbai@websense.com", @"username", @"", @"token", resultFrom, @"resultsFrom", @"true", @"noActualHtmlOutput", @"json", @"format", nil];*/
    
    NSString * param = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><GetTestResults xmlns=\"http://www.websense.com/\"><username>%@</username><token>%@</token><resultsFrom>%@</resultsFrom><noActualHtmlOutput>%@</noActualHtmlOutput><format>%@</format></GetTestResults></soap12:Body></soap12:Envelope>",
        @"bbai@websense.com", _token, resultFrom, @"true", @"json"];

    //[[AFAppDotNetAPIClient sharedClient] ini]
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                param, @"SoapBody", nil];
    
    [[AFAppDotNetAPIClient sharedClient] postPath:@"/services/healthcheckservice.asmx" parameters: parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        @try {
            NSError *error;
            NSString *aString = [[NSString alloc] initWithData:JSON encoding:NSUTF8StringEncoding];
            //if (error != nil)
            //{
            NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [aString dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
            id healthCheckMonitorResponses = [JSON1 valueForKeyPath:@"HealthCheckMonitorResponse"];

            id healthCheckMonitorMessage = [healthCheckMonitorResponses valueForKeyPath:@"healthCheckMonitorMessage"];
            NSArray *serverStatusDetails = [healthCheckMonitorMessage valueForKeyPath:@"serverStatusDetails"];
            
            NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[serverStatusDetails count]];
            for (NSDictionary *attributes in serverStatusDetails) {
                Post *post = [[Post alloc] initWithAttributes:attributes];
                [mutablePosts addObject:post];
            //}
            
            if (block) {
                block([NSArray arrayWithArray:mutablePosts], nil);
            }
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

+ (void)reloadAllServers: (NSString*)resultFrom done:(void (^)(NSArray *posts, NSError *error))block {
    /*NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"bbai@websense.com", @"username", @"", @"token", @"true", @"noActualHtmlOutput", @"json", @"format", nil];*/
    NSString * param = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><ReloadAllServers xmlns=\"http://www.websense.com/\"><username>%@</username><token>%@</token><noActualHtmlOutput>%@</noActualHtmlOutput><format>%@</format></ReloadAllServers></soap12:Body></soap12:Envelope>", @"bbai@websense.com", _token, @"true", @"json"];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                param, @"SoapBody", nil];
    
    [[AFAppDotNetAPIClient sharedClient] postPath:@"/services/healthcheckservice.asmx" parameters: parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        @try {
            NSError *error;
            NSString *aString = [[NSString alloc] initWithData:JSON encoding:NSUTF8StringEncoding];
            //if (error != nil)
            //{
            NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [aString dataUsingEncoding:NSUTF8StringEncoding]
                                                                  options: NSJSONReadingMutableContainers
                                                                    error: &error];
            id healthCheckMonitorResponses = [JSON1 valueForKeyPath:@"HealthCheckMonitorResponse"];
            
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

+ (void)testServer: (NSString*)serverInstanceId : (NSString*)resultsFrom done:(void (^)(Post *post, NSError *error))block {
    /*NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"bbai@websense.com", @"username", @"", @"token", serverInstanceId, @"serverInstanceId", resultsFrom, @"resultsFrom", @"json", @"format", nil];*/
    
    NSString * param = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><TestServer xmlns=\"http://www.websense.com/\"><username>%@</username><token>%@</token><serverInstanceId>%@</serverInstanceId><resultsFrom>%@</resultsFrom><format>%@</format></TestServer></soap12:Body></soap12:Envelope>", @"bbai@websense.com", _token, serverInstanceId, resultsFrom, @"json"];
    
    //[[AFAppDotNetAPIClient sharedClient] ini]
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                param, @"SoapBody", nil];
    
    [[AFAppDotNetAPIClient sharedClient] postPath:@"/services/healthcheckservice.asmx" parameters: parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        @try {
            NSError *error;
            NSString *aString = [[NSString alloc] initWithData:JSON encoding:NSUTF8StringEncoding];

            NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [aString dataUsingEncoding:NSUTF8StringEncoding]
                                                                  options: NSJSONReadingMutableContainers
                                                                    error: &error];
            
            id serverStatusDetail = [JSON1 valueForKeyPath:@"ServerStatusDetail"];
            
            Post *post = [[Post alloc]initWithAttributes:serverStatusDetail];
            
            if (block) {
                block(post, nil);
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
