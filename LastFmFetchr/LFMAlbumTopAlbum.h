//
//  LFMAlbumTopAlbum.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 31/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"
#import "LFMArtist.h"

@interface LFMAlbumTopAlbum : LFMAlbum

@property (nonatomic, strong, readonly) NSNumber *rankInAllArtistAlbums;
@property (nonatomic, strong, readonly) LFMArtist *artist;

@end
