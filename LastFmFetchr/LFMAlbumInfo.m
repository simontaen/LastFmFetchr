//
//  LFMAlbumInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumInfo.h"

@implementation LFMAlbumInfo

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  @"artistName" : [contentKey stringByAppendingFormat:@"artist"],
	  @"lfmId" : [contentKey stringByAppendingFormat:@"id"],
	  @"listeners" : [contentKey stringByAppendingFormat:@"listeners"],
	  @"releaseDate" : [contentKey stringByAppendingFormat:@"releasedate"],
	  @"topTags" : [contentKey stringByAppendingFormat:@"toptags.tag"],
	  @"tracks" : [contentKey stringByAppendingFormat:@"tracks.track"],
	  @"wikiContent" : [contentKey stringByAppendingFormat:@"wiki.content"],
	  @"wikiPublishedDate" : [contentKey stringByAppendingFormat:@"wiki.published"],
	  @"wikiSummary" : [contentKey stringByAppendingFormat:@"wiki.summary"]
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

@end
