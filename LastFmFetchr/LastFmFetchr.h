//
//  LastFmFetchr.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

#import "LFMArtistInfo.h"
#import "LFMArtistsTopAlbums.h"
#import "LFMAlbum.h"
#import "LFMAlbumInfo.h"
#import "LFMAlbumTopAlbum.h"

// By convention you need to use valueForKey: if the constant name contains an underbar '_'

// ----------------------------------------------------------------------
// ARTIST keys to JSON responses from Last.fm 
// ----------------------------------------------------------------------
extern NSString *const kLFMArtist_Members;
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


// ----------------------------------------------------------------------
// ALBUM keys to JSON responses from Last.fm 
// ----------------------------------------------------------------------
extern NSString *const kLFMAlbumArtistName;
extern NSString *const kLFMAlbumId;
extern NSString *const kLFMAlbumImageList;
extern NSString *const kLFMAlbumListeners;
extern NSString *const kLFMAlbumMusicBrianzId;
extern NSString *const kLFMAlbumName;
extern NSString *const kLFMAlbumPlaycount;
extern NSString *const kLFMAlbumReleasedate;
extern NSString *const kLFMAlbum_Toptags;
extern NSString *const kLFMAlbum_Tracks;
extern NSString *const kLFMAlbumLastFmPageURL;
extern NSString *const kLFMAlbumWiki_Content;
extern NSString *const kLFMAlbumWiki_Published;
extern NSString *const kLFMAlbumWiki_Summary;
extern NSString *const kLFMAlbum_ArtistsAlbumList;
extern NSString *const kLFMAlbum_RankInAllArtistAlbums;
extern NSString *const kLFMAlbumArtist_MusicBrianzId;
extern NSString *const kLFMAlbumArtist_Name;
extern NSString *const kLFMAlbumArtist_LastFmPageURL;


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


// ----------------------------------------------------------------------
// Block handler typedefs
// ----------------------------------------------------------------------
// TODO: Who cares about the task in a failure case? Won't one completion handler just suffice?
// the caller actually gets it returned AND I can return it in both success and failure case, definitly refactor!
// Much simpler only having one!
// Also see: http://nsscreencast.com/episodes/91-afnetworking-2-0
typedef void (^LastFmFetchrAPIFailure)(NSURLSessionDataTask *task, NSError *error);


@interface LastFmFetchr : AFHTTPSessionManager

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *apiSecret;


#pragma mark - API calls

#pragma mark - Artist methods
- (NSURLSessionDataTask *)getInfoForArtist:(NSString *)artist
									  mbid:(NSString *)mbid
								   success:(void (^)(LFMArtistInfo *data))success
								   failure:(LastFmFetchrAPIFailure)failure;

// This will just get the first 50 currently
// You COULD accept explicit success handlers that return NSDictionary subclasses
// that only allow valid methods on the returned object.
// The keys could be reused behind the scences and the curious ones could still use them
- (NSURLSessionDataTask *)getAllAlbumsByArtist:(NSString *)artist
										  mbid:(NSString *)mbid
									   success:(void (^)(LFMArtistsTopAlbums *data))success
									   failure:(LastFmFetchrAPIFailure)failure;

#pragma mark - Album methods
- (NSURLSessionDataTask *)getInfoForAlbum:(NSString *)album
								 byArtist:(NSString *)artist
									 mbid:(NSString *)mbid
								  success:(void (^)(LFMAlbumInfo *data))success
								  failure:(LastFmFetchrAPIFailure)failure;

#pragma mark - Requests Management

/// Cancels all tasks that are currently run
- (void)cancelAllTasks;

#pragma mark - Error Handling

/// Returns a string with the JSON error message, if given, or the appropriate localized description for the NSError object
- (NSString *)messageForError:(NSError *)error withTask:(NSURLSessionDataTask *)task;

#pragma mark - Singleton Methods

/// Initializes and returns the LastFmFetchr singleton object
/// @return The singleton object
+ (instancetype)fetchr;

@end
