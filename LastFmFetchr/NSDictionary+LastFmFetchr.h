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
/// Never-nil NSString of members of the artist
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
/// NSNumber of listeners as long long
- (NSNumber *)artistListenersNumber;
/// Straight JSON ouput
- (NSString *)artistPlaycount;
/// NSNumber of playcount as long long
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

// album.getInfo
/// Never-nil NSString of the albums artist name
- (NSString *)albumArtistName;
/// Never-nil NSString of the album Id
- (NSString *)albumId;
/// Never-nil NSString of the url
- (NSString *)albumImageSmall;
/// NSURL to the albums image size small
- (NSURL *)albumImageSmallURL;
/// Never-nil NSString of the url
- (NSString *)albumImageMedium;
/// NSURL to the albums image size medium
- (NSURL *)albumImageMediumURL;
/// Never-nil NSString of the url
- (NSString *)albumImageLarge;
/// NSURL to the albums image size large
- (NSURL *)albumImageLargeURL;
/// Never-nil NSString of the url
- (NSString *)albumImageExtraLarge;
/// NSURL to the albums image size extra large
- (NSURL *)albumImageExtraLargeURL;
/// Never-nil NSString of the url
- (NSString *)albumImageMega;
/// NSURL to the albums image size mega
- (NSURL *)albumImageMegaURL;
/// Never-nil NSString of the number of album listeners
- (NSString *)albumListeners;
/// NSNumber of listeners as long long
- (NSNumber *)albumListenersNumber;
/// Never-nil NSString of the albums music brianz id
- (NSString *)albumMusicBrianzId;
/// Never-nil NSString of the albums name
- (NSString *)albumName;
/// Never-nil NSString of the albums playcount
- (NSString *)albumPlaycount;
/// NSNumber of playcounts as long long
- (NSNumber *)albumPlaycountNumber;
/// Never-nil NSString of the albums releasedate (trimmed)
- (NSString *)albumReleasedate;
/// NSDate of the albums releasedate
- (NSDate *)albumReleasedateDate;
/// Never-nil JSON NSString of the albums toptags
- (NSString *)albumToptags;
/// (ordered) Array of albums toptags as NSStrings
- (NSArray *)albumToptagNames;
/// (ordered) Array of Last.fm tag links as NSURLs
- (NSArray *)albumToptagURLs;
/// Never-nil JSON NSString of the album tracks
- (NSString *)albumTracks;
/// NSArray of NSDictionaries of the album tracks
- (NSArray *)albumTracksArray;
/// Never-nil JSON NSString of the albums Last.fm page
- (NSString *)albumLastFmPage;
/// NSURL to the albums Last.fm page
- (NSURL *)albumLastFmPageURL;
/// Never-nil NSString of the albums wiki content
- (NSString *)albumWikiContent;
/// Never-nil NSString of the albums wiki publishing date
- (NSString *)albumWikiPublished;
/// NSDate of when the wiki was published
- (NSDate *)albumWikiPublishedDate;
/// Never-nil NSString of the albums wiki summary
- (NSString *)albumWikiSummary;

@end
