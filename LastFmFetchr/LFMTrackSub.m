//
//  LFMTrack.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 17/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMTrackSub.h"

@implementation LFMTrackSub

- (NSString *)description
{
	return self.name;
}

#pragma mark -

- (NSNumber *)rank
{
	static NSNumber *rank = nil;
	if (!rank) {
		rank = [NSNumber numberWithInt:[[self notNilStringForKeyPath:@"@attr.rank"] intValue]];
	}
	return rank;
}

- (LFMArtist *)artist
{
	static LFMArtist *artist = nil;
	if (!artist) {
		id obj = [self.JSON valueForKeyPath:@"artist"];
		
		if ([obj isKindOfClass:[NSDictionary class]]) {
			artist = [[LFMArtist alloc] initWithJson:(NSDictionary *)obj];
		} else {
			// TODO: this is a problem now, I changed it here,
			// but it won't be reflected at the other place where
			// we do the exact same thing
			// intentionally returning nil, not sure what to do here.
			artist = nil;
		}
	}
	return artist;
}

- (NSNumber *)duration
{
	static NSNumber *duration = nil;
	if (!duration) {
		duration = [self longLongNumberForKeyPath:@"duration"];
	}
	return duration;
}

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

- (BOOL)isTrackStreamable
{
	return [self boolFromString:[self notNilStringForKeyPath:@"streamable.fulltrack"]];
}

@end
