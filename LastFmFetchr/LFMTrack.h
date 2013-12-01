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

@property (nonatomic, strong, readonly) NSNumber *rank;
@property (nonatomic, strong, readonly) LFMArtist *artist;
@property (nonatomic, strong, readonly) NSNumber *duration;
@property (nonatomic, strong, readonly) NSString *musicBrianzId;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, readonly) BOOL isTrackStreamable;
@property (nonatomic, strong, readonly) NSURL *lfmPage;

@end
