//
//  LFMChartTopArtists.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 26/11/14.
//  Copyright (c) 2014 edgeguard. All rights reserved.
//

#import "LFMData.h"

@interface LFMChartTopArtists : LFMData

///	of LFMArtistChart
@property (nonatomic, strong, readonly) NSArray *artists;

@end
