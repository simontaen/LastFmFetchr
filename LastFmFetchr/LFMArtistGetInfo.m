//
//  LFMArtistGetInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistGetInfo.h"
#import "LastFmFetchr.h"

@implementation LFMArtistGetInfo

- (NSString *)members
{
	return [self notNilStringForKeyPath:kLFMArtist_Members];
}

- (NSArray *)memberArray
{
	id obj = [self members];
	if (![obj isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *array = (NSArray *)obj;
	return array;
}

- (NSString *)bioContent
{
	return [self notNilStringForKeyPath:kLFMArtistBio_Content];
}

- (NSString *)bioFormationYears
{
	return [self notNilStringForKeyPath:kLFMArtistBio_FormationYears];
}

- (NSArray *)bioFormationYearDates
{
	id obj = [self.JSON valueForKeyPath:kLFMArtistBio_FormationYears];
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSDictionary *dict = (NSDictionary *)obj;
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	
	return @[[formatter dateFromString:dict[@"yearfrom"]], [formatter dateFromString:dict[@"yearto"]]];
}

- (NSString *)bioLink
{
	return [self notNilStringForKeyPath:kLFMArtistBio_Link];
}

- (NSURL *)bioLinkURL
{
	id obj = [self.JSON valueForKeyPath:kLFMArtistBio_Link];
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSDictionary *dict = (NSDictionary *)obj;
	
	return [NSURL URLWithString:dict[@"href"]];
}

- (NSString *)bioPlaceFormed
{
	return [self notNilStringForKeyPath:kLFMArtistBio_PlaceFormed];
}

- (NSString *)bioPublished
{
	return [self notNilStringForKeyPath:kLFMArtistBio_Published];
}

- (NSDate *)bioPublishedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	
	return [formatter dateFromString:[self bioPublished]];
}

- (NSString *)bioSummary
{
	return [self notNilStringForKeyPath:kLFMArtistBio_Summary];
}

- (NSString *)bioYearFormed
{
	return [self notNilStringForKeyPath:kLFMArtistBio_YearFormed];
}

- (NSDate *)bioYearFormedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	
	return [formatter dateFromString:[self bioYearFormed]];
}

- (NSString *)imageSmall
{
	return [self smallImageForImageListKeyPath:kLFMArtistImageList];
}

- (NSURL *)imageSmallURL
{
	return [NSURL URLWithString:[self imageSmall]];
}

- (NSString *)imageMedium
{
	return [self mediumImageForImageListKeyPath:kLFMArtistImageList];
}

- (NSURL *)imageMediumURL
{
	return [NSURL URLWithString:[self imageMedium]];
}

- (NSString *)imageLarge
{
	return [self largeImageForImageListKeyPath:kLFMArtistImageList];
}

- (NSURL *)imageLargeURL
{
	return [NSURL URLWithString:[self imageLarge]];
}

- (NSString *)imageExtraLarge
{
	return [self extraLargeImageForImageListKeyPath:kLFMArtistImageList];
}

- (NSURL *)imageExtraLargeURL
{
	return [NSURL URLWithString:[self imageExtraLarge]];
}

- (NSString *)imageMega
{
	return [self megaImageForImageListKeyPath:kLFMArtistImageList];
}

- (NSURL *)imageMegaURL
{
	return [NSURL URLWithString:[self imageMega]];
}

- (NSString *)musicBrianzId
{
	return [self notNilStringForKeyPath:kLFMArtistMusicBrianzId];
}

- (NSString *)name
{
	return [self notNilStringForKeyPath:kLFMArtistName];
}

- (NSString *)isOnTour
{
	return [self notNilStringForKeyPath:kLFMArtistIsOnTour];
}

- (BOOL)isOnTourBool
{
	if ([@"1" isEqual:[self isOnTour]]) {
		return YES;
	}
	return NO;
}

- (NSString *)similarArtists
{
	return [self notNilStringForKeyPath:kLFMArtist_SimilarArtists];
}

- (NSArray *)similarArtistsArray
{
	id obj = [self.JSON valueForKeyPath:kLFMArtist_SimilarArtists];
	if (![obj isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *lfm = (NSArray *)obj;
	return lfm;
}

- (NSString *)listeners
{
	return [self notNilStringForKeyPath:kLFMArtistStats_Listeners];
}

- (NSNumber *)listenersNumber
{
	return [NSNumber numberWithLongLong:[[self listeners] longLongValue]];
}

- (NSString *)playcount
{
	return [self notNilStringForKeyPath:kLFMArtistStats_Playcount];
}

- (NSNumber *)playcountNumber
{
	return [NSNumber numberWithLongLong:[[self playcount] longLongValue]];
}

- (NSString *)streamable
{
	return [self notNilStringForKeyPath:kLFMArtistStreamable];
}

- (BOOL)streamableBool
{
	if ([@"1" isEqual:[self streamable]]) {
		return YES;
	}
	return NO;
}

- (NSString *)tags
{
	return [self notNilStringForKeyPath:kLFMArtist_Tags];
}

- (NSArray *)tagNames
{
	return [self tagNamesArrayWithTagListKeyPath:kLFMArtist_Tags];
}

- (NSArray *)tagURLs
{
	return [self tagURLsArrayWithTagListKeyPath:kLFMArtist_Tags];
}

- (NSString *)lastFmPage
{
	return [self notNilStringForKeyPath:kLFMArtistLastFmPageURL];
}

- (NSURL *)lastFmPageURL
{
	return [NSURL URLWithString:[self lastFmPage]];
}

@end
