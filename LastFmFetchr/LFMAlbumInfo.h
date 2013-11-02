//
//  LFMAlbumGetInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"
#import "LFMData+ImagesSmallToMega.h"

@interface LFMAlbumInfo : LFMAlbum

@property (nonatomic, strong, readonly) NSString *artistName;
@property (nonatomic, strong, readonly) NSNumber *lfmId;
@property (nonatomic, strong, readonly) NSNumber *listeners;
@property (nonatomic, strong, readonly) NSDate *releaseDate;
/// (ordered) Array of LFMTag
@property (nonatomic, strong, readonly) NSArray *topTags;
/// NSArray of NSDictionaries of the album tracks
@property (nonatomic, strong, readonly) NSArray *tracks;
@property (nonatomic, strong, readonly) NSString *wikiContent;
@property (nonatomic, strong, readonly) NSDate *wikiPublishedDate;
@property (nonatomic, strong, readonly) NSString *wikiSummary;

@end
