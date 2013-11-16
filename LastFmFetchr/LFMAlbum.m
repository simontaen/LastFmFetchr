//
//  LFMAlbum.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 31/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"

@implementation LFMAlbum

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

- (NSNumber *)playcount
{
	static NSNumber *playcount = nil;
	if (!playcount) {
		playcount = [self longLongNumberForKeyPath:@"playcount"];
	}
	return playcount;
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
