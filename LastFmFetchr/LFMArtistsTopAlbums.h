//
//  LFMArtistsTopAlbums.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LFMArtistsTopAlbums <NSObject>

- (NSString *)artistName;
///	of LFMAlbumTopAlbum's
- (NSArray *)albums;

@end
