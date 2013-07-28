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
#import "SDURLCache.h"


// ------------ Keys to the JSON response from Last.fm ------------------
// By convention you need to use valueForKeyPath: if the constant name contains an underbar '_'

// artist.getInfo
NSString *const kLFMArtist_Members = @"bandmembers.member";
//NSString *const kLFMArtistBio = @"bio";
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

// ------------ API Error codes, see http://www.last.fm/api/errorcodes ------------------

NSString *const kLFMSericeErrorDomain = @"com.lastfmfetchr.service.errors";

// ------------------- PRIVATE CONSTANTS -------------------

NSString *const kLFMSericeErrorCode = @"error";
NSString *const kLFMSericeErrorMessage = @"message";

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
						  failure:(void (^)(NSOperation *operation, NSError *error))failure
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
							 
							 if (JSON[kLFMSericeErrorCode]) {
								 NSError *error = [[NSError alloc] initWithDomain:kLFMSericeErrorDomain
																			 code:[JSON[kLFMSericeErrorCode] intValue]
																		 userInfo:@{ NSLocalizedDescriptionKey : JSON[kLFMSericeErrorMessage], kLFMParameterMethod : kLFMMethodArtistGetInfo}];
								 failure(operation, error);
							 } else {
								 success((NSDictionary *)(JSON[kLFMParameterArtist]));
							 }
							 
						 } else {
							 NSError *error = [[NSError alloc] initWithDomain:kLFMSericeErrorDomain
																		 code:0
																	 userInfo:@{ NSLocalizedDescriptionKey : @"Invalid service response", kLFMParameterMethod : kLFMMethodArtistGetInfo}];
							 failure(operation, error);
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
- (NSString *)messageForError:(NSError *)error withOperation:(NSOperation *)operation
{
	NSString *errorMsg = @"";
	if ([operation isKindOfClass:[AFHTTPRequestOperation class]]) {
		
		int statusCode = ((AFHTTPRequestOperation *)operation).response.statusCode;
		errorMsg = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
		errorMsg = [errorMsg stringByAppendingFormat:@" (code %d). ", statusCode];
		
	}
	
	errorMsg = [errorMsg stringByAppendingString:error.localizedDescription];
	
	NSString *method = error.userInfo[kLFMParameterMethod];
	
	if (method.length) {
		errorMsg = [errorMsg stringByAppendingFormat:@" (Method '%@').", method];
	} else {
		errorMsg = [errorMsg stringByAppendingString:@"."];
	}
	
	return errorMsg;
}

# pragma mark - Private Methods

/// DO NOT modify the operation returned, very possible race-condition, see https://github.com/AFNetworking/AFNetworking/wiki/AFNetworking-FAQ#why-dont-afhttpclients--getpath-et-al-return-the-operation-instead-of-void
- (AFHTTPRequestOperation *)getPath:(NSString *)path
						 parameters:(NSDictionary *)parameters
							success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
							failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
	// using the decomposed convenience method from the AFHTTPClient
	NSURLRequest *request = [lastFmApiClient requestWithMethod:@"GET" path:path parameters:parameters];
	NSLog(@"NSURLRequest Cache policy: %u", request.cachePolicy);
    AFHTTPRequestOperation *operation = [lastFmApiClient HTTPRequestOperationWithRequest:request success:success failure:failure]; // actually is a registerHTTPOperationClass
	// AFHTTPRequestOperation's superclass AFURLConnectionOperation is the NSURLConnectionDelegate.
	// For all the delegate methods it provides a block property which gets called if set.
	// You would do something like http://blackpixel.com/blog/2012/05/caching-and-nsurlconnection.html here
	//operation setCacheResponseBlock:
    [lastFmApiClient enqueueHTTPRequestOperation:operation];
	return operation;
}

/// DO NOT modify the operation returned, very possible race-condition, see https://github.com/AFNetworking/AFNetworking/wiki/AFNetworking-FAQ#why-dont-afhttpclients--getpath-et-al-return-the-operation-instead-of-void
- (AFHTTPRequestOperation *)postPath:(NSString *)path
						  parameters:(NSDictionary *)parameters
							 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
							 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
	// using the decomposed convenience method from the AFHTTPClient
	NSURLRequest *request = [lastFmApiClient requestWithMethod:@"POST" path:path parameters:parameters];
	AFHTTPRequestOperation *operation = [lastFmApiClient HTTPRequestOperationWithRequest:request success:success failure:failure];
	// AFHTTPRequestOperation's superclass AFURLConnectionOperation is the NSURLConnectionDelegate.
	// For all the delegate methods it provides a block property which gets called if set.
	// You would do something like http://blackpixel.com/blog/2012/05/caching-and-nsurlconnection.html here
	//operation setCacheResponseBlock:
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
		
		// Enable cache
		SDURLCache *URLCache = [[SDURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:24 * 1024 * 1024 diskPath:[SDURLCache defaultCachePath]];
		/*
		NSURLCache *URLCache = [[NSURLCache alloc] init];
		[URLCache setMemoryCapacity:8 * 1024 * 1024];
		[URLCache setDiskCapacity:24 * 1024 * 1024];
		*/
		[NSURLCache setSharedURLCache:URLCache];
		NSLog(@"Cache is being logged to: %@", [SDURLCache defaultCachePath]);
	}
	return self;
}

@end
