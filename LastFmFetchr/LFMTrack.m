//
//  LFMTrack.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMTrack.h"

@implementation LFMTrack

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  @"rank" : [contentKey stringByAppendingFormat:@"%@attr.rank", kAtPrefixReplacement],
	  @"artist" : [contentKey stringByAppendingString:@"artist"],
	  @"duration" : [contentKey stringByAppendingFormat:@"duration"],
	  @"musicBrianzId" : [contentKey stringByAppendingString:@"mbid"],
	  @"name" : [contentKey stringByAppendingFormat:@"name"],
	  @"isTrackStreamable" : [contentKey stringByAppendingString:@"streamable.fulltrack"],
	  @"lfmPage" : [contentKey stringByAppendingString:@"url"],
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
{
	// NOTE only handle nested objects here
	
	[self setContentKey:@""];
	
	return self.class;
}

@end
