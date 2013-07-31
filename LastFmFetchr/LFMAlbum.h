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

/// Never-nil NSString of the url
- (NSString *)imageSmall;
/// NSURL to the albums image size small
- (NSURL *)imageSmallURL;
/// Never-nil NSString of the url
- (NSString *)imageMedium;
/// NSURL to the albums image size medium
- (NSURL *)imageMediumURL;
/// Never-nil NSString of the url
- (NSString *)imageLarge;
/// NSURL to the albums image size large
- (NSURL *)imageLargeURL;
/// Never-nil NSString of the url
- (NSString *)imageExtraLarge;
/// NSURL to the albums image size extra large
- (NSURL *)imageExtraLargeURL;
/// Never-nil NSString of the albums music brianz id
- (NSString *)musicBrianzId;
/// Never-nil NSString of the albums name
- (NSString *)name;
/// Never-nil NSString of the albums playcount
- (NSString *)playcount;
/// NSNumber of playcounts as long long
- (NSNumber *)playcountNumber;
/// Never-nil NSString of the albums Last.fm page
- (NSString *)lastFmPage;
/// NSURL to the albums Last.fm page
- (NSURL *)lastFmPageURL;

@end
