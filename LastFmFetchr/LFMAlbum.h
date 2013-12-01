//
//  LFMAlbum.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LFMAlbum <NSObject>

// TODO: Images S to XL
@property (nonatomic, strong, readonly) NSString *musicBrianzId;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSNumber *playcount;
@property (nonatomic, strong, readonly) NSURL *lfmPage;

@end
