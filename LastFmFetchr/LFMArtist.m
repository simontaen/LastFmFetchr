//
//  LFMArtist.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtist.h"
#import "LFMArtistInfo.h"
#import "LFMArtistChart.h"

@implementation LFMArtist

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  @"musicBrianzId" : [contentKey stringByAppendingFormat:@"mbid"],
	  @"name" : [contentKey stringByAppendingString:@"name"],
	  @"lfmPage" : [contentKey stringByAppendingString:@"url"]
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
{
	// NOTE only handle nested objects here
	
	[self setContentKey:@""];
	
	if (JSONDictionary[@"playcount"] != nil) {
		return LFMArtistChart.class;
	}
	
	if ([JSONDictionary count] > 3) {
		return LFMArtistInfo.class;
	}
	
	return self.class;
}

@end
