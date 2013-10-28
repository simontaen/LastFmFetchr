//
//  LFMArtistGetInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistGetInfo.h"
#import "LastFmFetchr.h"
#import "KZPropertyMapper.h"

@implementation LFMArtistGetInfo

- (instancetype)initWithJson:(NSDictionary *)JSON {
    self = [super initWithJson:JSON];
    if (self) {
		[KZPropertyMapper mapValuesFrom:JSON
							 toInstance:self
						   usingMapping:@{
										  @"bandmembers" : @{ // TODO: LFMMember
												  @"member" : KZProperty(members)
												  },
										  @"bio" : @{
												  @"content" : KZProperty(bioContent),
												  @"formationlist" : KZCall(bioFormationYearsFromString:, bioFormationYears),
												  @"links.link.href" : KZBox(URL, lastFmWikiPage),
												  @"placeformed" : KZProperty(bioPlaceFormed),
												  @"published" : KZCall(bioPublishedDateFromString:, bioPublishedDate),
												  @"summary" : KZProperty(bioSummary),
												  @"yearformed" : KZCall(bioYearFormedDateFromString:, bioYearFormedDate)
										  },
										  @"image" : @{
												  @0 : @{ @"#text" : KZBox(URL, imageSmall) },
												  @1 : @{ @"#text" : KZBox(URL, imageMedium) },
												  @2 : @{ @"#text" : KZBox(URL, imageLarge) },
												  @3 : @{ @"#text" : KZBox(URL, imageExtraLarge) },
												  @4 : @{ @"#text" : KZBox(URL, imageMega) }
												  },
										  @"mbid" : KZProperty(musicBrianzId),
										  @"name" : KZProperty(name),
										  @"ontour" : KZCall(isOnTourFromString:, isOnTour),
										  @"similar" : @{ // TODO: LFMArtistSuperclass
												  @"artist" : KZProperty(similarArtists)
												  },
										  @"stats" : @{
												  @"listeners" : KZProperty(listeners),
												  @"playcount" : KZProperty(playcount)
												  },
										  @"streamable" : KZCall(isStreamableFromString:, isStreamable),
										  // TODO: tagNames and tagURLs need separate handler
										  // also you should create an LFMTag class so I could return an array
										  @"url" : KZProperty(lastFmPage)
										  }];
    }
    return self;
}

#pragma mark - Private Methods

- (NSArray *)bioFormationYearsFromString:(NSString *)string
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

- (NSDate *)bioPublishedDateFromString:(NSString *)publishedString
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	
	return [formatter dateFromString:publishedString];
}

- (NSDate *)bioYearFormedDateFromString:(NSString *)yearFormedString
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	
	return [formatter dateFromString:yearFormedString];
}

- (BOOL)isOnTourFromString:(NSString *)onTourString
{
	if ([@"1" isEqual:onTourString]) {
		return YES;
	}
	return NO;
}

- (BOOL)isStreamableFromString:(NSString *)streamableString
{
	if ([@"1" isEqual:streamableString]) {
		return YES;
	}
	return NO;
}

@end
