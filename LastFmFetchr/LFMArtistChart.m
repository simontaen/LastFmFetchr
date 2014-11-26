//
//  LFMArtistChart.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 26/11/14.
//  Copyright (c) 2014 edgeguard. All rights reserved.
//

#import "LFMArtistChart.h"

@implementation LFMArtistChart

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  @"listeners" : [contentKey stringByAppendingFormat:@"listeners"],
	  @"playcount" : [contentKey stringByAppendingFormat:@"playcount"],
	  @"isStreamable" : [contentKey stringByAppendingFormat:@"streamable"]
	  };
	
	return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

@end
