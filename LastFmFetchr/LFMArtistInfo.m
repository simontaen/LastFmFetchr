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
	static NSArray *members = nil;
	if (!members) {
		id obj = [self.JSON valueForKeyPath:@"bandmembers.member"];
		if (![obj isKindOfClass:[NSArray class]]) {
			members = [NSArray array];
		} else {
			members = (NSArray *)obj;
		}
	}
	return members;
}

- (NSString *)bioContent
{
	static NSString *bioContent = nil;
	if (!bioContent) {
		bioContent = [self notNilStringForKeyPath:@"bio.content"];
	}
	return bioContent;
}

- (NSArray *)bioFormationYears
{
	static NSArray *bioFormationYears = nil;
	if (!bioFormationYears) {
		id obj = [self.JSON valueForKeyPath:@"bio.formationlist"];
		
		if (![obj isKindOfClass:[NSDictionary class]]) {
			bioFormationYears = [NSArray array];
		} else {
			NSDictionary *dict = (NSDictionary *)obj;
			
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			[formatter setDateFormat:@"yyyy"];
			
			NSDate *yearfrom = [formatter dateFromString:[dict valueForKeyPath:@"formation.yearfrom"]];
			NSDate *yearto = [formatter dateFromString:[dict valueForKeyPath:@"formation.yearto"]];
			
			if (yearfrom && yearto) {
				bioFormationYears = @[yearfrom, yearto];
			} else if (yearfrom) {
				bioFormationYears = @[yearfrom];
			} else {
				bioFormationYears = [NSArray array];
			}
		}
	}
	return bioFormationYears;
}

- (NSURL *)lfmWikiPage
{
	static NSURL *lfmWikiPage = nil;
	if (!lfmWikiPage) {
		id obj = [self.JSON valueForKeyPath:@"bio.links.link"];
		if (![obj isKindOfClass:[NSDictionary class]]) {
			lfmWikiPage = [NSURL URLWithString:kEmpty];
		} else {
			lfmWikiPage = [NSURL URLWithString:((NSDictionary *)obj)[@"href"]];
		}
	}
	return lfmWikiPage;
}

- (NSString *)bioPlaceFormed
{
	static NSString *bioPlaceFormed = nil;
	if (!bioPlaceFormed) {
		bioPlaceFormed = [self notNilStringForKeyPath:@"bio.placeformed"];
	}
	return bioPlaceFormed;
}

- (NSDate *)bioPublishedDate
{
	static NSDate *bioPublishedDate = nil;
	if (!bioPublishedDate) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
		
		bioPublishedDate = [formatter dateFromString:[self notNilStringForKeyPath:@"bio.published"]];
		
	}
	return bioPublishedDate;
}

- (NSString *)bioSummary
{
	static NSString *bioSummary = nil;
	if (!bioSummary) {
		bioSummary = [self notNilStringForKeyPath:@"bio.summary"];
	}
	return bioSummary;
}

- (NSDate *)bioYearFormedDate
{
	static NSDate *bioYearFormedDate = nil;
	if (!bioYearFormedDate) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy"];
		
		bioYearFormedDate = [formatter dateFromString:[self notNilStringForKeyPath:@"bio.yearformed"]];
	}
	return bioYearFormedDate;
}

- (BOOL)isOnTour
{
	return [self boolFromString:[self notNilStringForKeyPath:@"ontour"]];
}

- (NSArray *)similarArtists
{
	static NSArray *similarArtists = nil;
	if (!similarArtists) {
		id obj = [self.JSON valueForKeyPath:@"similar.artist"];
		if (![obj isKindOfClass:[NSArray class]]) {
			similarArtists = [NSArray array];
		} else {
			similarArtists = (NSArray *)obj;
		}
	}
	return similarArtists;
}

- (NSNumber *)listeners
{
	static NSNumber *listeners = nil;
	if (!listeners) {
		listeners = [self longLongNumberForKeyPath:@"stats.listeners"];
	}
	return listeners;
}

- (NSNumber *)playcount
{
	static NSNumber *playcount = nil;
	if (!playcount) {
		playcount = [self longLongNumberForKeyPath:@"stats.playcount"];
	}
	return playcount;
}

- (BOOL)isStreamable
{
	return [self boolFromString:[self notNilStringForKeyPath:@"streamable"]];
}

- (NSArray *)tags
{
	static NSArray *tags = nil;
	if (!tags) {
		tags = [self tagsFromDictionary:@"tags"];
	}
	return tags;
}

@end
