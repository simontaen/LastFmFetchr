//
//  LFMArtistGetTopAlbumsDict.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistGetTopAlbumsDict.h"
#import "LastFmFetchr.h"

@implementation LFMArtistGetTopAlbumsDict

- (NSArray *)albumArtistsAlbumList
{
	id obj = [self valueForKeyPath:kLFMAlbum_ArtistsAlbumList];
	if ([obj isKindOfClass:[NSArray class]]) {
		return obj;
	}
	return nil;
}

- (NSString *)albumRankInAllArtistAlbums
{
	return [self notNilStringForKeyPath:kLFMAlbum_RankInAllArtistAlbums];
}

- (NSNumber *)albumRankInAllArtistAlbumsNumber
{
	return [NSNumber numberWithInt:[[self albumRankInAllArtistAlbums] intValue]];
}

- (NSString *)albumArtistName
{
	return [self notNilStringForKeyPath:kLFMAlbumArtist_Name];
}

@end
