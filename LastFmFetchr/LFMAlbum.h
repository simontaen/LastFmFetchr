//
//  LFMAlbum.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"

@interface LFMAlbum : LFMData

@property (nonatomic, strong, readonly) NSString *musicBrianzId;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSNumber *playcount;
@property (nonatomic, strong, readonly) NSURL *lfmPage;

@property (nonatomic, strong, readonly) NSURL *imageSmall;
@property (nonatomic, strong, readonly) NSURL *imageMedium;
@property (nonatomic, strong, readonly) NSURL *imageLarge;
@property (nonatomic, strong, readonly) NSURL *imageExtraLarge;
@property (nonatomic, strong, readonly) NSString *imageSmallString;
@property (nonatomic, strong, readonly) NSString *imageMediumString;
@property (nonatomic, strong, readonly) NSString *imageLargeString;
@property (nonatomic, strong, readonly) NSString *imageExtraLargeString;

@end
