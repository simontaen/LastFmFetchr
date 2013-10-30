//
//  LFMArtistGetInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"

@interface LFMArtistInfo : LFMData

/// NSArray of NSDictionaries @{ name : NSString, yearfrom : NSDate, yearto : yearto }
@property (nonatomic, strong) NSArray *members;
@property (nonatomic, strong) NSString *bioContent;
/// NSArray of NSDates, [1] = year from, [2] = year to
@property (nonatomic, strong) NSArray *bioFormationYears;
@property (nonatomic, strong) NSURL *lastFmWikiPage;
@property (nonatomic, strong) NSString *bioPlaceFormed;
@property (nonatomic, strong) NSDate *bioPublishedDate;
@property (nonatomic, strong) NSString *bioSummary;
@property (nonatomic, strong) NSDate *bioYearFormedDate;
@property (nonatomic, strong) NSURL *imageSmall;
@property (nonatomic, strong) NSURL *imageMedium;
@property (nonatomic, strong) NSURL *imageLarge;
@property (nonatomic, strong) NSURL *imageExtraLarge;
@property (nonatomic, strong) NSURL *imageMega;
@property (nonatomic, strong) NSString *musicBrianzId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) BOOL isOnTour;
/// NSArray of NSDictionaries of similar artists
@property (nonatomic, strong) NSArray *similarArtists;
@property (nonatomic, strong) NSNumber *listeners;
@property (nonatomic, strong) NSNumber *playcount;
@property (nonatomic) BOOL isStreamable;
/// (ordered) Array of Names as NSStrings
@property (nonatomic, strong) NSArray *tagNames;
/// (ordered) Array of Last.fm tag links as NSURLs
@property (nonatomic, strong) NSArray *tagURLs;
@property (nonatomic, strong) NSURL *lastFmPage;

@end
