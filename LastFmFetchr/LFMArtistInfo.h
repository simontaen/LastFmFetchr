//
//  LFMArtistInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFMArtist.h"

@protocol LFMArtistInfo <NSObject, LFMArtist>

// TODO: Images S to Mega
/// NSArray of NSDictionaries @{ name : NSString, yearfrom : NSDate, yearto : yearto }
- (NSArray *)members;
- (NSString *)bioContent;
/**
 *  NSArray of NSDates, [1] = year from, [2] = year to (if available).
 *  Returns an empty array if neither are defined.
 */
- (NSArray *)bioFormationYears;
- (NSURL *)lfmWikiPage;
- (NSString *)bioPlaceFormed;
- (NSDate *)bioPublishedDate;
- (NSString *)bioSummary;
- (NSDate *)bioYearFormedDate;
- (BOOL)isOnTour;
/// NSArray of NSDictionaries of similar artists
- (NSArray *)similarArtists;
- (NSNumber *)listeners;
- (NSNumber *)playcount;
- (BOOL)isStreamable;
/// (ordered) Array of LFMTag
- (NSArray *)tags;

@end
