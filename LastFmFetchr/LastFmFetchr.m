//
//  LastFmFetchr.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LastFmFetchr.h"
#import "LFMData.h"
#import "AFNetworking.h"
#import "LFMJSONResponseSerializerWithCleanup.h"
#import "LFMJSONRequestSerializer.h"
//#import "SDURLCache.h"

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
NSString *const kLFMMethodArtistGetCorrection = @"artist.getCorrection";
NSString *const kLFMMethodArtistGetInfo = @"artist.getInfo";
NSString *const kLFMMethodArtistGetTopAlbums = @"artist.getTopAlbums";
NSString *const kLFMMethodAlbumGetInfo = @"album.getInfo";


@implementation LastFmFetchr

// The static fetchr object
static LastFmFetchr *_fetchr = nil;

#pragma mark - API calls

#pragma mark - Artist methods
- (NSURLSessionDataTask *)getCorrectionForArtist:(NSString *)artist
									  completion:(void (^)(LFMArtist *data, NSError *error))completion;
{
	NSParameterAssert([artist length]);
	
	// perpare the params
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	// add the Last.fm method
	params[kLFMParameterMethod] = kLFMMethodArtistGetCorrection;
	// add user params
	if ([artist length]) {
		params[kLFMParameterArtist] = artist;
	}
	
#ifndef NDEBUG
	NSLog(@"LastFmFetchr: Request %@ (%@)", kLFMMethodArtistGetCorrection, artist);
#endif
	
	NSURLSessionDataTask *task = [self taskWithParams:params method:kLFMMethodArtistGetCorrection completion:completion];
	[task resume];
	return task;
}

- (NSURLSessionDataTask *)getInfoForArtist:(NSString *)artist
									  mbid:(NSString *)mbid
								completion:(void (^)(LFMArtistInfo *data, NSError *error))completion
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
	
	NSURLSessionDataTask *task = [self taskWithParams:params method:kLFMMethodArtistGetInfo completion:completion];
	[task resume];
	return task;
}

- (NSURLSessionDataTask *)getAllAlbumsByArtist:(NSString *)artist
										  mbid:(NSString *)mbid
									completion:(void (^)(LFMArtistsTopAlbums* data, NSError *error))completion
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
	
	NSURLSessionDataTask *task = [self taskWithParams:params method:kLFMMethodArtistGetTopAlbums completion:completion];
	[task resume];
	return task;
}

#pragma mark - Album methods
- (NSURLSessionDataTask *)getInfoForAlbum:(NSString *)album
								 byArtist:(NSString *)artist
									 mbid:(NSString *)mbid
							   completion:(void (^)(LFMAlbumInfo *data, NSError *error))completion
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
	
	NSURLSessionDataTask *task = [self taskWithParams:params method:kLFMMethodAlbumGetInfo completion:completion];
	[task resume];
	return task;
}

# pragma mark - AFNetworking handlers

- (NSURLSessionDataTask *)taskWithParams:(NSDictionary *)params
								  method:(NSString *)method
							  completion:(void (^)(id data, NSError *error))completion
{
	NSURLSessionDataTask *task = [self GET:@""
								parameters:params
								   success:^(NSURLSessionDataTask *task, id JSON) {
									   [self handleRequestSuccess:JSON
															 task:task
												 methodParamValue:method
														  success:^(NSDictionary *data) {
															  // TODO: handle error
															  LFMData *lfmData = [MTLJSONAdapter modelOfClass:LFMData.class fromJSONDictionary:data error:nil];
															  dispatch_async(dispatch_get_main_queue(), ^{
																  completion(lfmData, nil);
															  });
														  }
														  failure:^(NSError *error) {
															  dispatch_async(dispatch_get_main_queue(), ^{
																  completion(nil, error);
															  });
														  }];
								   }
								   failure:^(NSURLSessionDataTask *task, NSError *error) {
									   [self handleRequestFailure:error
															 task:task
														  failure:^(NSError *error) {
															  dispatch_async(dispatch_get_main_queue(), ^{
																  completion(nil, error);
															  });
														  }];
								   }];
	return task;
}

/**
 *  Called when the session task calls its success callback (request comes back successfully). Does very
 *  basic error handling to make sure the the actual success callback only gets called when there is content.
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
					 success:(void (^)(NSDictionary *data))success
					 failure:(void (^)(NSError *error))failure
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
				failure(error);
			} else {
				// DEBUG: NSLog(@"JSON Response was: %@", JSON);
				
				// now we are actually fine
				success((NSDictionary *)(JSON));
			}
			
		} else {
			// API behaves weird, I don't even know what is going on now.
			NSString *errorDesc = [NSString stringWithFormat:@"Invalid service response, HTTP %ld", (long)httpResponse.statusCode];
			NSError *error = [[NSError alloc] initWithDomain:kLFMSericeErrorDomain
														code:0
													userInfo:@{ NSLocalizedDescriptionKey : errorDesc, kLFMParameterMethod : methodParamValue}];
			failure(error);
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
					 failure:(void (^)(NSError *error))failure
{
	// This probably needs more work, but we will figure it out on the go
	if ([task state] != NSURLSessionTaskStateCanceling) failure(error);
	// If the task is canceling, I assume you don't even care about the request anymore
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


# pragma mark - Static Methods

+(instancetype)fetchrWithApiKey:(NSString *)key //apiSecret:(NSString *)secret
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		// http://www.objc.io/issue-5/from-nsurlconnection-to-nsurlsession.html
		// http://nsscreencast.com/episodes/91-afnetworking-2-0
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"LastFmFetchr/0.0.1 (iOS) AFNetworking/2.0.x",
											@"Accept" : @"application/json"
											}];
        
		// NSURLCache does not cache LastFm responses as they do not signal proper caching headers
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024 diskCapacity:50 * 1024 * 1024 diskPath:nil];
		
		// http://nsscreencast.com/episodes/15-http-caching
		//SDURLCache *cache = [[SDURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024 diskCapacity:50 * 1024 * 1024 diskPath:[SDURLCache defaultCachePath]];
        [config setURLCache:cache];
        
        _fetchr = [[LastFmFetchr alloc] initWithBaseURL:[NSURL URLWithString:@"http://ws.audioscrobbler.com/2.0/"]
								   sessionConfiguration:config];
		
		// Request Serializer
		LFMJSONRequestSerializer *requestSerializer = [LFMJSONRequestSerializer serializer];
		requestSerializer.stringEncoding = NSUTF8StringEncoding; // http://www.last.fm/api/intro
		requestSerializer.HTTPAdditionalParameters = @{ @"format" : @"json", // http://www.last.fm/api/rest
														@"api_key" : key
														};
		_fetchr.requestSerializer = requestSerializer;
		
		// Response Serializer, use JSON API, cleanup Last.fm mess with @attr
		LFMJSONResponseSerializerWithCleanup *responseSerializer = [LFMJSONResponseSerializerWithCleanup serializer];
		responseSerializer.stringEncoding = NSUTF8StringEncoding;
        _fetchr.responseSerializer = responseSerializer;
		
	});
	return _fetchr;
}

+ (instancetype)fetchr
{
	return _fetchr;
}

@end
