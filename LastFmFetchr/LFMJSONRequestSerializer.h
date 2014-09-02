//
//  LFMJSONRequestSerializer.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 02/09/14.
//  Copyright (c) 2014 edgeguard. All rights reserved.
//

#import "AFURLRequestSerialization.h"

@interface LFMJSONRequestSerializer : AFJSONRequestSerializer

/**
 Additional HTTP parameters which will be added to each outgoing request.
 */
@property (nonatomic, strong) NSDictionary *HTTPAdditionalParameters;

@end
