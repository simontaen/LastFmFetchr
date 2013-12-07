//
//  LFMArtistInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtist.h"

@interface LFMArtistInfo : LFMArtist

/**
*  NSArray of NSDictionaries
*  @{ name : NSString, yearfrom : NSDate, yearto : yearto }
*/
@property (nonatomic, strong, readonly) NSArray *members;
@property (nonatomic, strong, readonly) NSString *bioContent;
/**
 *  NSArray of NSDates, [1] = year from, [2] = year to (if available).
 *  Returns an empty array if neither are defined.
 */
@property (nonatomic, strong, readonly) NSArray *bioFormationYears;
@property (nonatomic, strong, readonly) NSURL *lfmWikiPage;
@property (nonatomic, strong, readonly) NSString *bioPlaceFormed;
@property (nonatomic, strong, readonly) NSDate *bioPublishedDate;
@property (nonatomic, strong, readonly) NSString *bioSummary;
@property (nonatomic, strong, readonly) NSDate *bioYearFormedDate;
@property (nonatomic, strong, readonly) NSNumber *isOnTour;
/// NSArray of NSDictionaries of similar artists
@property (nonatomic, strong, readonly) NSArray *similarArtists;
@property (nonatomic, strong, readonly) NSNumber *listeners;
@property (nonatomic, strong, readonly) NSNumber *playcount;
@property (nonatomic, strong, readonly) NSNumber *isStreamable;
/// (ordered) Array of LFMTag
@property (nonatomic, strong, readonly) NSArray *tags;

@property (nonatomic, strong, readonly) NSURL *imageSmall;
@property (nonatomic, strong, readonly) NSURL *imageMedium;
@property (nonatomic, strong, readonly) NSURL *imageLarge;
@property (nonatomic, strong, readonly) NSURL *imageExtraLarge;
@property (nonatomic, strong, readonly) NSURL *imageMega;
@property (nonatomic, strong, readonly) NSString *imageSmallString;
@property (nonatomic, strong, readonly) NSString *imageMediumString;
@property (nonatomic, strong, readonly) NSString *imageLargeString;
@property (nonatomic, strong, readonly) NSString *imageExtraLargeString;
@property (nonatomic, strong, readonly) NSString *imageMegaString;

@end
