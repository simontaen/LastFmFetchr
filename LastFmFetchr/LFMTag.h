//
//  LFMTag.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LFMTag <NSObject>

- (NSString *)name;
- (NSURL *)lfmPage;

@end
