//
//  LFMArtistInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtistInfo.h"

@implementation LFMArtistInfo

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSDictionary *mapping =  @{
							   @"members" : @"bandmembers",
							   @"bioContent" : @"bio.content",
							   @"bioFormationYears" : @"bio.formationlist",
							   @"lfmWikiPage" : @"bio.links.link.href",
							   @"bioPlaceFormed" : @"bio.placeformed",
							   @"bioPublishedDate" : @"bio.published",
							   @"bioSummary" : @"bio.summary",
							   @"bioYearFormedDate" : @"bio.yearformed",
							   @"isOnTour" : @"ontour",
							   @"similarArtists" : @"similar",
							   @"listeners" : @"stats.listeners",
							   @"playcount" : @"stats.playcount",
							   @"isStreamable" : @"streamable",
							   @"tags" : @"tags"
							   };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}


@end
