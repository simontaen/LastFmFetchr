//
//  LFMArtistGetTopAlbums.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistGetTopAlbums.h"
#import "LastFmFetchr.h"

@implementation LFMArtistGetTopAlbums

- (NSArray *)artistsAlbumList
{
	id obj = [self.JSON valueForKeyPath:kLFMAlbum_ArtistsAlbumList];
	if ([obj isKindOfClass:[NSArray class]]) {
		return obj;
	}
	return nil;
}

- (NSString *)rankInAllArtistAlbums
{
	return [self notNilStringForKeyPath:kLFMAlbum_RankInAllArtistAlbums];
}

- (NSNumber *)rankInAllArtistAlbumsNumber
{
	return [NSNumber numberWithInt:[[self rankInAllArtistAlbums] intValue]];
}

- (NSString *)artistName
{
	return [self notNilStringForKeyPath:kLFMAlbumArtist_Name];
}

@end
