//
//  LFMArtistGetTopAlbums.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistGetTopAlbums.h"
#import "LastFmFetchr.h"
#import "LFMAlbumTopAlbum.h"

@implementation LFMArtistGetTopAlbums

- (NSString *)artistName
{
	return [self notNilStringForKeyPath:kLFMAlbumArtist_Name];
	/*
	id obj = self.JSON[@"@attr"][@"artist"];
	if (obj) {
		return [obj description];
	}
	return kEmpty;
	 */
}

- (NSArray *)artistsAlbumList
{
	id obj = [self.JSON valueForKeyPath:kLFMAlbum_ArtistsAlbumList];
	if ([obj isKindOfClass:[NSArray class]]) {
		NSArray *array = (NSArray *)obj;
		NSMutableArray *albums = [NSMutableArray arrayWithCapacity:[array count]];
		for (id album in array) {
			if ([album isKindOfClass:[NSDictionary class]]) {
				[albums addObject:[[LFMAlbumTopAlbum alloc] initWithJson:album]];
			}
		}
		return albums;
	}
	return nil;
}

@end
