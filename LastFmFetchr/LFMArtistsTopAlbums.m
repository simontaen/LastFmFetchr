//
//  LFMArtistsTopAlbums.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistsTopAlbums.h"

@implementation LFMArtistsTopAlbums

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  // TODO: check stackoverflow about @
	  //@"artistName" : [contentKey stringByAppendingFormat:@"@attr.artist"],
	  @"albums" : [contentKey stringByAppendingString:@"album"]
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

@end
