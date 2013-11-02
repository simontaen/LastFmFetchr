//
//  LFMTag.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"

@interface LFMTag : LFMData

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSURL *lfmPage;

@end
