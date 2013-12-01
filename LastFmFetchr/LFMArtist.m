//
//  LFMArtist.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtist.h"

@implementation LFMArtist

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSDictionary *mapping =  @{
							   // TODO: artist can be defined in LFMData
							   @"musicBrianzId" : @"artist.mbid",
							   @"name" : @"artist.name",
							   @"lfmPage" : @"artist.url"
							   };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

@end
