//
//  AFLastFmAPIClient.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "AFLastFmAPIClient.h"
#import "AFJSONRequestOperation.h"

// Base URL to the API
static NSString *const kLFMBaseURLString = @"http://ws.audioscrobbler.com/2.0";

@implementation AFLastFmAPIClient

+ (AFLastFmAPIClient *)sharedClient {
	static AFLastFmAPIClient *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedClient = [[AFLastFmAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kLFMBaseURLString]];
	});
	return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
	self = [super initWithBaseURL:url];
	if (!self) {
		return nil;
	}
	
	// Use JSON API
	[self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	// Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
	// Last.fm requirement, see http://www.last.fm/api/intro
	self.stringEncoding = NSUTF8StringEncoding;
	// strongly recommended by AFNetworking
	self.parameterEncoding = AFJSONParameterEncoding;
	
	return self;
}

@end
