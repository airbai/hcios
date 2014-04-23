// Post.h
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
// THE SOFTWARE.a
#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (readonly) NSString *Id;
@property (readonly) NSString *status;
@property (readonly) NSString *ip;
@property (readonly) NSString *name;
@property  NSString *serviceGroup;
@property (readonly) NSString *host;
@property (readonly) NSString *urlData;
@property (readonly) NSString *ping;
@property (readonly) NSString *grep;
@property (readonly) NSString *executionTime;
@property (readonly) NSString *lastTested;
@property (readonly) NSString *actualHtml;

- (id)initWithAttributes:(NSDictionary *)attributes;
- (NSString*)getUsername;
- (NSString*)getToken;

+ (void)globalTimelinePostsWithBlock:(NSString*)resultFrom done:(void (^)(NSArray *posts, NSError *error))block;

+ (void)reloadAllServers: (NSString*)resultFrom done:(void (^)(NSArray *posts, NSError *error))block;

+ (void)testServer: (NSString*)serverInstanceId: (NSString*)resultFrom done:(void (^)(NSArray *posts, NSError *error))block;
@end
