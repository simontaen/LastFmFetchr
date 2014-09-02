//
//  LFMJSONRequestSerializer.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 02/09/14.
//  Copyright (c) 2014 edgeguard. All rights reserved.
//

#import "LFMJSONRequestSerializer.h"

@implementation LFMJSONRequestSerializer

#pragma mark - AFJSONRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    if (self.HTTPAdditionalParameters && [parameters isKindOfClass:[NSDictionary class]]) {
		NSMutableDictionary *mutableParameters = [parameters mutableCopy];
        [mutableParameters addEntriesFromDictionary:self.HTTPAdditionalParameters];
		
		return [super requestBySerializingRequest:request withParameters:mutableParameters error:error];
    } else {
		return [super requestBySerializingRequest:request withParameters:parameters error:error];
	}
}

@end
