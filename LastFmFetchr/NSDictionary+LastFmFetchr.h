//
//  NSDictionary+LastFmFetchr.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 24/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//
// This Category gives very easy access to the NSDictionary JSON response from Last.fm
// You can get the data 'raw' as an NSString, or with an actual type.

#import <Foundation/Foundation.h>

@interface NSDictionary (LastFmFetchr)

// artist.getInfo
/// Straight JSON ouput
- (NSString *)artistMembers;
/// NSArray of NSDictionaries @{ name : NSString, yearfrom : NSDate, yearto : yearto }
- (NSArray *)artistMemberArray;
/// Straight JSON ouput
- (NSString *)artistBioContent;
/// Straight JSON ouput
- (NSString *)artistBioFormationYears;
/// NSArray of NSDates, [1] = year from, [2] = year to
- (NSArray *)artistBioFormationYearDates;
/// Straight JSON ouput
- (NSString *)artistBioLink;
/// NSURL to the artists last.fm bio page
- (NSURL *)artistBioLinkURL;
/// Straight JSON ouput
- (NSString *)artistBioPlaceFormed;
/// Straight JSON ouput
- (NSString *)artistBioPublished;
/// NSDate of when the artists Bio was published
- (NSDate *)artistBioPublishedDate;
/// Straight JSON ouput
- (NSString *)artistBioSummary;
/// Straight JSON ouput
- (NSString *)artistBioYearFormed;
/// NSDate of when the Band was formed
- (NSDate *)artistBioYearFormedDate;
/// Straight JSON ouput
- (NSString *)artistImageSmall;
/// NSURL to the artists image size small
- (NSURL *)artistImageSmallURL;
/// Straight JSON ouput
- (NSString *)artistImageMedium;
/// NSURL to the artists image size medium
- (NSURL *)artistImageMediumURL;
/// Straight JSON ouput
- (NSString *)artistImageLarge;
/// NSURL to the artists image size large
- (NSURL *)artistImageLargeURL;
/// Straight JSON ouput
- (NSString *)artistImageExtraLarge;
/// NSURL to the artists image size extra large
- (NSURL *)artistImageExtraLargeURL;
/// Straight JSON ouput
- (NSString *)artistImageMega;
/// NSURL to the artists image size mega
- (NSURL *)artistImageMegaURL;
/// Straight JSON ouput
- (NSString *)artistMusicBrianzId;
/// Straight JSON ouput
- (NSString *)artistName;
/// Straight JSON ouput
- (NSString *)artistIsOnTour;
/// Boolean indicating if the artist is on tour or not
- (BOOL)artistIsOnTourBool;
/// Straight JSON ouput
- (NSString *)artistSimilarArtists;
/// NSArray of NSDictionaries of similar artists
- (NSArray *)artistSimilarArtistsArray;
/// Straight JSON ouput
- (NSString *)artistListeners;
// NSNumber of Listeners as long long
- (NSNumber *)artistListenersNumber;
/// Straight JSON ouput
- (NSString *)artistPlaycount;
// NSNumber of Playcounts as long long
- (NSNumber *)artistPlaycountNumber;
/// Straight JSON ouput
- (NSString *)artistStreamable;
/// Boolean indicating if the artists content is streamable
- (BOOL)artistStreamableBool;
/// Straight JSON ouput
- (NSString *)artistTags;
/// (ordered) Array of Names as NSStrings
- (NSArray *)artistTagNames;
/// (ordered) Array of Last.fm tag links as NSURLs
- (NSArray *)artistTagURLs;
/// Straight JSON ouput
- (NSString *)artistLastFmPage;
/// NSURL to the artists Last.fm page
- (NSURL *)artistLastFmPageURL;

@end
