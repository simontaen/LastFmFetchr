//
//  LFMAlbumGetInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumInfo.h"

@implementation LFMAlbumInfo

#pragma mark - http://www.last.fm/api/show/album.getInfo

- (NSString *)artistName
{
	static NSString *artistName = nil;
	if (!artistName) {
		artistName = [self notNilStringForKeyPath:@"artist"];
	}
	return artistName;
}

- (NSNumber *)lfmId
{
	static NSNumber *lfmId = nil;
	if (!lfmId) {
		lfmId = [self longLongNumberForKeyPath:@"id"];
	}
	return lfmId;
}

- (NSNumber *)listeners
{
	static NSNumber *listeners = nil;
	if (!listeners) {
		return [self longLongNumberForKeyPath:@"listeners"];
	}
	return listeners;
}

- (NSDate *)releaseDate
{
	static NSDate *releaseDate = nil;
	if (!releaseDate) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"d MMMM yyyy, ZZZZZ"];
		
		NSString *dateString = [[self notNilStringForKeyPath:@"releasedate"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		releaseDate = [formatter dateFromString:[dateString stringByReplacingOccurrencesOfString:@"00:00" withString:@"-00:00"]];
	}
	return releaseDate;
}

- (NSArray *)topTags
{
	static NSArray *topTags = nil;
	if (!topTags) {
		topTags = [self tagsFromDictionary:@"toptags"];
	}
	return topTags;
}

// TODO: LFMTrack
- (NSArray *)tracks
{
	static NSArray *tracks = nil;
	if (!tracks) {
		id obj = [self.JSON valueForKeyPath:@"tracks.track"];
		if (![obj isKindOfClass:[NSArray class]]) {
			tracks = [NSArray array];
		} else {
			tracks = (NSArray *)obj;			
		}
	}
	return tracks;
}

- (NSString *)wikiContent
{
	static NSString *wikiContent = nil;
	if (!wikiContent) {
		wikiContent = [self notNilStringForKeyPath:@"wiki.content"];
	}
	return wikiContent;
}

- (NSDate *)wikiPublishedDate
{
	static NSDate *wikiPublishedDate = nil;
	if (!wikiPublishedDate) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
		
		wikiPublishedDate = [formatter dateFromString:[self notNilStringForKeyPath:@"wiki.published"]];
	}
	return wikiPublishedDate;
}

- (NSString *)wikiSummary
{
	static NSString *wikiSummary = nil;
	if (!wikiSummary) {
		wikiSummary = [self notNilStringForKeyPath:@"wiki.summary"];
	}
	return wikiSummary;
}

@end
