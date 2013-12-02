//
//  LFMAlbumInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumInfo.h"

@implementation LFMAlbumInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKeyWithDelimiter];
	
	NSDictionary *mapping =  @{
							   @"artistName" : [contentKey stringByAppendingFormat:@"artist"],
							   @"lfmId" : [contentKey stringByAppendingFormat:@"id"],
							   @"listeners" : [contentKey stringByAppendingFormat:@"listeners"],
							   @"releaseDate" : [contentKey stringByAppendingFormat:@"releasedate"],
							   //@"topTags" : [contentKey stringByAppendingFormat:@"toptags"],
							   //@"tracks" : [contentKey stringByAppendingFormat:@"tracks"],
							   @"wikiContent" : [contentKey stringByAppendingFormat:@"wiki.content"],
							   @"wikiPublishedDate" : [contentKey stringByAppendingFormat:@"wiki.published"],
							   @"wikiSummary" : [contentKey stringByAppendingFormat:@"wiki.summary"]
							   };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

@end
