//
//  LFMTesting.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 10/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFMTesting : NSObject

@property (nonatomic, strong, readonly) NSArray *topTags;

- (instancetype)initForTesting;

@end
