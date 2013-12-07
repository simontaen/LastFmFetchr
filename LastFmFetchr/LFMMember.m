//
//  LFMMember.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 07/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMMember.h"

@implementation LFMMember

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  @"name" : [contentKey stringByAppendingFormat:@"name"],
	  @"yearfrom" : [contentKey stringByAppendingFormat:@"yearfrom"],
	  @"yearto" : [contentKey stringByAppendingFormat:@"yearto"]
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
{
	// NOTE only handle nested objects here
	
	[self setContentKey:@""];
	
	return self.class;
}

@end
