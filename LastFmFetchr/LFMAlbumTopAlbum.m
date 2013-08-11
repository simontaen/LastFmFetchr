//
//  LFMAlbumTopAlbum.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 31/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumTopAlbum.h"
#import "LastFmFetchr.h"

@implementation LFMAlbumTopAlbum

- (NSString *)rankInAllArtistAlbums
{
	// check the doc on objectForKeyedSubscript: on why this doesn't work
	return [self notNilStringForKeyPath:kLFMAlbum_RankInAllArtistAlbums];
	/*
	id obj = self.JSON[@"@attr"][@"rank"];
	if (obj) {
		return [obj description];
	}
	return kEmpty;
	 */
}

- (NSNumber *)rankInAllArtistAlbumsNumber
{
	return [NSNumber numberWithInt:[[self rankInAllArtistAlbums] intValue]];
}

@end
