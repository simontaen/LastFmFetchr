//
//  LFMAlbumTopAlbum.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 31/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"

@interface LFMAlbumTopAlbum : LFMAlbum

///
- (NSString *)rankInAllArtistAlbums;
///
- (NSNumber *)rankInAllArtistAlbumsNumber;

@end
