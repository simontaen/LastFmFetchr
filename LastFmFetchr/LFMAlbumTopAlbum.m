//
//  LFMAlbumTopAlbum.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 31/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumTopAlbum.h"

@implementation LFMAlbumTopAlbum

#pragma mark - http://www.last.fm/api/show/artist.getTopAlbums

- (NSNumber *)rankInAllArtistAlbums
{
	static NSNumber *rankInAllArtistAlbums = nil;
	if (!rankInAllArtistAlbums) {
		rankInAllArtistAlbums = [NSNumber numberWithInt:[[self notNilStringForKeyPath:@"@attr.rank"] intValue]];
	}
	return rankInAllArtistAlbums;
}

- (LFMArtist *)artist
{
	static LFMArtist *artist = nil;
	if (!artist) {
		id obj = [self.JSON valueForKeyPath:@"artist"];
		
		if ([obj isKindOfClass:[NSDictionary class]]) {
			artist = [[LFMArtist alloc] initWithJson:(NSDictionary *)obj];
		}
		// intentionally returning nil, not sure what to do here.
	}
	return artist;
}

@end
