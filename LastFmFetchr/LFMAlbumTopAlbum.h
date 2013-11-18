//
//  LFMAlbumTopAlbum.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFMAlbum.h"
#import "LFMArtist.h"

@protocol LFMAlbumTopAlbum <NSObject, LFMAlbum>

- (NSNumber *)rank;
- (id<LFMArtist>)artist;

@end
