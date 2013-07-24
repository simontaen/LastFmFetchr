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
	return [self valueForKeyPath:kLFMArtist_Members];
}

- (NSString *)artistMemberArray
{
	return [self artistMembers];
}

- (NSString *)artistBioContent
{
	return [self valueForKeyPath:kLFMArtistBio_Content];
}

- (NSString *)artistBioFormationYears
{
	return [self valueForKeyPath:kLFMArtistBio_FormationYears];
}

- (NSArray *)artistBioFormationYearDates
{
	NSString *str = [self artistBioFormationYears];
	if (![str isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSDictionary *lfm = (NSDictionary *)str;

	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	
	return @[[formatter dateFromString:lfm[@"yearfrom"]], [formatter dateFromString:lfm[@"yearto"]]];
}

- (NSString *)artistBioLink
{
	return [self valueForKeyPath:kLFMArtistBio_Link];
}

- (NSURL *)artistBioLinkURL
{
	NSString *str = [self artistBioLink];
	if (![str isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSDictionary *lfm = (NSDictionary *)str;

	return [NSURL URLWithString:lfm[@"href"]];
}

- (NSString *)artistBioPlaceFormed
{
	return [self valueForKeyPath:kLFMArtistBio_PlaceFormed];
}

- (NSString *)artistBioPublished
{
	return [self valueForKeyPath:kLFMArtistBio_Published];
}

- (NSDate *)artistBioPublishedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	
	return [formatter dateFromString:[self artistBioPublished]];
}

- (NSString *)artistBioSummary
{
	return [self valueForKeyPath:kLFMArtistBio_Summary];
}

- (NSString *)artistBioYearFormed
{
	return [self valueForKeyPath:kLFMArtistBio_YearFormed];
}

- (NSDate *)artistBioYearFormedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	
	return [formatter dateFromString:[self artistBioYearFormed]];
}

- (NSString *)artistImageSmall
{
	return [self valueForKeyPath:kLFMArtistImageList][0][@"#text"];
}

- (NSURL *)artistImageSmallURL;
{
	return [NSURL URLWithString:[self artistImageSmall]];
}

- (NSString *)artistImageMedium
{
	return [self valueForKeyPath:kLFMArtistImageList][1][@"#text"];
}

- (NSURL *)artistImageMediumURL;
{
	return [NSURL URLWithString:[self artistImageMedium]];
}

- (NSString *)artistImageLarge
{
	return [self valueForKeyPath:kLFMArtistImageList][2][@"#text"];
}

- (NSURL *)artistImageLargeURL;
{
	return [NSURL URLWithString:[self artistImageLarge]];
}

- (NSString *)artistImageExtraLarge
{
	return [self valueForKeyPath:kLFMArtistImageList][3][@"#text"];
}

- (NSURL *)artistImageExtraLargeURL;
{
	return [NSURL URLWithString:[self artistImageExtraLarge]];
}

- (NSString *)artistImageMega
{
	return [self valueForKeyPath:kLFMArtistImageList][4][@"#text"];
}

- (NSURL *)artistImageMegaURL
{
	return [NSURL URLWithString:[self artistImageMega]];
}

- (NSString *)artistMusicBrianzId
{
	return [self valueForKeyPath:kLFMArtistMusicBrianzId];
}

- (NSString *)artistName
{
	return [self valueForKeyPath:kLFMArtistName];
}

- (NSString *)artistIsOnTour
{
	return [self valueForKeyPath:kLFMArtistIsOnTour];
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
	return [self valueForKeyPath:kLFMArtist_SimilarArtists];
}

- (NSArray *)artistSimilarArtistsArray
{
	return [self artistSimilarArtists];
}

- (NSString *)artistListeners
{
	return [self valueForKeyPath:kLFMArtistStats_Listeners];
}

- (NSNumber *)artistListenersNumber
{
	return [NSNumber numberWithLongLong:[[self artistListeners] longLongValue]];
}

- (NSString *)artistPlaycount
{
	return [self valueForKeyPath:kLFMArtistStats_Playcount];
}

- (NSNumber *)artistPlaycountNumber;
{
	return [NSNumber numberWithLongLong:[[self artistPlaycount] longLongValue]];
}

- (NSString *)artistStreamable
{
	return [self valueForKeyPath:kLFMArtistStreamable];
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
	return [self valueForKeyPath:kLFMArtist_Tags];
}

- (NSArray *)artistTagNames
{
	NSString *str = [self artistTags];
	if (![str isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *lfm = (NSArray *)str;
	NSMutableArray *tags = [NSMutableArray array];
	
	for (NSDictionary *entry in lfm) {
		[tags addObject:[NSString stringWithString:entry[@"name"]]];
	}
	
	return tags;
}

- (NSArray *)artistTagURLs
{
	NSString *str = [self artistTags];
	if (![str isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *lfm = (NSArray *)str;
	NSMutableArray *tags = [NSMutableArray array];
	
	for (NSDictionary *entry in lfm) {
		[tags addObject:[NSURL URLWithString:entry[@"url"]]];
	}
	
	return tags;
}

- (NSString *)artistLastFmPage
{
	return [self valueForKeyPath:kLFMArtistLastFmPageURL];
}

- (NSURL *)artistLastFmPageURL
{
	return [NSURL URLWithString:[self artistLastFmPage]];
}

@end
