//
//  LFMArtistGetInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtist.h"
#import "LFMData+ImagesSmallToXL.h"

@interface LFMArtistInfo : LFMArtist

/// NSArray of NSDictionaries @{ name : NSString, yearfrom : NSDate, yearto : yearto }
@property (nonatomic, strong, readonly) NSArray *members;
@property (nonatomic, strong, readonly) NSString *bioContent;
/// NSArray of NSDates, [1] = year from, [2] = year to
@property (nonatomic, strong, readonly) NSArray *bioFormationYears;
@property (nonatomic, strong, readonly) NSURL *lfmWikiPage;
@property (nonatomic, strong, readonly) NSString *bioPlaceFormed;
@property (nonatomic, strong, readonly) NSDate *bioPublishedDate;
@property (nonatomic, strong, readonly) NSString *bioSummary;
@property (nonatomic, strong, readonly) NSDate *bioYearFormedDate;
@property (nonatomic, strong, readonly) NSURL *imageMega;
@property (nonatomic, strong, readonly) NSString *musicBrianzId;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, readonly) BOOL isOnTour;
/// NSArray of NSDictionaries of similar artists
@property (nonatomic, strong, readonly) NSArray *similarArtists;
@property (nonatomic, strong, readonly) NSNumber *listeners;
@property (nonatomic, strong, readonly) NSNumber *playcount;
@property (nonatomic, readonly) BOOL isStreamable;
/// (ordered) Array of LFMTag
@property (nonatomic, strong, readonly) NSArray *tags;
@property (nonatomic, strong, readonly) NSURL *lfmPage;

@end
