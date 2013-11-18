//
//  LFMTagInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFMTag.h"

@protocol LFMTagInfo <NSObject, LFMTag>

// TODO: Images S to Mega
- (NSNumber *)listeners;
- (NSDate *)releaseDate;

@end
