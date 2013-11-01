//
//  LFMAlbumGetInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"

@interface LFMAlbumInfo : LFMAlbum

@property (nonatomic, strong, readonly) NSString *artistName;
@property (nonatomic, strong, readonly) NSNumber *lfmId;
@property (nonatomic, strong, readonly) NSURL *imageMega;
@property (nonatomic, strong, readonly) NSString *imageMegaString;
@property (nonatomic, strong, readonly) NSNumber *listeners;
@property (nonatomic, strong, readonly) NSDate *releaseDate;
/// (ordered) Array of albums toptags as NSStrings
@property (nonatomic, strong, readonly) NSArray *toptagNames;
/// (ordered) Array of Last.fm tag links as NSURLs
@property (nonatomic, strong, readonly) NSArray *toptagURLs;
/// NSArray of NSDictionaries of the album tracks
@property (nonatomic, strong, readonly) NSArray *tracks;
@property (nonatomic, strong, readonly) NSString *wikiContent;
@property (nonatomic, strong, readonly) NSDate *wikiPublishedDate;
@property (nonatomic, strong, readonly) NSString *wikiSummary;

@end
