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
	return [NSNumber numberWithInt:[[self notNilStringForKeyPath:@"@attr.rank"] intValue]];
}

- (LFMArtist *)artist
{
	id obj = [self.JSON valueForKeyPath:@"artist"];
	
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSDictionary *dict = (NSDictionary *)obj;
	
	return [[LFMArtist alloc] initWithJson:dict];
}

@end
