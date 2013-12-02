//
//  LFMAlbumTopAlbum.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumTopAlbum.h"

@implementation LFMAlbumTopAlbum

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  // see http://stackoverflow.com/questions/1567850/using-valueforkeypath-on-nsdictionary-if-a-key-starts-the-symbol
	  //@"rankInAllArtistAlbums" : [contentKey stringByAppendingFormat:@"@attr.rank"],
	  @"artist" : [contentKey stringByAppendingString:@"artist"]
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}


@end
