//
//  LFMAlbumGetInfoDict.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMDictionary.h"

@interface LFMAlbumGetInfoDict : LFMDictionary

/// Never-nil NSString of the albums artist name
- (NSString *)albumArtistName;
/// Never-nil NSString of the album Id
- (NSString *)albumId;
/// NSNumber of the album Id as long long
- (NSNumber *)albumIdNumber;
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
/// Never-nil NSString of the albums toptags
- (NSString *)albumToptags;
/// (ordered) Array of albums toptags as NSStrings
- (NSArray *)albumToptagNames;
/// (ordered) Array of Last.fm tag links as NSURLs
- (NSArray *)albumToptagURLs;
/// Never-nil NSString of the album tracks
- (NSString *)albumTracks;
/// NSArray of NSDictionaries of the album tracks
- (NSArray *)albumTracksArray;
/// Never-nil NSString of the albums Last.fm page
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
