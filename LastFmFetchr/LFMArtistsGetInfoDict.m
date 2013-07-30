//
//  LFMArtistsGetInfoDict.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistsGetInfoDict.h"
#import "LastFmFetchr.h"

@implementation LFMArtistsGetInfoDict

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

@end
