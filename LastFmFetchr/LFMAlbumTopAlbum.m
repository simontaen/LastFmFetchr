//
//  LFMAlbumTopAlbum.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumTopAlbum.h"

@implementation LFMAlbumTopAlbum

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  // TODO: check stackoverflow about @
	  //@"rankInAllArtistAlbums" : [contentKey stringByAppendingFormat:@"@attr.rank"],
	  @"artist" : [contentKey stringByAppendingString:@"artist"]
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}


@end
