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
	NSString *contentKey = [self contentKeyWithDelimiter];
	
	NSDictionary *mapping =  @{
							   @"musicBrianzId" : [contentKey stringByAppendingFormat:@"mbid"],
							   @"name" : [contentKey stringByAppendingString:@"name"],
							   @"lfmPage" : [contentKey stringByAppendingString:@"url"]
							   };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

@end
