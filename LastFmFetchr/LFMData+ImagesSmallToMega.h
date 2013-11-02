//
//  LFMData+ImagesSmallToMega.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 02/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData+ImagesSmallToXL.h"

@interface LFMData (ImagesSmallToMega)

@property (nonatomic, strong, readonly) NSURL *imageMega;
@property (nonatomic, strong, readonly) NSString *imageMegaString;

@end
