//
//  LFMArtistGetTopAlbums.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"

@interface LFMArtistsTopAlbums : LFMData

@property (nonatomic, strong, readonly) NSString *artist;
///	of LFMAlbumTopAlbum's
@property (nonatomic, strong, readonly) NSArray *albums;

@end
