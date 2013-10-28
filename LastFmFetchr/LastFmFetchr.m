//
//  LastFmFetchr.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LastFmFetchr.h"
#import "AFNetworking.h"

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
	// TODO: probably not needed
	NSUserDefaults *userDefaults;
	// TODO: probably not needed
	dispatch_queue_t async_queue;
}
@end

@implementation LastFmFetchr

#pragma mark - API calls

#pragma mark - Artist methods
- (NSURLSessionDataTask *)getInfoForArtist:(NSString *)artist
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
	
	NSURLSessionDataTask *task = [self GET:@""
								parameters:[self addDefaultParameters:params]
								   success:^(NSURLSessionDataTask *task, id JSON) {
									   [self handleRequestSuccess:JSON
															 task:task
												 methodParamValue:kLFMMethodArtistGetInfo
												   jsonContentKey:kLFMParameterArtist
														  success:^(NSDictionary *data) {
															  success([[LFMArtistGetInfo alloc] initWithJson:data]);
														  }
														  failure:failure];
								   }
								   failure:^(NSURLSessionDataTask *task, NSError *error) {
									   [self handleRequestFailure:error
															 task:task
														  failure:failure];
								   }];
	[task resume];
	return task;
}

- (NSURLSessionDataTask *)getAllAlbumsByArtist:(NSString *)artist
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
	
	NSURLSessionDataTask *task = [self GET:@""
								parameters:[self addDefaultParameters:params]
								   success:^(NSURLSessionDataTask *task, id JSON) {
									   [self handleRequestSuccess:JSON
															 task:task
												 methodParamValue:kLFMMethodArtistGetTopAlbums
												   jsonContentKey:@"topalbums"
														  success:^(NSDictionary *data) {
															  success([[LFMArtistGetTopAlbums alloc] initWithJson:data]);
														  }
														  failure:failure];
								   }
								   failure:^(NSURLSessionDataTask *task, NSError *error) {
									   [self handleRequestFailure:error
															 task:task
														  failure:failure];
								   }];
	[task resume];
	return task;
}

#pragma mark - Album methods
- (NSURLSessionDataTask *)getInfoForAlbum:(NSString *)album
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
	
	NSURLSessionDataTask *task = [self GET:@""
								parameters:[self addDefaultParameters:params]
								   success:^(NSURLSessionDataTask *task, id JSON) {
									   [self handleRequestSuccess:JSON
															 task:task
												 methodParamValue:kLFMMethodAlbumGetInfo
												   jsonContentKey:kLFMParameterAlbum
														  success:^(NSDictionary *data) {
															  success([[LFMAlbumGetInfo alloc] initWithJson:data]);
														  }
														  failure:failure];
								   }
								   failure:^(NSURLSessionDataTask *task, NSError *error) {
									   [self handleRequestFailure:error
															 task:task
														  failure:failure];
								   }];
	[task resume];
	return task;
}

# pragma mark - AFNetworking handlers

/**
 *  Called when the session task calls its success callback (request comes back successfully). Does very
 *  basic error handling to make sure the the actual success callback only gets called when there is content.
 *  TODO: you might be able to fetch the methodParamValue from the task
 *
 *  @param JSON             the pure JSON coming from the API
 *  @param task             the task executing the request
 *  @param methodParamValue the method that was called on the API
 *  @param success          the success callback to call
 *  @param failure          the failure callback to call
 */
