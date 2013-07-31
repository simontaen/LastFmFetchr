//
//  LFMAlbumGetInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumGetInfo.h"
#import "LastFmFetchr.h"

@implementation LFMAlbumGetInfo

- (NSString *)artistName
{
	return [self notNilStringForKeyPath:kLFMAlbumArtistName];
}

- (NSString *)identification
{
	return [self notNilStringForKeyPath:kLFMAlbumId];
}

- (NSNumber *)idNumber
{
	return [NSNumber numberWithLongLong:[[self identification] longLongValue]];
}

- (NSString *)listeners
{
	return [self notNilStringForKeyPath:kLFMAlbumListeners];
}

- (NSNumber *)listenersNumber
{
	return [NSNumber numberWithLongLong:[[self listeners] longLongValue]];
}

- (NSString *)imageMega
{
	return [self megaImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)imageMegaURL
{
	return [NSURL URLWithString:[self imageMega]];
}

- (NSString *)releasedate
{
	return [[self notNilStringForKeyPath:kLFMAlbumReleasedate] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSDate *)releasedateDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"d MMMM yyyy, ZZZZZ"];
	
	return [formatter dateFromString:[[self releasedate] stringByReplacingOccurrencesOfString:@"00:00" withString:@"-00:00"]];
}

- (NSString *)toptags
{
	return [self notNilStringForKeyPath:kLFMAlbum_Toptags];
}

- (NSArray *)toptagNames
{
	return [self tagNamesArrayWithTagListKeyPath:kLFMAlbum_Toptags];
}

- (NSArray *)toptagURLs
{
	return [self tagURLsArrayWithTagListKeyPath:kLFMAlbum_Toptags];
}

- (NSString *)tracks
{
	return [self notNilStringForKeyPath:kLFMAlbum_Tracks];
}

- (NSArray *)tracksArray
{
	id obj = [self.JSON valueForKeyPath:kLFMAlbum_Tracks];
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
	return [self notNilStringForKeyPath:kLFMAlbumWiki_Content];
}

- (NSString *)wikiPublished
{
	return [self notNilStringForKeyPath:kLFMAlbumWiki_Published];
}

- (NSDate *)wikiPublishedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	
	return [formatter dateFromString:[self wikiPublished]];
}

- (NSString *)wikiSummary
{
	return [self notNilStringForKeyPath:kLFMAlbumWiki_Summary];
}

@end
