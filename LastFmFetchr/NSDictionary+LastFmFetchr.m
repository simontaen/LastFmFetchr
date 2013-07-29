//
//  NSDictionary+LastFmFetchr.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 24/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

// IDEA, either create a new Dictionary with better keys (preload work)
// OR provide an NSDictionary category for accessing the data (work on demand, but usually NOT repeated)
// It seems like the NSDictionary cat would be a better option
// easy for the User, NOT subject to changes on the API data returned
// still gives the user the freedom to dig around himself

// NSLog(@"kLFMArtistImage with mod %@", JSON[kLFMArtistImageList][3][@"#text"]);

// http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns

NSString *const kEmpty = @"";

#import "NSDictionary+LastFmFetchr.h"
#import "LastFmFetchr.h"

@implementation NSDictionary (LastFmFetchr)

// ----------------------------------------------------------------------
// HELPERS
// ----------------------------------------------------------------------
- (NSArray *)tagNamesArrayWithTagListKeyPath:(NSString *)tagListKeyPath
{
	id obj = [self valueForKeyPath:tagListKeyPath];
	if (![obj isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *array = (NSArray *)obj;
	NSMutableArray *tags = [NSMutableArray arrayWithCapacity:[array count]];
	
	for (NSDictionary *dict in array) {
		[tags addObject:[dict[@"name"] description]];
	}
	return tags;
}

- (NSArray *)tagURLsArrayWithTagListKeyPath:(NSString *)tagListKeyPath
{
	id obj = [self valueForKeyPath:tagListKeyPath];
	if (![obj isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *array = (NSArray *)obj;
	NSMutableArray *tags = [NSMutableArray arrayWithCapacity:[array count]];
	
	for (NSDictionary *dict in array) {
		[tags addObject:[NSURL URLWithString:[dict[@"url"] description]]];
	}
	
	return tags;
}

- (NSString *)smallImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[0][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)mediumImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[1][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)largeImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[2][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)extraLargeImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[3][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)megaImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[4][@"#text"] description];
	}
	return kEmpty;
}


// ----------------------------------------------------------------------
// artist.getInfo
// ----------------------------------------------------------------------
- (NSString *)artistMembers
{
	return [self notNilStringForKeyPath:kLFMArtist_Members];
}

- (NSArray *)artistMemberArray
{
	id obj = [self artistMembers];
	if (![obj isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *array = (NSArray *)obj;
	return array;
}

- (NSString *)artistBioContent
{
	return [self notNilStringForKeyPath:kLFMArtistBio_Content];
}

- (NSString *)artistBioFormationYears
{
	return [self notNilStringForKeyPath:kLFMArtistBio_FormationYears];
}

- (NSArray *)artistBioFormationYearDates
{
	id obj = [self valueForKeyPath:kLFMArtistBio_FormationYears];
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSDictionary *dict = (NSDictionary *)obj;
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	
	return @[[formatter dateFromString:dict[@"yearfrom"]], [formatter dateFromString:dict[@"yearto"]]];
}

- (NSString *)artistBioLink
{
	return [self notNilStringForKeyPath:kLFMArtistBio_Link];
}

- (NSURL *)artistBioLinkURL
{
	id obj = [self valueForKeyPath:kLFMArtistBio_Link];
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSDictionary *dict = (NSDictionary *)obj;
	
	return [NSURL URLWithString:dict[@"href"]];
}

- (NSString *)artistBioPlaceFormed
{
	return [self notNilStringForKeyPath:kLFMArtistBio_PlaceFormed];
}

- (NSString *)artistBioPublished
{
	return [self notNilStringForKeyPath:kLFMArtistBio_Published];
}

- (NSDate *)artistBioPublishedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	
	return [formatter dateFromString:[self artistBioPublished]];
}

- (NSString *)artistBioSummary
{
	return [self notNilStringForKeyPath:kLFMArtistBio_Summary];
}

- (NSString *)artistBioYearFormed
{
	return [self notNilStringForKeyPath:kLFMArtistBio_YearFormed];
}

- (NSDate *)artistBioYearFormedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	
	return [formatter dateFromString:[self artistBioYearFormed]];
}

- (NSString *)artistImageSmall
{
	return [self smallImageForImageListKeyPath:kLFMArtistImageList];
}

- (NSURL *)artistImageSmallURL;
{
	return [NSURL URLWithString:[self artistImageSmall]];
}

- (NSString *)artistImageMedium
{
	return [self mediumImageForImageListKeyPath:kLFMArtistImageList];
}

- (NSURL *)artistImageMediumURL;
{
	return [NSURL URLWithString:[self artistImageMedium]];
}

- (NSString *)artistImageLarge
{
	return [self largeImageForImageListKeyPath:kLFMArtistImageList];
}

- (NSURL *)artistImageLargeURL;
{
	return [NSURL URLWithString:[self artistImageLarge]];
}

- (NSString *)artistImageExtraLarge
{
	return [self extraLargeImageForImageListKeyPath:kLFMArtistImageList];
}

- (NSURL *)artistImageExtraLargeURL;
{
	return [NSURL URLWithString:[self artistImageExtraLarge]];
}

- (NSString *)artistImageMega
{
	return [self megaImageForImageListKeyPath:kLFMArtistImageList];
}

- (NSURL *)artistImageMegaURL
{
	return [NSURL URLWithString:[self artistImageMega]];
}

- (NSString *)artistMusicBrianzId
{
	return [self notNilStringForKeyPath:kLFMArtistMusicBrianzId];
}

- (NSString *)artistName
{
	return [self notNilStringForKeyPath:kLFMArtistName];
}

- (NSString *)artistIsOnTour
{
	return [self notNilStringForKeyPath:kLFMArtistIsOnTour];
}

- (BOOL)artistIsOnTourBool
{
	if ([@"1" isEqual:[self artistIsOnTour]]) {
		return YES;
	}
	return NO;
}

- (NSString *)artistSimilarArtists
{
	return [self notNilStringForKeyPath:kLFMArtist_SimilarArtists];
}

- (NSArray *)artistSimilarArtistsArray
{
	id obj = [self valueForKeyPath:kLFMArtist_SimilarArtists];
	if (![obj isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *lfm = (NSArray *)obj;
	return lfm;
}

- (NSString *)artistListeners
{
	return [self notNilStringForKeyPath:kLFMArtistStats_Listeners];
}

- (NSNumber *)artistListenersNumber
{
	return [NSNumber numberWithLongLong:[[self artistListeners] longLongValue]];
}

- (NSString *)artistPlaycount
{
	return [self notNilStringForKeyPath:kLFMArtistStats_Playcount];
}

- (NSNumber *)artistPlaycountNumber;
{
	return [NSNumber numberWithLongLong:[[self artistPlaycount] longLongValue]];
}

- (NSString *)artistStreamable
{
	return [self notNilStringForKeyPath:kLFMArtistStreamable];
}

- (BOOL)artistStreamableBool
{
	if ([@"1" isEqual:[self artistStreamable]]) {
		return YES;
	}
	return NO;
}

- (NSString *)artistTags
{
	return [self notNilStringForKeyPath:kLFMArtist_Tags];
}

- (NSArray *)artistTagNames
{
	return [self tagNamesArrayWithTagListKeyPath:kLFMArtist_Tags];
}

- (NSArray *)artistTagURLs
{
	return [self tagURLsArrayWithTagListKeyPath:kLFMArtist_Tags];
}

- (NSString *)artistLastFmPage
{
	return [self notNilStringForKeyPath:kLFMArtistLastFmPageURL];
}

- (NSURL *)artistLastFmPageURL
{
	return [NSURL URLWithString:[self artistLastFmPage]];
}

- (NSString *)notNilStringForKeyPath:(NSString *)keyPath
{
	id obj = [self valueForKeyPath:keyPath];
	if (obj) {
		return [obj description];
	}
	return kEmpty;
}


// ----------------------------------------------------------------------
// album.getInfo
// ----------------------------------------------------------------------
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


// ----------------------------------------------------------------------
// artist.getTopAlbums
// ----------------------------------------------------------------------
- (NSArray *)albumArtistsAlbumList
{
	id obj = [self valueForKeyPath:kLFMAlbum_ArtistsAlbumList];
	if ([obj isKindOfClass:[NSArray class]]) {
		return obj;
	}
	return nil;
}


- (NSString *)albumRankInAllArtistAlbums
{
	return [self notNilStringForKeyPath:kLFMAlbum_RankInAllArtistAlbums];
}


- (NSNumber *)albumRankInAllArtistAlbumsNumber
{
	return [NSNumber numberWithInt:[[self albumRankInAllArtistAlbums] intValue]];
}

@end
