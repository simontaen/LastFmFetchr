//
//  LFMArtist.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/10/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"

@interface LFMArtist : LFMData

@property (nonatomic, strong, readonly) NSString *musicBrianzId;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSURL *lfmPage;

@end
