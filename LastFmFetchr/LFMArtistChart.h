//
//  LFMArtistChart.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 26/11/14.
//  Copyright (c) 2014 edgeguard. All rights reserved.
//

#import "LFMArtist.h"

@interface LFMArtistChart : LFMArtist

@property (nonatomic, strong, readonly) NSNumber *listeners;
@property (nonatomic, strong, readonly) NSNumber *playcount;
@property (nonatomic, strong, readonly) NSNumber *isStreamable;

@end
