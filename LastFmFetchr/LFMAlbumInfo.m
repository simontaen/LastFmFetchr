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
	return [self notNilStringForKeyPath:@"artist"];
}

- (NSNumber *)lfmId
{
	return [self longLongNumberForKeyPath:@"id"];
}

- (NSNumber *)listeners
{
	return [self longLongNumberForKeyPath:@"listeners"];
}

- (NSDate *)releaseDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"d MMMM yyyy, ZZZZZ"];
	
	NSString *dateString = [[self notNilStringForKeyPath:@"releasedate"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	return [formatter dateFromString:[dateString stringByReplacingOccurrencesOfString:@"00:00" withString:@"-00:00"]];
}

- (NSArray *)topTags
{
	return [self tagsFromDictionary:@"toptags"];
}

// TODO: LFMTrack
- (NSArray *)tracks
{
	id obj = [self.JSON valueForKeyPath:@"tracks.track"];
	if (![obj isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *array = (NSArray *)obj;
	NSMutableArray *tracks = [NSMutableArray arrayWithCapacity:[array count]];
	
	for (NSDictionary *dict in array) {
		[tracks addObject:dict];
	}
	
	return tracks;
}

- (NSString *)wikiContent
{
	return [self notNilStringForKeyPath:@"wiki.content"];
}

- (NSDate *)wikiPublishedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	
	return [formatter dateFromString:[self notNilStringForKeyPath:@"wiki.published"]];
}

- (NSString *)wikiSummary
{
	return [self notNilStringForKeyPath:@"wiki.summary"];
}

@end
