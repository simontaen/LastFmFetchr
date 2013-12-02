//
//  LFMTag.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMTag.h"
#import "LFMTagInfo.h"

@implementation LFMTag

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  @"name" : [contentKey stringByAppendingFormat:@"name"],
	  @"lfmPage" : [contentKey stringByAppendingString:@"url"]
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
{
	// NOTE only handle nested objects here

	[self setContentKey:@""];
	
	if ([JSONDictionary count] > 2) {
        return LFMTagInfo.class;
    }
	
	return self.class;
}

@end
