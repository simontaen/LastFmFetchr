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
	NSString *contentKey = [self contentKey];
	
	NSDictionary *mapping =
	@{
	  //TODO
	  //@"members" : [contentKey stringByAppendingFormat:@"bandmembers"],
	  @"bioContent" : [contentKey stringByAppendingFormat:@"bio.content"],
	  @"bioFormationYears" : [contentKey stringByAppendingFormat:@"bio.formationlist"],
	  @"lfmWikiPage" : [contentKey stringByAppendingFormat:@"bio.links.link.href"],
	  @"bioPlaceFormed" : [contentKey stringByAppendingFormat:@"bio.placeformed"],
	  @"bioPublishedDate" : [contentKey stringByAppendingFormat:@"bio.published"],
	  @"bioSummary" : [contentKey stringByAppendingFormat:@"bio.summary"],
	  @"bioYearFormedDate" : [contentKey stringByAppendingFormat:@"bio.yearformed"],
	  @"isOnTour" : [contentKey stringByAppendingFormat:@"ontour"],
	  // TODO
	  //@"similarArtists" : [contentKey stringByAppendingFormat:@"similar"],
	  @"listeners" : [contentKey stringByAppendingFormat:@"stats.listeners"],
	  @"playcount" : [contentKey stringByAppendingFormat:@"stats.playcount"],
	  @"isStreamable" : [contentKey stringByAppendingFormat:@"streamable"],
	  @"tags" : [contentKey stringByAppendingFormat:@"tags.tag"]
	  };
	
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
}


@end
