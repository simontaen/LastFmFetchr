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

@interface LastFmFetchr : NSObject

@property (nonatomic, strong) NSString *apiKey;


# pragma mark - Singleton Methods

/**
 * Initializes and returns a new LastFmFetchr singleton object
 *
 * @return A new singleton object
 */

+ (id)sharedManager;

#pragma mark - API calls

/// Artist methods
- (NSOperation *)getInfoForArtist:(NSString *)artist
						  success:(void (^)(id JSON))success
						  failure:(void (^)(NSError *error, id response))failure;


#pragma mark - Requests Management

/**
 * Cancels all requests that are currently being executed
 */
- (void)cancelAllRequests;


@end
