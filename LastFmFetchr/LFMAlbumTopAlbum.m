//
//  LFMAlbumTopAlbum.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 31/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumTopAlbum.h"
#import "KZPropertyMapper.h"

@implementation LFMAlbumTopAlbum

- (instancetype)initWithJson:(NSDictionary *)JSON {
    self = [super initWithJson:JSON];
    if (self) {
		// http://www.last.fm/api/show/artist.getTopAlbums
		[KZPropertyMapper mapValuesFrom:JSON
							 toInstance:self
						   usingMapping:@{
										  @"@attr" : @{
												  @"rank" : KZCall(rankFromString:, rankInAllArtistAlbums)
												  },
										  @"artist" : KZCall(artistFromDictionary:, artist)
										  }];
    }
    return self;
}

- (NSNumber *)rankFromString:(NSString *)rankString
{
	return [NSNumber numberWithInt:[[rankString description] intValue]];
}

- (LFMArtist *)artistFromDictionary:(id)obj
{
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSDictionary *dict = (NSDictionary *)obj;
	
	return [[LFMArtist alloc] initWithJson:dict];
}


@end
