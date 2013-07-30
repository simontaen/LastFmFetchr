//
//  LFMArtistsGetInfoDict.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMDictionary.h"

@interface LFMArtistsGetInfoDict : LFMDictionary

/// Never-nil NSString of members of the artist
- (NSString *)artistMembers;
/// NSArray of NSDictionaries @{ name : NSString, yearfrom : NSDate, yearto : yearto }
- (NSArray *)artistMemberArray;
/// Never-nil NSString of the artists bio content
- (NSString *)artistBioContent;
/// Never-nil NSString of the artists formation years (yearfrom, yearto)
- (NSString *)artistBioFormationYears;
/// NSArray of NSDates, [1] = year from, [2] = year to
- (NSArray *)artistBioFormationYearDates;
/// Never-nil NSString of the artists last.fm wiki page
- (NSString *)artistBioLink;
/// NSURL to the artists last.fm wiki page
- (NSURL *)artistBioLinkURL;
/// Never-nil NSString of where the artist was formed
- (NSString *)artistBioPlaceFormed;
/// Never-nil NSString of when the artists bio was published
- (NSString *)artistBioPublished;
/// NSDate of when the artists bio was published
- (NSDate *)artistBioPublishedDate;
/// Never-nil NSString of the artists bio summary
- (NSString *)artistBioSummary;
/// Never-nil NSString of when the artist was formed
- (NSString *)artistBioYearFormed;
/// NSDate of when the artist was formed
- (NSDate *)artistBioYearFormedDate;
/// Never-nil NSString of the url
- (NSString *)artistImageSmall;
/// NSURL to the artists image size small
- (NSURL *)artistImageSmallURL;
/// Never-nil NSString of the url
- (NSString *)artistImageMedium;
/// NSURL to the artists image size medium
- (NSURL *)artistImageMediumURL;
/// Never-nil NSString of the url
- (NSString *)artistImageLarge;
/// NSURL to the artists image size large
- (NSURL *)artistImageLargeURL;
/// Never-nil NSString of the url
- (NSString *)artistImageExtraLarge;
/// NSURL to the artists image size extra large
- (NSURL *)artistImageExtraLargeURL;
/// Never-nil NSString of the url
- (NSString *)artistImageMega;
/// NSURL to the artists image size mega
- (NSURL *)artistImageMegaURL;
/// Never-nil NSString of the artists music brianz id
- (NSString *)artistMusicBrianzId;
/// Never-nil NSString of the artists name
- (NSString *)artistName;
/// Never-nil NSString, 1=YES, 0=NO
- (NSString *)artistIsOnTour;
/// Boolean indicating if the artist is on tour or not
- (BOOL)artistIsOnTourBool;
/// Never-nil NSString of the artists similar artists
- (NSString *)artistSimilarArtists;
/// NSArray of NSDictionaries of similar artists
- (NSArray *)artistSimilarArtistsArray;
/// Never-nil NSString of the artists listeners
- (NSString *)artistListeners;
/// NSNumber of listeners as long long
- (NSNumber *)artistListenersNumber;
/// Never-nil NSString of the artists playcount
- (NSString *)artistPlaycount;
/// NSNumber of playcount as long long
- (NSNumber *)artistPlaycountNumber;
/// Never-nil NSString indicating if it's streamable
- (NSString *)artistStreamable;
/// Boolean indicating if the artists content is streamable
- (BOOL)artistStreamableBool;
/// Never-nil NSString of the artists tags
- (NSString *)artistTags;
/// (ordered) Array of Names as NSStrings
- (NSArray *)artistTagNames;
/// (ordered) Array of Last.fm tag links as NSURLs
- (NSArray *)artistTagURLs;
/// Never-nil NSString of the artists Last.fm page
- (NSString *)artistLastFmPage;
/// NSURL to the artists Last.fm page
- (NSURL *)artistLastFmPageURL;

@end
