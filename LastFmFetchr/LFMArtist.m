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
	return [self notNilStringForKeyPath:@"mbid"];
}

- (NSString *)name
{
	return [self notNilStringForKeyPath:@"name"];
}

- (NSURL *)lfmPage
{
	return [NSURL URLWithString:[self notNilStringForKeyPath:@"url"]];
}

@end
