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
#import "DataHolder.h"

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
<<<<<<< HEAD
NSString* username = @"bbai@websense.com";
NSString* token = @"";
static NSString * _token = @"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";
=======

static NSString * _token = @"[your token]";
>>>>>>> FETCH_HEAD
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
        [[Post alloc] getUsername], [[Post alloc] getToken], resultFrom, @"true", @"json"];

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
    NSString * param = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><ReloadAllServers xmlns=\"http://www.websense.com/\"><username>%@</username><token>%@</token><noActualHtmlOutput>%@</noActualHtmlOutput><format>%@</format></ReloadAllServers></soap12:Body></soap12:Envelope>", [[Post alloc] getUsername], [[Post alloc] getToken], @"true", @"json"];
    
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
    
    NSString * param = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><TestServer xmlns=\"http://www.websense.com/\"><username>%@</username><token>%@</token><serverInstanceId>%@</serverInstanceId><resultsFrom>%@</resultsFrom><format>%@</format></TestServer></soap12:Body></soap12:Envelope>", [[Post alloc] getUsername], [[Post alloc] getToken], serverInstanceId, resultsFrom, @"json"];
    
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

- (NSString*)getToken{
    DataHolder* data = [DataHolder sharedInstance];
    if(data && data.token != NULL)
    {
        token = data.token;
    }
    else
    {
        token = _token;
    }
    
    return token;
}

- (NSString*)getUsername{
    DataHolder* data = [DataHolder sharedInstance];
    if(data && data.username != NULL)
    {
        username = data.username;
    }
    
    return username;
}
@end
