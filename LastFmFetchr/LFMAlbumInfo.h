//
//  LFMAlbumInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFMAlbum.h"

@protocol LFMAlbumInfo <NSObject, LFMAlbum>

// TODO: Images S to Mega
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

@end
