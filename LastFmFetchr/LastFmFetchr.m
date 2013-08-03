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

// By convention you need to use valueForKey: if the constant name contains an underbar '_'

// ----------------------------------------------------------------------
// ARTIST keys to JSON responses from Last.fm
// ----------------------------------------------------------------------
NSString *const kLFMArtist_Members = @"bandmembers.member";
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


// ----------------------------------------------------------------------
// ALBUM keys to JSON responses from Last.fm
// ----------------------------------------------------------------------
NSString *const kLFMAlbumArtistName = @"artist";
NSString *const kLFMAlbumId = @"id";
NSString *const kLFMAlbumImageList = @"image";
NSString *const kLFMAlbumListeners = @"listeners";
NSString *const kLFMAlbumMusicBrianzId = @"mbid";
NSString *const kLFMAlbumName = @"name";
NSString *const kLFMAlbumPlaycount = @"playcount";
NSString *const kLFMAlbumReleasedate = @"releasedate";
NSString *const kLFMAlbum_Toptags = @"toptags.tag";
NSString *const kLFMAlbum_Tracks = @"tracks.track";
NSString *const kLFMAlbumLastFmPageURL = @"url";
NSString *const kLFMAlbumWiki_Content = @"wiki.content";
NSString *const kLFMAlbumWiki_Published = @"wiki.published";
NSString *const kLFMAlbumWiki_Summary = @"wiki.summary";
NSString *const kLFMAlbum_ArtistsAlbumList = @"album";
NSString *const kLFMAlbum_RankInAllArtistAlbums = @"@attr.rank";
NSString *const kLFMAlbumArtist_MusicBrianzId = @"artist.mbid";
NSString *const kLFMAlbumArtist_Name = @"@attr.artist";
NSString *const kLFMAlbumArtist_LastFmPageURL = @"artist.url";


// ----------------------------------------------------------------------
// API Error codes, see http://www.last.fm/api/errorcodes
// ----------------------------------------------------------------------
NSString *const kLFMSericeErrorDomain = @"com.lastfmfetchr.service.errors";

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
// PRIVATE CONSTANTS
// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

// Keys to JSON error response to Last.fm
NSString *const kLFMSericeErrorCode = @"error";
NSString *const kLFMSericeErrorMessage = @"message";

// Base URL to the API
NSString *const kLFMBaseURLString = @"http://ws.audioscrobbler.com/2.0";

// Last.fm API parameters
NSString *const kLFMParameterMethod = @"method";
NSString *const kLFMParameterMbid = @"mbid";
NSString *const kLFMParameterArtist = @"artist";
NSString *const kLFMParameterAlbum = @"album";

// Last.fm API method parameter values
// Each of these have a separate Method and a NSDictionary Subclass
NSString *const kLFMMethodArtistGetInfo = @"artist.getInfo";
NSString *const kLFMMethodArtistGetTopAlbums = @"artist.getTopAlbums";
NSString *const kLFMMethodAlbumGetInfo = @"album.getInfo";


@interface LastFmFetchr ()
{
	// The client to talk the Last.fm
	AFLastFmAPIClient *lastFmApiClient;
	// probably not needed
	NSUserDefaults *userDefaults;
	// probably not needed
	dispatch_queue_t async_queue;
}
@end

@implementation LastFmFetchr

#pragma mark - API calls

#pragma mark - Artist methods
- (NSOperation *)getInfoForArtist:(NSString *)artist
							 mbid:(NSString *)mbid
						  success:(void (^)(LFMArtistGetInfo *data))success
						  failure:(LastFmFetchrAPIFailure)failure
{
	NSParameterAssert([artist length] || [mbid length]);
	
	// perpare the params
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	// add the Last.fm method
	params[kLFMParameterMethod] = kLFMMethodArtistGetInfo;
	// add user params
	if ([artist length]) {
		params[kLFMParameterArtist] = artist;
	}
	if ([mbid length]) {
		params[kLFMParameterMbid] = mbid;
	}
	
#ifndef NDEBUG
	NSLog(@"LastFmFetchr: Request %@ (%@)", kLFMMethodArtistGetInfo, artist);
#endif
	
	return [self getPath:@""
			  parameters:[self addDefaultParameters:params]
				 success:^(AFHTTPRequestOperation *operation, id JSON) {
					 [self handleAFNetworkingSuccess:JSON
										   operation:operation
									methodParamValue:kLFMMethodArtistGetInfo
									  jsonContentKey:kLFMParameterArtist
											 success:^(NSDictionary *data) {
												 success([[LFMArtistGetInfo alloc] initWithJson:data]);
											 }
											 failure:failure];
				 }
				 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					 [self handleAFNetworkingFailure:error
										   operation:operation
											 failure:failure];
				 }];
}

- (NSOperation *)getAllAlbumsByArtist:(NSString *)artist
								 mbid:(NSString *)mbid
							  success:(void (^)(LFMArtistGetTopAlbums *data))success
							  failure:(LastFmFetchrAPIFailure)failure
{
	NSParameterAssert([artist length] || [mbid length]);
	
	// perpare the params
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	// add the Last.fm method
	params[kLFMParameterMethod] = kLFMMethodArtistGetTopAlbums;
	// add user params
	if ([artist length]) {
		params[kLFMParameterArtist] = artist;
	}
	if ([mbid length]) {
		params[kLFMParameterMbid] = mbid;
	}
	
#ifndef NDEBUG
	NSLog(@"LastFmFetchr: Request %@ (%@)", kLFMMethodArtistGetTopAlbums, artist);
#endif
	
	return [self getPath:@""
			  parameters:[self addDefaultParameters:params]
				 success:^(AFHTTPRequestOperation *operation, id JSON) {
					 [self handleAFNetworkingSuccess:JSON
										   operation:operation
									methodParamValue:kLFMMethodArtistGetTopAlbums
									  jsonContentKey:@"topalbums"
											 success:^(NSDictionary *data) {
												 success([[LFMArtistGetTopAlbums alloc] initWithJson:data]);
											 }
											 failure:failure];
				 }
				 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					 [self handleAFNetworkingFailure:error
										   operation:operation
											 failure:failure];
				 }];
}

