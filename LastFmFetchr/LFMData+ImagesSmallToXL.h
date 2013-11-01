//
//  LFMData+ImagesSmallToXL.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"

@interface LFMData (ImagesSmallToXL)

@property (nonatomic, strong, readonly) NSURL *imageSmall;
@property (nonatomic, strong, readonly) NSURL *imageMedium;
@property (nonatomic, strong, readonly) NSURL *imageLarge;
@property (nonatomic, strong, readonly) NSURL *imageExtraLarge;
@property (nonatomic, strong, readonly) NSString *imageSmallString;
@property (nonatomic, strong, readonly) NSString *imageMediumString;
@property (nonatomic, strong, readonly) NSString *imageLargeString;
@property (nonatomic, strong, readonly) NSString *imageExtraLargeString;

@end
