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
- (NSString *)artistBioContent
{
	return [self valueForKeyPath:kLFMArtistBio_Content];
}

- (NSString *)artistBioFormation
{
	return [self valueForKeyPath:kLFMArtistBio_FormationList];
}

- (NSString *)artistBioLinks
{
	return [self valueForKeyPath:kLFMArtistBio_Links];
}

- (NSString *)artistBioPlaceFormed
{
	return [self valueForKeyPath:kLFMArtistBio_PlaceFormed];
}

- (NSString *)artistBioPublished
{
	return [self valueForKeyPath:kLFMArtistBio_Published];
}

- (NSString *)artistBioSummary
{
	return [self valueForKeyPath:kLFMArtistBio_Summary];
}

- (NSString *)artistBioYearFormed
{
	return [self valueForKeyPath:kLFMArtistBio_YearFormed];
}

- (NSString *)artistName
{
	return [self valueForKeyPath:kLFMArtistName];
}

- (NSString *)artistLastFmPageURL
{
	return [self valueForKeyPath:kLFMArtistLastFmPageURL];
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

- (NSString *)artistImageMegaURL
{
	return [NSURL URLWithString:[self artistImageMega]];
}

- (NSString *)artistListeners
{
	return [self valueForKeyPath:kLFMArtistListeners];
}

- (NSString *)artistPlaycount
{
	return [self valueForKeyPath:kLFMArtistPlaycount];
}

- (NSString *)artistTags
{
	return [self valueForKeyPath:kLFMArtistTags_List];
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

- (NSString *)artistIsOnTour
{
	return [self valueForKeyPath:kLFMArtistIsOnTour];
}

@end
