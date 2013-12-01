//
//  LFMTagInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 18/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMTag.h"

@interface LFMTagInfo : LFMTag

// TODO: Images S to Mega
@property (nonatomic, strong, readonly) NSNumber *listeners;
@property (nonatomic, strong, readonly) NSDate *releaseDate;

@end
