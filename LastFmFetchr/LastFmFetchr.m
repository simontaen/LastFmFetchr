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

// ------------ Keys to the JSON response from Last.fm ------------------
// By convention you need to use valueForKeyPath: if the constant name contains an underbar '_'

// artist.getInfo
NSString *const kLFMArtist_Members = @"bandmembers.member";
NSString *const kLFMArtistBio = @"bio";
NSString *const kLFMArtistBio_Content = @"bio.content";
NSString *const kLFMArtistBio_FormationYears = @"bio.formationlist.formation";
NSString *const kLFMArtistBio_Link = @"bio.links.link";
NSString *const kLFMArtistBio_PlaceFormed = @"bio.placeformed";
NSString *const kLFMArtistBio_Published = @"bio.published";
NSString *const kLFMArtistBio_Summary = @"bio.summary";
NSString *const kLFMArtistBio_YearFormed = @"bio.yearformed";
NSString *const kLFMArtistImageList = @"image";
NSString *const kLFMArtistMusicBrianzId = @"mbid";
NSString *const kLFMArtistName = @"name";
NSString *const kLFMArtistIsOnTour = @"ontour";
NSString *const kLFMArtist_SimilarArtists = @"similar.artist";
NSString *const kLFMArtistStats_Listeners = @"stats.listeners";
NSString *const kLFMArtistStats_Playcount = @"stats.playcount";
NSString *const kLFMArtistStreamable = @"streamable";
NSString *const kLFMArtist_Tags = @"tags.tag";
NSString *const kLFMArtistLastFmPageURL = @"url";


// ------------------- PRIVATE CONSTANTS -------------------

// Base URL to the API
NSString *const kLFMBaseURLString = @"http://ws.audioscrobbler.com/2.0";

// Last.fm API parameters
NSString *const kLFMParameterMethod = @"method";
NSString *const kLFMParameterArtist = @"artist";

// Last.fm API method parameter values
NSString *const kLFMMethodArtistGetInfo = @"artist.getInfo";


@interface LastFmFetchr ()
{
	NSUserDefaults *userDefaults;
	AFLastFmAPIClient *lastFmApiClient;
	dispatch_queue_t async_queue;
}
@end

@implementation LastFmFetchr

#pragma mark - API calls

/// Artist methods
- (NSOperation *)getInfoForArtist:(NSString *)artist
						  success:(void (^)(NSDictionary *JSON))success
						  failure:(void (^)(id response, NSError *error))failure
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[kLFMParameterMethod] = kLFMMethodArtistGetInfo;
	params[kLFMParameterArtist] = artist;
	
#ifndef NDEBUG
	NSLog(@"LastFmFetchr: Request %@", kLFMMethodArtistGetInfo);
#endif
	
	return [self getPath:@""
			  parameters:[self addDefaultParameters:params]
				 success:^(AFHTTPRequestOperation *operation, id JSON) {
					 if (!operation.isCancelled) {
						 if ([JSON isKindOfClass:[NSDictionary class]]) {
							 // THAT is a code-smell https://twitter.com/qcoding/status/359770054226755584
							 // But it's unavoidable
							 success((NSDictionary *)(JSON[kLFMParameterArtist]));
						 } else {
							 // TODO create an appropriate error object
							 failure(operation, nil);
						 }
					 }
				 }
				 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					 if (!operation.isCancelled) failure(operation, error);
				 }];
}

#pragma mark - Requests Management

/// Cancels all requests that are currently queued or being executed
- (void)cancelAllRequests
{
	[lastFmApiClient cancelAllHTTPOperationsWithMethod:nil path:nil];
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

/// DO NOT modify the operation returned, race-condition, see https://github.com/AFNetworking/AFNetworking/wiki/AFNetworking-FAQ#why-dont-afhttpclients--getpath-et-al-return-the-operation-instead-of-void
- (AFHTTPRequestOperation *)getPath:(NSString *)path
						 parameters:(NSDictionary *)parameters
							success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
							failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
	NSURLRequest *request = [lastFmApiClient requestWithMethod:@"GET" path:path parameters:parameters];
    AFHTTPRequestOperation *operation = [lastFmApiClient HTTPRequestOperationWithRequest:request success:success failure:failure];
    [lastFmApiClient enqueueHTTPRequestOperation:operation];
	return operation;
}

/// DO NOT modify the operation returned, race-condition, see https://github.com/AFNetworking/AFNetworking/wiki/AFNetworking-FAQ#why-dont-afhttpclients--getpath-et-al-return-the-operation-instead-of-void
- (AFHTTPRequestOperation *)postPath:(NSString *)path
						  parameters:(NSDictionary *)parameters
							 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
							 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
	NSURLRequest *request = [lastFmApiClient requestWithMethod:@"POST" path:path parameters:parameters];
	AFHTTPRequestOperation *operation = [lastFmApiClient HTTPRequestOperationWithRequest:request success:success failure:failure];
    [lastFmApiClient enqueueHTTPRequestOperation:operation];
	return  operation;
}

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

# pragma mark - Singleton Methods

+ (instancetype)sharedManager
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
		lastFmApiClient = [AFLastFmAPIClient sharedClient];
		
		// Setup the async queue
		async_queue = dispatch_queue_create("com.lastfmfetchr.asyncQueue", NULL);
	}
	return self;
}

@end
