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
- (NSString *)artistName;
- (NSNumber *)lfmId;
- (NSNumber *)listeners;
- (NSDate *)releaseDate;
/// (ordered) Array of LFMTag
- (NSArray *)topTags;
/// (ordered) Array of LFMTracks
- (NSArray *)tracks;
- (NSString *)wikiContent;
- (NSDate *)wikiPublishedDate;
- (NSString *)wikiSummary;

@end