- (void)handleRequestSuccess:(id)JSON
						task:(NSURLSessionDataTask *)task
			methodParamValue:(NSString *)methodParamValue
			  jsonContentKey:(NSString *)jsonContentKey
					 success:(void (^)(NSDictionary *data))success
					 failure:(LastFmFetchrAPIFailure)failure
{
	if ([task state] != NSURLSessionTaskStateCanceling) {
		
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
		
		if ([JSON isKindOfClass:[NSDictionary class]] && httpResponse.statusCode == 200) {
			// So far so good
			if (JSON[kLFMSericeErrorCode]) {
				// still an error
				NSError *error = [[NSError alloc] initWithDomain:kLFMSericeErrorDomain
															code:[JSON[kLFMSericeErrorCode] intValue]
														userInfo:@{ NSLocalizedDescriptionKey : JSON[kLFMSericeErrorMessage], kLFMParameterMethod : methodParamValue}];
				failure(task, error);
			} else {
				// DEBUG: NSLog(@"JSON Response was: %@", JSON);
				
				// now we are actually fine
				if (jsonContentKey) {
					success((NSDictionary *)(JSON[jsonContentKey]));
				} else {
					success((NSDictionary *)(JSON));
				}
			}
			
		} else {
			// API behaves weird, I don't even know what is going on now.
			NSString *errorDesc = [NSString stringWithFormat:@"Invalid service response, HTTP %d", httpResponse.statusCode];
			NSError *error = [[NSError alloc] initWithDomain:kLFMSericeErrorDomain
														code:0
													userInfo:@{ NSLocalizedDescriptionKey : errorDesc, kLFMParameterMethod : methodParamValue}];
			failure(task, error);
		}
	}
	// If the task is canceling, I assume you don't even care about the request anymore
}

/**
 *  Called when the session task calls its failure callback (request comes back with a failure).
 *
 *  @param error   the error coming from the API
 *  @param task    the task executing the request
 *  @param failure the failure callback to call
 */
- (void)handleRequestFailure:(NSError *)error
						task:(NSURLSessionDataTask *)task
					 failure:(LastFmFetchrAPIFailure)failure
{
	// TODO: This probably needs more work, or might even be obsolete
	if ([task state] != NSURLSessionTaskStateCanceling) failure(task, error);
	// If the task is canceling, I assume you don't even care about the request anymore
}

#pragma mark - Error Handling

/// Returns a string with the JSON error message, if given, or the appropriate localized description for the NSError object
- (NSString *)messageForError:(NSError *)error withTask:(NSURLSessionDataTask *)task
{
	NSString *errorMsg = @"";
	NSURLResponse *response = task.response;
	if ([response isKindOfClass:[NSURLResponse class]]) {
		int statusCode = ((NSHTTPURLResponse *)response).statusCode;
		errorMsg = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
		errorMsg = [errorMsg stringByAppendingFormat:@" (code %d). ", statusCode];
	}

	// TODO: this probably won't work correctly
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

/**
 *  Cancels all tasks that are currently run
 */
- (void)cancelAllTasks
{
	for (NSURLSessionTask *task in self.tasks) {
		[task cancel];
	}
}

/**
 *  Add default request parameters
 *
 *  @param parameters given parameters
 *
 *  @return given parameters plus "format" and "api_key"
 */
- (NSDictionary *)addDefaultParameters:(NSMutableDictionary *)parameters
{
	
	// TODO: This can be refactored! DO NOT NEED!
	
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

/**
 *  Check for an empty API key
 */
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

+ (instancetype)fetchr
{
	static LastFmFetchr *_fetchr = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"LastFmFetchr/0.0.1 (iOS) AFNetworking/2.0.x"}];
		// Accept HTTP Header? @{ @"Accept" : @"application/json"}
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        [config setURLCache:cache];
        
        _fetchr = [[LastFmFetchr alloc] initWithBaseURL:[NSURL URLWithString:@"http://ws.audioscrobbler.com/2.0/"]
								   sessionConfiguration:config];
		
		// Request Serializer
		// http://www.last.fm/api/intro
		// http://www.last.fm/api/rest
		AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
		requestSerializer.stringEncoding = NSUTF8StringEncoding;
		_fetchr.requestSerializer = requestSerializer;
		
		// Use JSON API
		AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
		responseSerializer.stringEncoding = NSUTF8StringEncoding;
        _fetchr.responseSerializer = responseSerializer;
		
	});
	return _fetchr;
}

@end
