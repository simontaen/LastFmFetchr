//
//  LFMData.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "Mantle.h"

static NSString *const kDelim = @".";

@interface LFMData : MTLModel <MTLJSONSerializing>

+ (void)setContentKey:(NSString *)key;
+ (NSString *)contentKey;

@end
