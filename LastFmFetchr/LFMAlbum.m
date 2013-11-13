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
	return [self notNilStringForKeyPath:@"mbid"];
}

- (NSString *)name
{
	return [self notNilStringForKeyPath:@"name"];
}

- (NSNumber *)playcount
{
	return [self longLongNumberForKeyPath:@"playcount"];
}

- (NSURL *)lfmPage
{
	return [NSURL URLWithString:[self notNilStringForKeyPath:@"url"]];
}

@end
