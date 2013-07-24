//
//  NSDictionary+LastFmFetchr.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 24/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//
// This Category gives very easy access to the NSDictionary JSON response from Last.fm
// You can get the data 'raw' as an NSString, or with an actual type.

// IDEA, either create a new Dictionary with better keys (preload work)
// OR provide an NSDictionary category for accessing the data (work on demand, but usually NOT repeated)
// It seems like the NSDictionary cat would be a better option
// easy for the User, NOT subject to changes on the API data returned
// still gives the user the freedom to dig around himself

// NSLog(@"kLFMArtistImage with mod %@", JSON[kLFMArtistImageList][3][@"#text"]);


#import "NSDictionary+LastFmFetchr.h"

@implementation NSDictionary (LastFmFetchr)

@end
