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
	return [self notNilStringForKeyPath:@"attr.artist"];
}

- (NSArray *)albums
{
	id obj = [self.JSON valueForKeyPath:@"album"];
	
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
