//
//  LFMArtistGetInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistInfo.h"

@implementation LFMArtistInfo

#pragma mark - http://www.last.fm/api/show/artist.getInfo

- (NSArray *)members
{
	id obj = [self.JSON valueForKeyPath:@"bandmembers.member"];
	if (![obj isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *array = (NSArray *)obj;
	return array;
}

- (NSString *)bioContent
{
	return [self notNilStringForKeyPath:@"bio.content"];
}

- (NSArray *)bioFormationYears
{
	id obj = [self.JSON valueForKeyPath:@"bio.formationlist"];
	
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSDictionary *dict = (NSDictionary *)obj;
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	
	NSDate *yearfrom = [formatter dateFromString:[dict valueForKeyPath:@"formation.yearfrom"]];
	NSDate *yearto = [formatter dateFromString:[dict valueForKeyPath:@"formation.yearto"]];
	
	if (yearfrom && yearto) {
		return @[yearfrom, yearto];
	} else if (yearfrom) {
		return @[yearfrom];
	} else {
		return [NSArray array];
	}
}

- (NSURL *)lfmWikiPage
{
	id obj = [self.JSON valueForKeyPath:@"bio.links.link"];
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSDictionary *dict = (NSDictionary *)obj;
	
	return [NSURL URLWithString:dict[@"href"]];
}

- (NSString *)bioPlaceFormed
{
	return [self notNilStringForKeyPath:@"bio.placeformed"];
}

- (NSDate *)bioPublishedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	
	return [formatter dateFromString:[self notNilStringForKeyPath:@"bio.published"]];
}

- (NSString *)bioSummary
{
	return [self notNilStringForKeyPath:@"bio.summary"];
}

- (NSDate *)bioYearFormedDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	
	return [formatter dateFromString:[self notNilStringForKeyPath:@"bio.yearformed"]];
}

- (BOOL)isOnTour
{
	return [self boolFromString:[self notNilStringForKeyPath:@"ontour"]];
}

- (NSArray *)similarArtists
{
	id obj = [self.JSON valueForKeyPath:@"similar.artist"];
	if (![obj isKindOfClass:[NSArray class]]) {
		return nil;
	}
	NSArray *lfm = (NSArray *)obj;
	return lfm;
}

- (NSNumber *)listeners
{
	return [self longLongNumberForKeyPath:@"stats.listeners"];
}

- (NSNumber *)playcount
{
	return [self longLongNumberForKeyPath:@"stats.playcount"];
}

- (BOOL)isStreamable
{
	return [self boolFromString:[self notNilStringForKeyPath:@"streamable"]];
}

- (NSArray *)tags
{
	return [self tagsFromDictionary:@"tags"];
}

@end
