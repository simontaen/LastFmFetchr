//
//  LFMData.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"
#import "LastFmFetchr.h"

@implementation LFMData

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	NSDictionary *dict = nil;
	
	if ([self.class instancesRespondToSelector:@selector(imageSmall)]) {
		dict = @{
				 @"imageSmall" : [contentKey stringByAppendingFormat:@"image"],
				 @"imageMedium" : [contentKey stringByAppendingFormat:@"image"],
				 @"imageLarge" : [contentKey stringByAppendingFormat:@"image"],
				 @"imageExtraLarge" : [contentKey stringByAppendingFormat:@"image"],
				 @"imageSmallString" : [contentKey stringByAppendingFormat:@"image"],
				 @"imageMediumString" : [contentKey stringByAppendingFormat:@"image"],
				 @"imageLargeString" : [contentKey stringByAppendingFormat:@"image"],
				 @"imageExtraLargeString" : [contentKey stringByAppendingFormat:@"image"]
				 };
		
		if ([self.class instancesRespondToSelector:@selector(imageMega)]) {
			dict = [dict mtl_dictionaryByAddingEntriesFromDictionary:
					@{
					  @"imageMega" : [contentKey stringByAppendingFormat:@"image"],
					  @"imageMegaString" : [contentKey stringByAppendingFormat:@"image"]
					  }];
		}
	}
	
    return dict;
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
{
	// NOTE only handle top level keys here where the JSONDictionary comes directly from the API.
	// Drop to subclasses if you have nested objects
	
	if (JSONDictionary[@"corrections"] != nil) {
		[self setContentKey:[@[@"corrections", @"correction", @"artist", @""] componentsJoinedByString:kDelim]];
        return LFMArtist.class;
    }
	
	if (JSONDictionary[@"artist"] != nil) {
		[self setContentKey:[@"artist" stringByAppendingString:kDelim] ];
        return LFMArtistInfo.class;
    }
	
	if (JSONDictionary[@"album"] != nil) {
		[self setContentKey:[@"album" stringByAppendingString:kDelim]];
        return LFMAlbumInfo.class;
    }
	
	if (JSONDictionary[@"topalbums"] != nil) {
		[self setContentKey:[@"topalbums" stringByAppendingString:kDelim]];
		return LFMArtistsTopAlbums.class;
	}
	
	if (JSONDictionary[@"artists"] != nil) {
		[self setContentKey:[@"artists" stringByAppendingString:kDelim]];
		return LFMChartTopArtists.class;
	}
	
	return self.class;
}

static NSString *contentKey = nil;

+ (void)setContentKey:(NSString *)key
{
	@synchronized(self) {
		contentKey = key;
	}
}

+ (NSString *)contentKey
{
	@synchronized(self) {
		return contentKey;
	}
}

#pragma mark - <key>JSONTransformer

+ (NSValueTransformer *)lfmPageJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)bioFormationYearsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *dict) {
		if (![dict isKindOfClass:[NSDictionary class]] || ![dict count]) {
			return [NSArray array];
		} else {
			// Check format for formation, could be an array
			//			NSString *fromStr = [dict valueForKeyPath:@"formation.yearfrom"];
			//			NSDate *yearfrom = [self.yearformedDateFormatter dateFromString:fromStr];
			//			NSString *toStr = [dict valueForKeyPath:@"formation.yearto"];
			//			NSDate *yearto = [self.yearformedDateFormatter dateFromString:toStr];
			//
			//			if (yearfrom && yearto) {
			//				return @[yearfrom, yearto];
			//			} else if (yearfrom) {
			//				return @[yearfrom];
			//			}
			return [NSArray array];
		}
    } reverseBlock:^(NSArray *array) {
		// TODO: what to do here?
		return [array description];
    }];
}

+ (NSValueTransformer *)lfmWikiPageJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)bioPublishedDateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.publishedDateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
		return [self.publishedDateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)bioYearFormedDateJSONTransformer
{
	return [LFMMember yearDateTransformer];
}

+ (NSValueTransformer *)isOnTourJSONTransformer
{
	return [LFMData boolTransformer];
}

+ (NSValueTransformer *)similarArtistsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *array) {
		if (![array isKindOfClass:[NSArray class]] || ![array count]) {
			return [NSArray array];
		} else {
			NSMutableArray *mutableArtists = [NSMutableArray arrayWithCapacity:[array count]];
			for (id aArtist in array) {
				if ([aArtist isKindOfClass:[NSDictionary class]]) {
					// TOOD: handle error
					LFMArtist *lfmArtist = [MTLJSONAdapter modelOfClass:LFMArtist.class
													 fromJSONDictionary:aArtist
																  error:nil];
					[mutableArtists addObject:lfmArtist];
				}
			}
			return [NSArray arrayWithArray:mutableArtists];
		}
    } reverseBlock:^(NSArray *array) {
		// TODO: what to do here?
		return array;
    }];
}

