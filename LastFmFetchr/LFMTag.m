//
//  LFMTag.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMTag.h"

@implementation LFMTag

- (NSString *)description
{
	return self.name;
}

#pragma mark -

- (NSString *)name
{
	return [self notNilStringForKeyPath:@"name"];
}

- (NSArray *)lfmPage
{
	return [NSURL URLWithString:[self notNilStringForKeyPath:@"url"]];
}

@end
