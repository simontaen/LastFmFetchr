//
//  LFMArtistGetTopAlbums.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"

@interface LFMArtistGetTopAlbums : LFMData

- (NSArray *)albumArtistsAlbumList;
- (NSString *)albumRankInAllArtistAlbums;
- (NSNumber *)albumRankInAllArtistAlbumsNumber;
- (NSString *)albumArtistName;

@end