+ (NSValueTransformer *)listenersJSONTransformer
{
	return [LFMData numberTransformer];
}

+ (NSValueTransformer *)playcountJSONTransformer
{
	return [LFMData numberTransformer];
}

+ (NSValueTransformer *)isStreamableJSONTransformer
{
	return [LFMData boolTransformer];
}

+ (NSValueTransformer *)wikiPublishedDateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.publishedDateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
		return [self.publishedDateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)releaseDateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
		NSString *string = [str stringByReplacingOccurrencesOfString:@"00:00" withString:@"-00:00"];
        return [self.releaseDateFormatter dateFromString:string];
    } reverseBlock:^(NSDate *date) {
        NSString *string = [self.releaseDateFormatter stringFromDate:date];
		return [string stringByReplacingOccurrencesOfString:@"-00:00" withString:@"00:00"];
    }];
}

+ (NSValueTransformer *)rankInAllArtistAlbumsJSONTransformer
{
	return [LFMData rankJSONTransformer];
}

+ (NSValueTransformer *)rankJSONTransformer
{
	return [LFMData numberTransformer];
}

+ (NSValueTransformer *)artistJSONTransformer
{
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:LFMArtist.class];
}

+ (NSValueTransformer *)albumsJSONTransformer
{
	return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *array) {
		if (![array isKindOfClass:[NSArray class]] || ![array count]) {
			return [NSArray array];
		} else {
			NSMutableArray *mutableAlbums = [NSMutableArray arrayWithCapacity:[array count]];
			for (id aAlbum in array) {
				if ([aAlbum isKindOfClass:[NSDictionary class]]) {
					// TOOD: handle error
					LFMAlbumTopAlbum *topAlbum = [MTLJSONAdapter modelOfClass:LFMAlbum.class
														   fromJSONDictionary:aAlbum
																		error:nil];
					[mutableAlbums addObject:topAlbum];
				}
			}
			return [NSArray arrayWithArray:mutableAlbums];
		}
	} reverseBlock:^(NSArray *array) {
		// TODO: what to do here?
		return array;
	}];
}

+ (NSValueTransformer *)artistsJSONTransformer
{
	return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *array) {
		if (![array isKindOfClass:[NSArray class]] || ![array count]) {
			return [NSArray array];
		} else {
			NSMutableArray *mutableArtists = [NSMutableArray arrayWithCapacity:[array count]];
			for (id aArtist in array) {
				if ([aArtist isKindOfClass:[NSDictionary class]]) {
					// TOOD: handle error
					LFMArtistChart *artist = [MTLJSONAdapter modelOfClass:LFMArtistChart.class
												  fromJSONDictionary:aArtist
																		error:nil];
					[mutableArtists addObject:artist];
				}
			}
			return [NSArray arrayWithArray:mutableArtists];
		}
	} reverseBlock:^(NSArray *array) {
		// TODO: what to do here?
		return array;
	}];
}

+ (NSValueTransformer *)tagsJSONTransformer
{
	return [LFMData tagsTransformer];
}

+ (NSValueTransformer *)topTagsJSONTransformer
{
	return [LFMData tagsTransformer];
}

+ (NSValueTransformer *)tracksJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *array) {
		if (![array isKindOfClass:[NSArray class]] || ![array count]) {
			return [NSArray array];
		} else {
			NSMutableArray *mutableTracks = [NSMutableArray arrayWithCapacity:[array count]];
			for (id aTrack in array) {
				if ([aTrack isKindOfClass:[NSDictionary class]]) {
					// TOOD: handle error
					LFMTrack *lfmTrack = [MTLJSONAdapter modelOfClass:LFMTrack.class
														   fromJSONDictionary:aTrack
																		error:nil];
					[mutableTracks addObject:lfmTrack];
				}
			}
			return [NSArray arrayWithArray:mutableTracks];
		}
    } reverseBlock:^(NSArray *array) {
		// TODO: what to do here?
		return array;
    }];
}

+ (NSValueTransformer *)membersJSONTransformer
{
	return [LFMData membersTransformer];
}

+ (NSValueTransformer *)yearfromJSONTransformer
{
	return [LFMMember yearDateTransformer];
}

+ (NSValueTransformer *)yeartoJSONTransformer
{
	return [LFMMember yearDateTransformer];
}

#pragma mark - JSON helpers

#pragma mark - Custom ValueTransformers

+ (NSValueTransformer *)tagsTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *array) {
		if (![array isKindOfClass:[NSArray class]] || ![array count]) {
			return [NSArray array];
		} else {
			NSMutableArray *mutableTags = [NSMutableArray arrayWithCapacity:[array count]];
			for (id aTag in array) {
				if ([aTag isKindOfClass:[NSDictionary class]]) {
					// TOOD: handle error
					LFMTag *lfmTag = [MTLJSONAdapter modelOfClass:LFMTag.class
											   fromJSONDictionary:aTag
															error:nil];
					[mutableTags addObject:lfmTag];
				}
			}
			return [NSArray arrayWithArray:mutableTags];
		}
    } reverseBlock:^(NSArray *array) {
		// TODO: what to do here?
		return [array description];
    }];
}

