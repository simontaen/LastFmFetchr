//
//  LFMData.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFMArtist.h"

// http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns

static NSString *const kEmpty = @"";

@interface LFMData : NSObject

@property (nonatomic, strong, readonly) NSDictionary *JSON;

#pragma mark - LFMArtistInfo
//http://www.last.fm/api/show/artist.getInfo

/// NSArray of NSDictionaries @{ name : NSString, yearfrom : NSDate, yearto : yearto }
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
@property (nonatomic, readonly) BOOL isOnTour;
/// NSArray of NSDictionaries of similar artists
@property (nonatomic, strong, readonly) NSArray *similarArtists;
@property (nonatomic, readonly) BOOL isStreamable;
/// (ordered) Array of LFMTag
@property (nonatomic, strong, readonly) NSArray *tags;

#pragma mark - LFMArtistsTopAlbums
//http://www.last.fm/api/show/artist.getTopAlbums

@property (nonatomic, strong, readonly) NSString *artistName;
///	of LFMAlbumTopAlbum's
@property (nonatomic, strong, readonly) NSArray *albums;

#pragma mark - LFMAlbum

@property (nonatomic, strong, readonly) NSString *musicBrianzId;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSNumber *playcount;
@property (nonatomic, strong, readonly) NSURL *lfmPage;

#pragma mark - LFMAlbumInfoSub
//http://www.last.fm/api/show/album.getInfo

@property (nonatomic, strong, readonly) NSNumber *lfmId;
@property (nonatomic, strong, readonly) NSNumber *listeners;
@property (nonatomic, strong, readonly) NSDate *releaseDate;
/// (ordered) Array of LFMTag
@property (nonatomic, strong, readonly) NSArray *topTags;
/// (ordered) Array of LFMTracks
@property (nonatomic, strong, readonly) NSArray *tracks;
@property (nonatomic, strong, readonly) NSString *wikiContent;
@property (nonatomic, strong, readonly) NSDate *wikiPublishedDate;
@property (nonatomic, strong, readonly) NSString *wikiSummary;

#pragma mark - LFMTrack

@property (nonatomic, strong, readonly) NSNumber *rank;
//@property (nonatomic, strong, readonly) LFMArtist *artist;
@property (nonatomic, strong, readonly) NSNumber *duration;
@property (nonatomic, readonly) BOOL isTrackStreamable;

#pragma mark - Mapping Helpers

- (BOOL)boolFromString:(NSString *)boolString;
- (NSArray *)tagsFromDictionary:(id)obj;
- (NSArray *)tracksFromArray:(id)obj;
- (NSNumber *)longLongNumberForKeyPath:(NSString *)key;

#pragma mark - Access to JSON

- (NSString *)notNilStringForKeyPath:(NSString *)keyPath;

#pragma mark - Lifecycle

- (instancetype)initWithJson:(NSDictionary *)JSON;

@end
