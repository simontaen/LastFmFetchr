//
//  LFMAlbumTopAlbum.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"
#import "LFMArtist.h"

@interface LFMAlbumTopAlbum : LFMAlbum

// TODO: Images S to XL
@property (nonatomic, strong, readonly) NSNumber *rankInAllArtistAlbums;
@property (nonatomic, strong, readonly) LFMArtist *artist;

@end
