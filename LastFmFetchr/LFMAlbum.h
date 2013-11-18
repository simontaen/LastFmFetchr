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
- (NSString *)musicBrianzId;
- (NSString *)name;
- (NSNumber *)playcount;
- (NSURL *)lfmPage;

@end
