//
//  LastFmFetchr.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

#import "LFMArtist.h"
#import "LFMArtistInfo.h"
#import "LFMArtistsTopAlbums.h"
#import "LFMMember.h"
#import "LFMAlbum.h"
#import "LFMAlbumInfo.h"
#import "LFMAlbumTopAlbum.h"
#import "LFMTrack.h"
#import "LFMTag.h"
#import "LFMTagInfo.h"
#import "LFMChartTopArtists.h"
#import "LFMArtistChart.h"

// ----------------------------------------------------------------------
// API Error codes, see http://www.last.fm/api/errorcodes
// ----------------------------------------------------------------------
extern NSString *const kLFMSericeErrorDomain;

typedef NS_ENUM(NSInteger, LFMServiceErrorCodes) {
	kLFMErrorInvalidService = 2,
	kLFMErrorInvalidMethod = 3,
	kLFMErrorAuthenticationFailed = 4,
	kLFMErrorInvalidFormat = 5,
	kLFMErrorInvalidParameters = 6,
	kLFMErrorInvalidResource = 7,
	kLFMErrorOperationFailed = 8,
	kLFMErrorInvalidSession = 9,
	kLFMErrorInvalidAPIKey = 10,
	kLFMErrorServiceOffline = 11,
	kLFMErrorSubscribersOnly = 12,
	kLFMErrorInvalidMethodSignature = 13,
	kLFMErrorUnauthorizedToken = 14,
	kLFMErrorStreamingUnavailable = 15,
	kLFMErrorTemporaryError = 16,
	kLFMErrorLoginRequired = 17,
	kLFMErrorTrialExpired = 18,
	kLFMErrorNotEnoughContent = 20,
	kLFMErrorNotEnoughMembers = 21,
	kLFMErrorNotEnoughFans = 22,
	kLFMErrorNotEnoughNeighbours = 23,
	kLFMErrorNoPeakRadio = 24,
	kLFMErrorRadioNotFound = 25,
	kLFMErrorAPIKeySuspended = 26,
	kLFMErrorDeprecated = 27,
	kLFMErrorRateLimitExceeded = 29
};


@interface LastFmFetchr : AFHTTPSessionManager

#pragma mark - Properties
//@property (strong, nonatomic) NSString *username;


#pragma mark - API calls
// every call guarantees to call the completion handler on the main thread

#pragma mark - Artist methods
- (NSURLSessionDataTask *)getInfoForArtist:(NSString *)artist
									  mbid:(NSString *)mbid
								completion:(void (^)(LFMArtistInfo *data, NSError *error))completion;

- (NSURLSessionDataTask *)getCorrectionForArtist:(NSString *)artist
									  completion:(void (^)(LFMArtist *data, NSError *error))completion;

// This will just get the first 50 currently
// You COULD accept explicit success handlers that return NSDictionary subclasses
// that only allow valid methods on the returned object.
// The keys could be reused behind the scences and the curious ones could still use them
- (NSURLSessionDataTask *)getAllAlbumsByArtist:(NSString *)artist
										  mbid:(NSString *)mbid
									completion:(void (^)(LFMArtistsTopAlbums *data, NSError *error))completion;

#pragma mark - Album methods
- (NSURLSessionDataTask *)getInfoForAlbum:(NSString *)album
								 byArtist:(NSString *)artist
									 mbid:(NSString *)mbid
							   completion:(void (^)(LFMAlbumInfo *data, NSError *error))completion;

#pragma mark - Chart methods
- (NSURLSessionDataTask *)getChartsTopArtists:(NSString *)page
									withLimit:(NSUInteger)limit
								   completion:(void (^)(LFMChartTopArtists *data, NSError *error))completion;

#pragma mark - Requests Management

/// Cancels all tasks that are currently run
- (void)cancelAllTasks;

#pragma mark - Static Methods

/**
 *  Initializes the LastFmFetchr called fetchr and sets the api_key.
 *  If api_key is set, it will be sent with each request.
 *
 *  @param key The api_key for the LastFm API
 *
 *  @return The LastFmFetchr
 */
+(instancetype)fetchrWithApiKey:(NSString *)key; //apiSecret:(NSString *)secret

/// @return The LastFmFetchr
+ (instancetype)fetchr;

@end
