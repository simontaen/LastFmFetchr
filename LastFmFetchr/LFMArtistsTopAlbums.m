//
//  LFMArtistGetTopAlbums.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistsTopAlbums.h"
#import "LFMAlbumTopAlbum.h"

@implementation LFMArtistsTopAlbums

#pragma mark - http://www.last.fm/api/show/artist.getTopAlbums

- (NSString *)artistName
{
	static NSString *artistName = nil;
	if (!artistName) {
		artistName = [self notNilStringForKeyPath:@"attr.artist"];
	}
	return artistName;
}

- (NSArray *)albums
{
	static NSArray *albums = nil;
	if (!albums) {
		id obj = [self.JSON valueForKeyPath:@"album"];
		
		if (![obj isKindOfClass:[NSArray class]]) {
			albums = [NSArray array];
		} else {
			NSArray *array = (NSArray *)obj;
			NSMutableArray *mutableAlbums = [NSMutableArray arrayWithCapacity:[array count]];
			for (id aAlbum in array) {
				if ([aAlbum isKindOfClass:[NSDictionary class]]) {
					[mutableAlbums addObject:[[LFMAlbumTopAlbum alloc] initWithJson:(NSDictionary *)aAlbum]];
				}
			}
			albums = [NSArray arrayWithArray:mutableAlbums];
		}
	}
	return albums;
}

@end
