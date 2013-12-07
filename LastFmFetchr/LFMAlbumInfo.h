//
//  LFMAlbumInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"

@interface LFMAlbumInfo : LFMAlbum

@property (nonatomic, strong, readonly) NSString *artistName;
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

@property (nonatomic, strong, readonly) NSURL *imageSmall;
@property (nonatomic, strong, readonly) NSURL *imageMedium;
@property (nonatomic, strong, readonly) NSURL *imageLarge;
@property (nonatomic, strong, readonly) NSURL *imageExtraLarge;
@property (nonatomic, strong, readonly) NSURL *imageMega;
@property (nonatomic, strong, readonly) NSString *imageSmallString;
@property (nonatomic, strong, readonly) NSString *imageMediumString;
@property (nonatomic, strong, readonly) NSString *imageLargeString;
@property (nonatomic, strong, readonly) NSString *imageExtraLargeString;
@property (nonatomic, strong, readonly) NSString *imageMegaString;

@end
