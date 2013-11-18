//
//  LFMTrack.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 17/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFMArtist.h"

@protocol LFMTrack <NSObject>

- (NSNumber *)rank;
- (id<LFMArtist>)artist;
- (NSNumber *)duration;
- (NSString *)musicBrianzId;
- (NSString *)name;
- (BOOL)isTrackStreamable;
- (NSURL *)lfmPage;

@end
