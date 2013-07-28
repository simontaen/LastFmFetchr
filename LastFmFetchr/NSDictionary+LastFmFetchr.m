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

NSString *const kEmpty = @"";

#import "NSDictionary+LastFmFetchr.h"
#import "LastFmFetchr.h"

@implementation NSDictionary (LastFmFetchr)

// artist.getInfo
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
	id obj = [self valueForKeyPath:kLFMArtistImageList];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[0][@"#text"] description];
	}
	return kEmpty;
}

- (NSURL *)artistImageSmallURL;
{
	return [NSURL URLWithString:[self artistImageSmall]];
}

- (NSString *)artistImageMedium
{
	id obj = [self valueForKeyPath:kLFMArtistImageList];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[1][@"#text"] description];
	}
	return kEmpty;
}

- (NSURL *)artistImageMediumURL;
{
	return [NSURL URLWithString:[self artistImageMedium]];
}

- (NSString *)artistImageLarge
{
	id obj = [self valueForKeyPath:kLFMArtistImageList];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[2][@"#text"] description];
	}
	return kEmpty;
}

- (NSURL *)artistImageLargeURL;
{
	return [NSURL URLWithString:[self artistImageLarge]];
}

- (NSString *)artistImageExtraLarge
{
	id obj = [self valueForKeyPath:kLFMArtistImageList];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[3][@"#text"] description];
	}
	return kEmpty;
}

- (NSURL *)artistImageExtraLargeURL;
{
	return [NSURL URLWithString:[self artistImageExtraLarge]];
}

- (NSString *)artistImageMega
{
	id obj = [self valueForKeyPath:kLFMArtistImageList];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[4][@"#text"] description];
	}
	return kEmpty;
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
	id obj = [self valueForKeyPath:kLFMArtist_Tags];
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

- (NSArray *)artistTagURLs
{
	id obj = [self valueForKeyPath:kLFMArtist_Tags];
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

@end
