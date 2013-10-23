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
#import "KZPropertyMapper.h"

@implementation LFMArtistGetTopAlbums

- (instancetype)initWithJson:(NSDictionary *)JSON {
    self = [super initWithJson:JSON];
    if (self) {
		[KZPropertyMapper mapValuesFrom:JSON
							 toInstance:self
						   usingMapping:@{
										  @"@attr" : @{
												  @"artist" : KZProperty(artist)
												  },
										  // TODO: not sure about this
										  @"album" : KZCall(albumsFromString:, albums)
										  }];
    }
    return self;
}

- (NSArray *)albumsFromString:(NSString *)albumsString
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