+ (NSValueTransformer *)membersTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *array) {
		if (![array isKindOfClass:[NSArray class]] || ![array count]) {
			return [NSArray array];
		} else {
			NSMutableArray *mutableMembers = [NSMutableArray arrayWithCapacity:[array count]];
			for (id aMember in array) {
				if ([aMember isKindOfClass:[NSDictionary class]]) {
					// TOOD: handle error
					LFMMember *lfmMember = [MTLJSONAdapter modelOfClass:LFMMember.class
													 fromJSONDictionary:aMember
																  error:nil];
					[mutableMembers addObject:lfmMember];
				}
			}
			return [NSArray arrayWithArray:mutableMembers];
		}
    } reverseBlock:^(NSArray *array) {
		// TODO: what to do here?
		return [array description];
    }];
}

+ (NSValueTransformer *)boolTransformer
{
    static MTLValueTransformer *boolTransformer;
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		boolTransformer = [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
			return [NSNumber numberWithBool:[@"1" isEqual:str]];
		} reverseBlock:^(NSNumber *num) {
			return [num description];
		}];
	});
    return boolTransformer;
}

+ (NSValueTransformer *)numberTransformer
{
    static MTLValueTransformer *numberTransformer;
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		numberTransformer = [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
			return [NSNumber numberWithLongLong:[str longLongValue]];
		} reverseBlock:^(NSNumber *num) {
			return [num description];
		}];
	});
    return numberTransformer;
}

+ (NSValueTransformer *)imageStringTransformerWithSize:(NSNumber *)size
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *array) {
		if (![array isKindOfClass:[NSArray class]]) {
			return @"";
		}
		return [[array objectAtIndex:[size integerValue]][@"#text"] description];
    } reverseBlock:^(NSArray *array) {
		// TODO: what to do here?
		return array;
    }];
}

+ (NSValueTransformer *)imageURLTransformerWithSize:(NSNumber *)size
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *array) {
		if (![array isKindOfClass:[NSArray class]]) {
			return [NSURL URLWithString:@""];
		}
		NSString *urlStr = [[array objectAtIndex:[size integerValue]][@"#text"] description];
		return [NSURL URLWithString:urlStr];
    } reverseBlock:^(NSArray *array) {
		// TODO: what to do here?
		return array;
    }];
}

+ (NSValueTransformer *)yearDateTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.yearformedDateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
		return [self.yearformedDateFormatter stringFromDate:date];
    }];
}

#pragma mark - DateFormatter

+ (NSDateFormatter *)releaseDateFormatter
{
    static NSDateFormatter *releaseDateFormatter;
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		releaseDateFormatter = [[NSDateFormatter alloc] init];
		[releaseDateFormatter setDateFormat:@"d MMMM yyyy, ZZZZZ"];
	});
    return releaseDateFormatter;
}

+ (NSDateFormatter *)publishedDateFormatter
{
    static NSDateFormatter *publishedDateFormatter;
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		publishedDateFormatter = [[NSDateFormatter alloc] init];
		[publishedDateFormatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	});
    return publishedDateFormatter;
}

+ (NSDateFormatter *)yearformedDateFormatter
{
    static NSDateFormatter *yearformedDateFormatter;
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		yearformedDateFormatter = [[NSDateFormatter alloc] init];
		[yearformedDateFormatter setDateFormat:@"yyyy"];
	});
    return yearformedDateFormatter;
}

#pragma mark - imageJSONTransformer

+ (NSValueTransformer *)imageSmallJSONTransformer
{
    return [self imageURLTransformerWithSize:@(0)];
}

+ (NSValueTransformer *)imageMediumJSONTransformer
{
    return [self imageURLTransformerWithSize:@(1)];
}

+ (NSValueTransformer *)imageLargeJSONTransformer
{
    return [self imageURLTransformerWithSize:@(2)];
}

+ (NSValueTransformer *)imageExtraLargeJSONTransformer
{
    return [self imageURLTransformerWithSize:@(3)];
}

+ (NSValueTransformer *)imageMegaJSONTransformer
{
    return [self imageURLTransformerWithSize:@(4)];
}

+ (NSValueTransformer *)imageSmallStringJSONTransformer
{
    return [self imageStringTransformerWithSize:@(0)];
}

+ (NSValueTransformer *)imageMediumStringJSONTransformer
{
    return [self imageStringTransformerWithSize:@(1)];
}

+ (NSValueTransformer *)imageLargeStringJSONTransformer
{
    return [self imageStringTransformerWithSize:@(2)];
}

+ (NSValueTransformer *)imageExtraLargeStringJSONTransformer
{
    return [self imageStringTransformerWithSize:@(3)];
}

+ (NSValueTransformer *)imageMegaStringJSONTransformer
{
    return [self imageStringTransformerWithSize:@(4)];
}

@end