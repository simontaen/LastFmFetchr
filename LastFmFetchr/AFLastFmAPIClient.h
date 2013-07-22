//
//  AFLastFmAPIClient.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface AFLastFmAPIClient : AFHTTPClient

+ (AFLastFmAPIClient *)sharedClient;

@end
