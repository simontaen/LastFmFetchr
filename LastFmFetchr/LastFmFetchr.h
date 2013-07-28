//
//  LastFmFetchr.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>

// ------------ Keys to the JSON response from Last.fm ------------------
// By convention you need to use valueForKey: if the constant name contains an underbar '_'

// artist.getInfo
extern NSString *const kLFMArtist_Members;
//extern NSString *const kLFMArtistBio;
extern NSString *const kLFMArtistBio_Content;
extern NSString *const kLFMArtistBio_FormationYears;
extern NSString *const kLFMArtistBio_Link;
extern NSString *const kLFMArtistBio_PlaceFormed;
extern NSString *const kLFMArtistBio_Published;
extern NSString *const kLFMArtistBio_Summary;
extern NSString *const kLFMArtistBio_YearFormed;
extern NSString *const kLFMArtistImageList;
extern NSString *const kLFMArtistMusicBrianzId;
extern NSString *const kLFMArtistName;
extern NSString *const kLFMArtistIsOnTour;
extern NSString *const kLFMArtist_SimilarArtists;
extern NSString *const kLFMArtistStats_Listeners;
extern NSString *const kLFMArtistStats_Playcount;
extern NSString *const kLFMArtistStreamable;
extern NSString *const kLFMArtist_Tags;
extern NSString *const kLFMArtistLastFmPageURL;


// ------------ API Error codes, see http://www.last.fm/api/errorcodes ------------------

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


@interface LastFmFetchr : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *apiSecret;


#pragma mark - API calls

// Be aware of https://github.com/AFNetworking/AFNetworking/issues/405
// ONLY use the returned operation for cancelling reasons
// DO NOT try to modify it or else you'll run into a race condition
// https://github.com/AFNetworking/AFNetworking/wiki/AFNetworking-FAQ#why-dont-afhttpclients--getpath-et-al-return-the-operation-instead-of-void
// IF you cancel an operation, the CALLBACK WILL NOT FIRE, the response will be ignored in any case!


/// Artist methods
- (NSOperation *)getInfoForArtist:(NSString *)artist
									 success:(void (^)(NSDictionary *JSON))success
									 failure:(void (^)(NSOperation *operation, NSError *error))failure;

#pragma mark - Requests Management

/// Cancels all requests that are currently queued or being executed
- (void)cancelAllRequests;

#pragma mark - Error Handling

/// Returns a string with the JSON error message, if given, or the appropriate localized description for the NSError object
- (NSString *)messageForError:(NSError *)error withOperation:(id)response;

# pragma mark - Singleton Methods

/// Initializes and returns a new LastFmFetchr singleton object
/// @return A new singleton object
+ (instancetype)sharedManager;

@end
