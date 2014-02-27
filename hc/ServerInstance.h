//
//  ServerInstance.h
//  hc
//
//  Created by bai on 13-11-12.
//  Copyright (c) 2013年 Websense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerInstance : NSObject
    @property (nonatomic, retain) NSString *Id;
    @property (nonatomic, retain) NSString *ServiceGroup;
    @property (nonatomic, retain) NSString *ServerNumber;
    @property (nonatomic, retain) NSString *ServerName;
    @property (nonatomic, retain) NSString *ServerIP;
    @property (nonatomic, retain) NSString *Host;
    @property (nonatomic, retain) NSString *Username;
    @property (nonatomic, retain) NSString *Password;
    @property (nonatomic, retain) NSString *Domain;
    @property (nonatomic, retain) NSString *URLData;
    @property (nonatomic, retain) NSString *HTTPProtocol;
    @property (nonatomic, retain) NSString *CompleteUri;
    @property (nonatomic, retain) NSString *Grep;
    @property (nonatomic, retain) NSString *ResultsFrom;
    @property (nonatomic, retain) NSString *CheckInterval;
    @property (nonatomic, retain) NSString *NotificationEmail;
@end
