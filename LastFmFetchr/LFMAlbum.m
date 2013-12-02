//
//  LFMAlbum.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"
#import "LFMAlbumTopAlbum.h"

@implementation LFMAlbum

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  @"musicBrianzId" : [contentKey stringByAppendingFormat:@"mbid"],
	  @"name" : [contentKey stringByAppendingString:@"name"],
	  @"playcount" : [contentKey stringByAppendingString:@"playcount"],
	  @"lfmPage" : [contentKey stringByAppendingString:@"url"]
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
{
	// NOTE only handle nested objects here
	
	if (JSONDictionary[@"@attr"] != nil && JSONDictionary[@"artist"] != nil) {
		[self setContentKey:@""];
        return LFMAlbumTopAlbum.class;
    }
	
	return self.class;
}

@end
