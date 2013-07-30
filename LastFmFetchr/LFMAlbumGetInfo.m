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

- (NSString *)imageSmall
{
	return [self smallImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)imageSmallURL
{
	return [NSURL URLWithString:[self imageSmall]];
}

- (NSString *)imageMedium
{
	return [self mediumImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)imageMediumURL
{
	return [NSURL URLWithString:[self imageMedium]];
}

- (NSString *)imageLarge
{
	return [self largeImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)imageLargeURL
{
	return [NSURL URLWithString:[self imageLarge]];
}

- (NSString *)imageExtraLarge
{
	return [self extraLargeImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)imageExtraLargeURL
{
	return [NSURL URLWithString:[self imageExtraLarge]];
}

- (NSString *)imageMega
{
	return [self megaImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)imageMegaURL
{
	return [NSURL URLWithString:[self imageMega]];
}

- (NSString *)listeners
{
	return [self notNilStringForKeyPath:kLFMAlbumListeners];
}

- (NSNumber *)listenersNumber
{
	return [NSNumber numberWithLongLong:[[self listeners] longLongValue]];
}

- (NSString *)musicBrianzId
{
	return [self notNilStringForKeyPath:kLFMAlbumMusicBrianzId];
}

- (NSString *)name
{
	return [self notNilStringForKeyPath:kLFMAlbumName];
}

- (NSString *)playcount
{
	return [self notNilStringForKeyPath:kLFMAlbumPlaycount];
}

- (NSNumber *)playcountNumber
{
	return [NSNumber numberWithLongLong:[[self playcount] longLongValue]];
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

- (NSString *)lastFmPage
{
	return [self notNilStringForKeyPath:kLFMAlbumLastFmPageURL];
}

- (NSURL *)lastFmPageURL
{
	return [NSURL URLWithString:[self lastFmPage]];
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
