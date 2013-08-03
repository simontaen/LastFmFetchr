//
//  LFMArtistGetInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"

@interface LFMArtistGetInfo : LFMData

/// Never-nil NSString of members of the artist
- (NSString *)members;
/// NSArray of NSDictionaries @{ name : NSString, yearfrom : NSDate, yearto : yearto }
- (NSArray *)memberArray;
/// Never-nil NSString of the artists bio content
- (NSString *)bioContent;
/// Never-nil NSString of the artists formation years (yearfrom, yearto)
- (NSString *)bioFormationYears;
/// NSArray of NSDates, [1] = year from, [2] = year to
- (NSArray *)bioFormationYearDates;
/// Never-nil NSString of the artists last.fm wiki page
- (NSString *)bioLink;
/// NSURL to the artists last.fm wiki page
- (NSURL *)bioLinkURL;
/// Never-nil NSString of where the artist was formed
- (NSString *)bioPlaceFormed;
/// Never-nil NSString of when the artists bio was published
- (NSString *)bioPublished;
/// NSDate of when the artists bio was published
- (NSDate *)bioPublishedDate;
/// Never-nil NSString of the artists bio summary
- (NSString *)bioSummary;
/// Never-nil NSString of when the artist was formed
- (NSString *)bioYearFormed;
/// NSDate of when the artist was formed
- (NSDate *)bioYearFormedDate;
/// Never-nil NSString of the url
- (NSString *)imageSmall;
/// NSURL to the artists image size small
- (NSURL *)imageSmallURL;
/// Never-nil NSString of the url
- (NSString *)imageMedium;
/// NSURL to the artists image size medium
- (NSURL *)imageMediumURL;
/// Never-nil NSString of the url
- (NSString *)imageLarge;
/// NSURL to the artists image size large
- (NSURL *)imageLargeURL;
/// Never-nil NSString of the url
- (NSString *)imageExtraLarge;
/// NSURL to the artists image size extra large
- (NSURL *)imageExtraLargeURL;
/// Never-nil NSString of the url
- (NSString *)imageMega;
/// NSURL to the artists image size mega
- (NSURL *)imageMegaURL;
/// Never-nil NSString of the artists music brianz id
- (NSString *)musicBrianzId;
/// Never-nil NSString of the artists name
- (NSString *)name;
/// Never-nil NSString, 1=YES, 0=NO
- (NSString *)isOnTour;
/// Boolean indicating if the artist is on tour or not
- (BOOL)isOnTourBool;
/// Never-nil NSString of the artists similar artists
- (NSString *)similarArtists;
/// NSArray of NSDictionaries of similar artists
- (NSArray *)similarArtistsArray;
/// Never-nil NSString of the artists listeners
- (NSString *)listeners;
/// NSNumber of listeners as long long
- (NSNumber *)listenersNumber;
/// Never-nil NSString of the artists playcount
- (NSString *)playcount;
/// NSNumber of playcount as long long
- (NSNumber *)playcountNumber;
/// Never-nil NSString indicating if it's streamable
- (NSString *)streamable;
/// Boolean indicating if the artists content is streamable
- (BOOL)streamableBool;
/// Never-nil NSString of the artists tags
- (NSString *)tags;
/// (ordered) Array of Names as NSStrings
- (NSArray *)tagNames;
/// (ordered) Array of Last.fm tag links as NSURLs
- (NSArray *)tagURLs;
/// Never-nil NSString of the artists Last.fm page
- (NSString *)lastFmPage;
/// NSURL to the artists Last.fm page
- (NSURL *)lastFmPageURL;

@end
