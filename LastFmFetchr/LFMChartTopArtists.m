//
//  LFMChartTopArtists.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 26/11/14.
//  Copyright (c) 2014 edgeguard. All rights reserved.
//

#import "LFMChartTopArtists.h"

@implementation LFMChartTopArtists

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  @"artists" : [contentKey stringByAppendingString:@"artist"]
	  };
	
	return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

@end
