//
//  LFMAlbumGetInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"

@interface LFMAlbumGetInfo : LFMAlbum

/// Never-nil NSString of the albums artist name
- (NSString *)artistName;
/// Never-nil NSString of the album Id
- (NSString *)identification;
/// NSNumber of the album Id as long long
- (NSNumber *)idNumber;
/// Never-nil NSString of the number of album listeners
- (NSString *)listeners;
/// NSNumber of listeners as long long
- (NSNumber *)listenersNumber;
/// Never-nil NSString of the url
- (NSString *)imageMega;
/// NSURL to the albums image size mega
- (NSURL *)imageMegaURL;
/// Never-nil NSString of the albums releasedate (trimmed)
- (NSString *)releasedate;
/// NSDate of the albums releasedate
- (NSDate *)releasedateDate;
/// Never-nil NSString of the albums toptags
- (NSString *)toptags;
/// (ordered) Array of albums toptags as NSStrings
- (NSArray *)toptagNames;
/// (ordered) Array of Last.fm tag links as NSURLs
- (NSArray *)toptagURLs;
/// Never-nil NSString of the album tracks
- (NSString *)tracks;
/// NSArray of NSDictionaries of the album tracks
- (NSArray *)tracksArray;
/// Never-nil NSString of the albums wiki content
- (NSString *)wikiContent;
/// Never-nil NSString of the albums wiki publishing date
- (NSString *)wikiPublished;
/// NSDate of when the wiki was published
- (NSDate *)wikiPublishedDate;
/// Never-nil NSString of the albums wiki summary
- (NSString *)wikiSummary;

@end
