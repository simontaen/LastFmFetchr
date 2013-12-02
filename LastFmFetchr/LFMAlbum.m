//
//  LFMAlbum.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"

@implementation LFMAlbum

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKeyWithDelimiter];
	
	NSDictionary *mapping =
	@{
	  @"musicBrianzId" : [contentKey stringByAppendingFormat:@"mbid"],
	  @"name" : [contentKey stringByAppendingString:@"name"],
	  @"playcount" : [contentKey stringByAppendingString:@"playcount"],
	  @"lfmPage" : [contentKey stringByAppendingString:@"url"]
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

@end
