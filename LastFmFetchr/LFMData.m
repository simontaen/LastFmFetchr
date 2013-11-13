//
//  LFMData.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"
#import "LFMTag.h"

@implementation LFMData

#pragma mark - Mapping Helpers

- (BOOL)boolFromString:(NSString *)boolString
{
	return [@"1" isEqual:boolString];
}

- (NSArray *)tagsFromDictionary:(id)obj
{
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return [NSArray array];
	}
	NSDictionary *dict = (NSDictionary *)obj;
	
	id jsonArray = dict[@"tag"];
	
	if (![jsonArray isKindOfClass:[NSArray class]]) {
		return [NSArray array];
	}
	NSArray *array = (NSArray *)jsonArray;
	
	NSMutableArray *tagArray = [NSMutableArray arrayWithCapacity:[array count]];
	
	for (id JSON in array) {
		if (![JSON isKindOfClass:[NSDictionary class]]) {
			return nil;
		}
		[tagArray addObject:[[LFMTag alloc] initWithJson:(NSDictionary *)JSON]];
	}
	
	return tagArray;
}

- (NSNumber *)longLongNumberForKeyPath:(NSString *)key
{
	return [NSNumber numberWithLongLong:[[self notNilStringForKeyPath:key] longLongValue]];
}

#pragma mark - Access to JSON

- (NSString *)notNilStringForKeyPath:(NSString *)keyPath
{
	id obj = self.JSON;
	// this is nil value save
	for (NSString *key in [keyPath componentsSeparatedByString:@"."]) {
		if ([obj isKindOfClass:[NSDictionary class]]) {
			obj = obj[key];
		} else {
			return nil;
		}
	}
	
	if (obj) {
		return [obj description];
	}
	return kEmpty;
}

#pragma mark - Lifecycle

- (instancetype)initWithJson:(NSDictionary *)JSON;
{
	self = [super init];
	if (self) {
		_JSON = JSON;
		// TODO: must implement something where only one mapping run is performed
		//[KZPropertyMapper logIgnoredValues:YES];
	}
	return self;
}

@end