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

// API Error codes

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
	kLFMErrorInvalidAPISignature = 13,
	kLFMErrorTemporaryError = 16,
	kLFMErrorSuspendedAPIKey = 26,
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

/// Artist methods
- (void)getInfoForArtist:(NSString *)artist
						  success:(void (^)(id JSON))success
						  failure:(void (^)(id response, NSError *error))failure;


#pragma mark - Requests Management

/// Cancels all artists.getInfo requests that are currently queued or being executed
- (void)cancelAllArtistsGetInfoRequests;

#pragma mark - Error Handling

/// Returns a string with the JSON error message, if given, or the appropriate localized description for the NSError object
- (NSString *)messageForError:(NSError *)error withResponse:(id)response;

@end
