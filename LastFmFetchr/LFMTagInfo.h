//
//  LFMTagInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 02/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMTag.h"
#import "LFMData+ImagesSmallToMega.h"

@interface LFMTagInfo : LFMTag

@property (nonatomic, strong, readonly) NSNumber *listeners;
@property (nonatomic, strong, readonly) NSDate *releaseDate;

@end
