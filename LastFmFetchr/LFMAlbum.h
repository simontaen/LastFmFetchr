//
//  LFMAlbum.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 31/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFMData.h"

@interface LFMAlbum : LFMData

@property (nonatomic, strong) NSURL *imageSmall;
@property (nonatomic, strong) NSURL *imageMedium;
@property (nonatomic, strong) NSURL *imageLarge;
@property (nonatomic, strong) NSURL *imageExtraLarge;
@property (nonatomic, strong) NSString *imageSmallString;
@property (nonatomic, strong) NSString *imageMediumString;
@property (nonatomic, strong) NSString *imageLargeString;
@property (nonatomic, strong) NSString *imageExtraLargeString;
@property (nonatomic, strong) NSString *musicBrianzId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *playcount;
@property (nonatomic, strong) NSURL *lastFmPage;

@end
