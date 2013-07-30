//
//  LFMAlbumGetInfoDict.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumGetInfoDict.h"
#import "LastFmFetchr.h"

@implementation LFMAlbumGetInfoDict

- (NSString *)albumArtistName
{
	return [self notNilStringForKeyPath:kLFMAlbumArtistName];
}

- (NSString *)albumId
{
	return [self notNilStringForKeyPath:kLFMAlbumId];
}

- (NSNumber *)albumIdNumber
{
	return [NSNumber numberWithLongLong:[[self albumId] longLongValue]];
}

- (NSString *)albumImageSmall
{
	return [self smallImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)albumImageSmallURL
{
	return [NSURL URLWithString:[self albumImageSmall]];
}

- (NSString *)albumImageMedium
{
	return [self mediumImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)albumImageMediumURL
{
	return [NSURL URLWithString:[self albumImageMedium]];
}

- (NSString *)albumImageLarge
{
	return [self largeImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)albumImageLargeURL
{
	return [NSURL URLWithString:[self albumImageLarge]];
}

- (NSString *)albumImageExtraLarge
{
	return [self extraLargeImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)albumImageExtraLargeURL
{
	return [NSURL URLWithString:[self albumImageExtraLarge]];
}

- (NSString *)albumImageMega
{
	return [self megaImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)albumImageMegaURL
{
	return [NSURL URLWithString:[self albumImageMega]];
}

- (NSString *)albumListeners
{
	return [self notNilStringForKeyPath:kLFMAlbumListeners];
}

- (NSNumber *)albumListenersNumber
{
	return [NSNumber numberWithLongLong:[[self albumListeners] longLongValue]];
}

- (NSString *)albumMusicBrianzId
{
	return [self notNilStringForKeyPath:kLFMAlbumMusicBrianzId];
}

- (NSString *)albumName
{
	return [self notNilStringForKeyPath:kLFMAlbumName];
}

- (NSString *)albumPlaycount
{
	return [self notNilStringForKeyPath:kLFMAlbumPlaycount];
}

- (NSNumber *)albumPlaycountNumber
{
	return [NSNumber numberWithLongLong:[[self albumPlaycount] longLongValue]];
}

- (NSString *)albumReleasedate
{
	return [[self notNilStringForKeyPath:kLFMAlbumReleasedate] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSDate *)albumReleasedateDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"d MMMM yyyy, ZZZZZ"];
	
	return [formatter dateFromString:[[self albumReleasedate] stringByReplacingOccurrencesOfString:@"00:00" withString:@"-00:00"]];
}

- (NSString *)albumToptags
{
	return [self notNilStringForKeyPath:kLFMAlbum_Toptags];
}

- (NSArray *)albumToptagNames
{
	return [self tagNamesArrayWithTagListKeyPath:kLFMAlbum_Toptags];
}

- (NSArray *)albumToptagURLs
{
	return [self tagURLsArrayWithTagListKeyPath:kLFMAlbum_Toptags];
}

- (NSString *)albumTracks
{
	return [self notNilStringForKeyPath:kLFMAlbum_Tracks];
}

- (NSArray *)albumTracksArray
{
	id obj = [self valueForKeyPath:kLFMAlbum_Tracks];
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

- (NSString *)albumLastFmPage
{
	return [self notNilStringForKeyPath:kLFMAlbumLastFmPageURL];
}

- (NSURL *)albumLastFmPageURL
{
	return [NSURL URLWithString:[self albumLastFmPage]];
}

- (NSString *)albumWikiContent
{
	return [self notNilStringForKeyPath:kLFMAlbumWiki_Content];
}

- (NSString *)albumWikiPublished
{
	return [self notNilStringForKeyPath:kLFMAlbumWiki_Published];
}

- (NSDate *)albumWikiPublishedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	
	return [formatter dateFromString:[self albumWikiPublished]];
}

- (NSString *)albumWikiSummary
{
	return [self notNilStringForKeyPath:kLFMAlbumWiki_Summary];
}

@end
