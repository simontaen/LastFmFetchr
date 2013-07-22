//
//  LastFmFetchr.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LastFmFetchr.h"
#import "AFNetworking.h"
#import "AFLastFmAPIClient.h"

// Base URL to the API
NSString *const kLFMBaseURLString = @"http://ws.audioscrobbler.com/2.0";

// Artist Info keys
NSString *const kLFMArtistBio = @"bio";
NSString *const kLFMArtistSummary = @"summary";
NSString *const kLFMArtistName = @"name";
NSString *const kLFMArtistLastFmPageURL = @"url";
NSString *const kLFMArtistImageLarge = @"image";
NSString *const kLFMArtistListeners = @"listeners";
NSString *const kLFMArtistPlaycount = @"playcount";
NSString *const kLFMArtistTags = @"tags";
NSString *const kLFMArtistIsOnTour = @"ontour";

@interface LastFmFetchr ()
{
	NSUserDefaults *userDefaults;
	dispatch_queue_t async_queue;
}
@end

@implementation LastFmFetchr

# pragma mark - Singleton Methods

+ (id)sharedManager
{
	static LastFmFetchr *_sharedManager;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedManager = [[self alloc] init];
	});
	return _sharedManager;
}

- (id)init {
	if (self = [super init]) {
		// Init code here
		userDefaults = [NSUserDefaults standardUserDefaults];
		
		// Setup the async queue
		async_queue = dispatch_queue_create("com.lastfmfetchr.asyncQueue", NULL);
	}
	return self;
}


#pragma mark - API calls

/// Artist methods
- (void)getInfoForArtist:(NSString *)artist
						  success:(void (^)(id JSON))success
						  failure:(void (^)(id response, NSError *error))failure
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"method"] = @"artist.getInfo";
	params[@"artist"] = artist;

	[[AFLastFmAPIClient sharedClient] getPath:@"artist.getInfo"
								   parameters:[self addDefaultParameters:params]
									  success:^(AFHTTPRequestOperation *operation, id JSON) {
										  success(JSON);
									  }
									  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
										  failure(operation, error);
									  }];
	
#ifndef NDEBUG
	NSLog(@"LastFmFetchr: Request artist.getInfo");
#endif
}

#pragma mark - Requests Management

/// Cancels all artists.getInfo requests that are currently queued or being executed
- (void)cancelAllArtistsGetInfoRequests
{
	[[AFLastFmAPIClient sharedClient] cancelAllHTTPOperationsWithMethod:@"GET" path:@"artist.getInfo"];
}

#pragma mark - Error Handling

/// Returns a string with the JSON error message, if given, or the appropriate localized description for the NSError object
- (NSString *)messageForError:(NSError *)error withResponse:(id)response
{
	if ([response isKindOfClass:[NSDictionary class]]) {
		NSString *errorMsg = [response objectForKey:@"message"];
		return (errorMsg.length) ? errorMsg : error.localizedDescription;
	} else if ([response isKindOfClass:[AFHTTPRequestOperation class]]) {
		AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)response;
		int statusCode = operation.response.statusCode;
		NSString *errorMsg = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
		return [errorMsg stringByAppendingFormat:@" (code %d)", statusCode];
	} else {
		return error.localizedDescription;
	}
}

# pragma mark - Private Methods

- (NSDictionary *)addDefaultParameters:(NSMutableDictionary *)parameters
{
	// Check if we have an API key set,
	[self checkForAPIKey];
	
	static NSDictionary *defaultParameters;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		defaultParameters = @{ @"format" : @"json", @"api_key" : self.apiKey};
	});
	
	[parameters addEntriesFromDictionary:defaultParameters];
	return parameters;
}

/// Check for an empty API key
- (void)checkForAPIKey
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		if (!self.apiKey || !self.apiKey.length) {
			[NSException raise:@"LastFmFetchr" format:@"Your Last.fm API key must be populated before you can access the API.", nil];
		}
	});
}

// make sure you can only call this once
//- (void)setApiKey:(NSString *)apiKey

@end
