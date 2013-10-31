//
//  LFMData.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"
#import "KZPropertyMapper.h"

@implementation LFMData

#pragma mark - Property Mapper Helpers

- (BOOL)boolFromString:(NSString *)boolString
{
	return [@"1" isEqual:boolString];
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
		[KZPropertyMapper logIgnoredValues:NO];
	}
	return self;
}

@end