#pragma mark - Album methods
- (NSOperation *)getInfoForAlbum:(NSString *)album
						byArtist:(NSString *)artist
							mbid:(NSString *)mbid
						 success:(void (^)(LFMAlbumGetInfo *data))success
						 failure:(LastFmFetchrAPIFailure)failure;
{
	NSParameterAssert(([artist length] && [album length]) || [mbid length]);
	
	// perpare the params
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	// add the Last.fm method
	params[kLFMParameterMethod] = kLFMMethodAlbumGetInfo;
	// add user params
	if ([album length]) {
		params[kLFMParameterAlbum] = album;
	}
	if ([artist length]) {
		params[kLFMParameterArtist] = artist;
	}
	if ([mbid length]) {
		params[kLFMParameterMbid] = mbid;
	}
	
#ifndef NDEBUG
	NSLog(@"LastFmFetchr: Request %@ (%@:%@)", kLFMMethodAlbumGetInfo, artist, album);
#endif
	
	return [self getPath:@""
			  parameters:[self addDefaultParameters:params]
				 success:^(AFHTTPRequestOperation *operation, id JSON) {
					 [self handleAFNetworkingSuccess:JSON
										   operation:operation
									methodParamValue:kLFMMethodAlbumGetInfo
									  jsonContentKey:kLFMParameterAlbum
											 success:^(NSDictionary *data) {
												 success([[LFMAlbumGetInfo alloc] initWithJson:data]);
											 }
											 failure:failure];
				 }
				 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
					 [self handleAFNetworkingFailure:error
										   operation:operation
											 failure:failure];
				 }];
}

# pragma mark - AFNetworking handlers

/// called when AFNetworking comes back with a success
- (void)handleAFNetworkingSuccess:(id)JSON
						operation:(AFHTTPRequestOperation *)operation
				 methodParamValue:(NSString *)methodParamValue
				   jsonContentKey:(NSString *)jsonContentKey
						  success:(void (^)(NSDictionary *data))success
						  failure:(LastFmFetchrAPIFailure)failure
{
	if (!operation.isCancelled) {
		if ([JSON isKindOfClass:[NSDictionary class]]) {
			
			if (JSON[kLFMSericeErrorCode]) {
				NSError *error = [[NSError alloc] initWithDomain:kLFMSericeErrorDomain
															code:[JSON[kLFMSericeErrorCode] intValue]
														userInfo:@{ NSLocalizedDescriptionKey : JSON[kLFMSericeErrorMessage], kLFMParameterMethod : methodParamValue}];
				failure(operation, error);
			} else {
				if (jsonContentKey) {
					success((NSDictionary *)(JSON[jsonContentKey]));
				} else {
					success((NSDictionary *)(JSON));
				}
			}
			
		} else {
			NSError *error = [[NSError alloc] initWithDomain:kLFMSericeErrorDomain
														code:0
													userInfo:@{ NSLocalizedDescriptionKey : @"Invalid service response", kLFMParameterMethod : kLFMMethodArtistGetInfo}];
			failure(operation, error);
		}
	}
}

/// called when AFNetworking comes back with a failure
- (void)handleAFNetworkingFailure:(NSError *)error
						operation:(AFHTTPRequestOperation *)operation
						  failure:(LastFmFetchrAPIFailure)failure
{
	if (!operation.isCancelled) failure(operation, error);
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

#pragma mark - Requests Management

/// Cancels all requests that are currently queued or being executed
- (void)cancelAllRequests
{
	[lastFmApiClient cancelAllHTTPOperationsWithMethod:nil path:nil];
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
    AFHTTPRequestOperation *operation = [lastFmApiClient HTTPRequestOperationWithRequest:request success:success failure:failure];
	/*
	 actually is a registerHTTPOperationClass
	 AFHTTPRequestOperation's superclass AFURLConnectionOperation is the NSURLConnectionDelegate.
	 For all the delegate methods it provides a block property which gets called if set.
	 You would do something like http://blackpixel.com/blog/2012/05/caching-and-nsurlconnection.html here
	 operation setCacheResponseBlock:
	 */
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
	/*
	 actually is a registerHTTPOperationClass
	 AFHTTPRequestOperation's superclass AFURLConnectionOperation is the NSURLConnectionDelegate.
	 For all the delegate methods it provides a block property which gets called if set.
	 You would do something like http://blackpixel.com/blog/2012/05/caching-and-nsurlconnection.html here
	 operation setCacheResponseBlock:
	 */
    [lastFmApiClient enqueueHTTPRequestOperation:operation];
	return  operation;
}

/// add default request parameters (format, api_key)
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
		lastFmApiClient = [AFLastFmAPIClient sharedClient];
		
		// Enable cache
		SDURLCache *URLCache = [[SDURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:24 * 1024 * 1024 diskPath:[SDURLCache defaultCachePath]];
		//NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:24 * 1024 * 1024 diskPath:[SDURLCache defaultCachePath]];
		[NSURLCache setSharedURLCache:URLCache];
		NSLog(@"Cache is being logged to: %@", [SDURLCache defaultCachePath]);
		
	}
	return self;
}

@end
