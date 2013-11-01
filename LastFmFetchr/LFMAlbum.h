//
//  LFMAlbum.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 31/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"
#import "LFMData+ImagesSmallToXL.h"

@interface LFMAlbum : LFMData

@property (nonatomic, strong, readonly) NSString *musicBrianzId;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSNumber *playcount;
@property (nonatomic, strong, readonly) NSURL *lastFmPage;

@end
