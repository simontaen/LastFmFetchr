//
//  LFMArtistGetTopAlbums.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistsTopAlbums.h"
#import "KZPropertyMapper.h"
#import "LFMAlbumTopAlbum.h"

@implementation LFMArtistsTopAlbums

- (instancetype)initWithJson:(NSDictionary *)JSON {
    self = [super initWithJson:JSON];
    if (self) {
		// http://www.last.fm/api/show/artist.getTopAlbums
		[KZPropertyMapper mapValuesFrom:JSON
							 toInstance:self
						   usingMapping:@{
										  @"@attr" : @{
												  @"artist" : KZProperty(artistName)
												  },
										  @"album" : KZCall(albumsFromArray:, albums)
										  }];
    }
    return self;
}

- (NSArray *)albumsFromArray:(id)obj
{
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
