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
	static NSString *name = nil;
	if (!name) {
		name = [self notNilStringForKeyPath:@"name"];
	}
	return name;
}

- (NSURL *)lfmPage
{
	static NSURL *lfmPage = nil;
	if (!lfmPage) {
		lfmPage = [NSURL URLWithString:[self notNilStringForKeyPath:@"url"]];
	}
	return lfmPage;
}

@end
