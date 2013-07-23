//
//  LastFmFetchr.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>

// Artist Info keys
extern NSString *const kLFMArtistBio;
extern NSString *const kLFMArtistSummary;
extern NSString *const kLFMArtistName;
extern NSString *const kLFMArtistLastFmPageURL;
extern NSString *const kLFMArtistImageLarge;
extern NSString *const kLFMArtistListeners;
extern NSString *const kLFMArtistPlaycount;
extern NSString *const kLFMArtistTags;
extern NSString *const kLFMArtistIsOnTour;

// API Error codes, see http://www.last.fm/api/errorcodes

enum LFMServiceErrorCodes {
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


@interface LastFmFetchr : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *apiSecret;


# pragma mark - Singleton Methods

/**
 * Initializes and returns a new LastFmFetchr singleton object
 *
 * @return A new singleton object
 */

+ (id)sharedManager;

#pragma mark - API calls

// Be aware of https://github.com/AFNetworking/AFNetworking/issues/405
// ONLY use the returned operation for cancelling reasons
// DO NOT try to modify it or else you'll run into a race condition
// https://github.com/AFNetworking/AFNetworking/wiki/AFNetworking-FAQ#why-dont-afhttpclients--getpath-et-al-return-the-operation-instead-of-void

/// Artist methods
- (NSOperation *)getInfoForArtist:(NSString *)artist
									 success:(void (^)(id JSON))success
									 failure:(void (^)(id response, NSError *error))failure;


#pragma mark - Requests Management

/// Cancels all requests that are currently queued or being executed
- (void)cancelAllRequests;

#pragma mark - Error Handling

/// Returns a string with the JSON error message, if given, or the appropriate localized description for the NSError object
- (NSString *)messageForError:(NSError *)error withResponse:(id)response;

@end
