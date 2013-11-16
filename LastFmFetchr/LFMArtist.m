//
//  LFMArtist.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/10/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtist.h"

@implementation LFMArtist

#pragma mark -

- (NSString *)musicBrianzId
{
	static NSString *musicBrianzId = nil;
	if (!musicBrianzId) {
		musicBrianzId = [self notNilStringForKeyPath:@"mbid"];
	}
	return musicBrianzId;
}

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
