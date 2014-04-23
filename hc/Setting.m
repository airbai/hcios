//
//  Setting.m
//  hc
//
//  Created by bai on 14-3-12.
//  Copyright (c) 2014年 Websense. All rights reserved.
//

#import "Setting.h"
#import "AFAppDotNetAPIClient.h"

@implementation Setting
+(void)generateToken:(NSString *)userName :(NSString *)password done:(void (^)(NSString*, NSDictionary* messages, NSError *))block
{
    NSString * param = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><GenerateToken xmlns=\"http://www.websense.com/\"><username>%@</username><password>%@</password><format>%@</format></GenerateToken></soap12:Body></soap12:Envelope>", userName, password, @"json"];
    
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
            
            id token = [JSON1 valueForKeyPath:@"Token"];
            id messages = [JSON1 valueForKey:@"Errors"];
            
            if (block) {
                block(token, messages, error);
            }
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}
@end
