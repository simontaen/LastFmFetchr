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
/**
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

- (NSString *)artistName
{
	static NSString *artistName = nil;
	if (!artistName) {
		artistName = [self notNilStringForKeyPath:@"attr.artist"];
		if (!artistName) {
			artistName = [self notNilStringForKeyPath:@"artist"];
		}
	}
	return artistName;
}

- (NSArray *)tracks
{
	static NSArray *tracks = nil;
	if (!tracks) {
		tracks = [self tracksFromArray:[self.JSON valueForKeyPath:@"tracks"]];
	}
	return tracks;
}

#pragma mark - LFMTrack

- (NSNumber *)rank
{
	static NSNumber *rank = nil;
	if (!rank) {
		rank = [NSNumber numberWithInt:[[self notNilStringForKeyPath:@"@attr.rank"] intValue]];
	}
	return rank;
}

#pragma mark - Mapping Helpers

- (NSArray *)tracksFromArray:(id)obj
{
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return [NSArray array];
	}

	id jsonArray = ((NSDictionary *)obj)[@"track"];
	
	if (![jsonArray isKindOfClass:[NSArray class]]) {
		return [NSArray array];
	}
	NSArray *array = (NSArray *)jsonArray;
	
	NSMutableArray *trackArray = [NSMutableArray arrayWithCapacity:[array count]];
	
	for (id JSON in array) {
		if (![JSON isKindOfClass:[NSDictionary class]]) {
			return [NSArray array];
		}
		[trackArray addObject:(id<LFMTrack>)[[LFMData alloc] initWithJson:((NSDictionary *)JSON)]];
	}
	
	return trackArray;
}
*/

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary dictionary];
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
{
	// NOTE only handle top level keys here where the JSONDictionary comes directly from the API.
	// Drop to subclasses if you have nested objects
	
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
			NSString *fromStr = [dict valueForKeyPath:@"formation.yearfrom"];
			NSDate *yearfrom = [self.yearformedDateFormatter dateFromString:fromStr];
			NSString *toStr = [dict valueForKeyPath:@"formation.yearto"];
			NSDate *yearto = [self.yearformedDateFormatter dateFromString:toStr];
			
			if (yearfrom && yearto) {
				return @[yearfrom, yearto];
			} else if (yearfrom) {
				return @[yearfrom];
			}
			return [NSArray array];
		}
    } reverseBlock:^(NSArray *array) {
		// TODO really?
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
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.yearformedDateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
		return [self.yearformedDateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)isOnTourJSONTransformer
{
	return [LFMData boolTransformer];
}

+ (NSValueTransformer *)similarArtistsJSONTransformer
{
	/*
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
	 */
	// TODO
	return nil;
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
	return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *dict) {
		if (![dict isKindOfClass:[NSDictionary class]] || ![dict count]) {
			return @(0);
		} else {
			NSString *rank = dict[@"rank"];
			return [NSNumber numberWithLongLong:[rank longLongValue]];
		}
	} reverseBlock:^(NSNumber *num) {
		return [num description];
	}];
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

+ (NSValueTransformer *)tagsJSONTransformer
{
	return [LFMData tagsTransformer];
}

+ (NSValueTransformer *)topTagsJSONTransformer
{
	return [LFMData tagsTransformer];
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
		// TODO really?
		return [array description];
    }];
}

+ (NSValueTransformer *)boolTransformer
{
	static dispatch_once_t onceToken;
    static MTLValueTransformer *boolTransformer;
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
	static dispatch_once_t onceToken;
    static MTLValueTransformer *numberTransformer;
    dispatch_once(&onceToken, ^{
		numberTransformer = [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
			return [NSNumber numberWithLongLong:[str longLongValue]];
		} reverseBlock:^(NSNumber *num) {
			return [num description];
		}];
	});
    return numberTransformer;
}

#pragma mark - DateFormatter

+ (NSDateFormatter *)releaseDateFormatter
{
	static dispatch_once_t onceToken;
    static NSDateFormatter *releaseDateFormatter;
    dispatch_once(&onceToken, ^{
		releaseDateFormatter = [[NSDateFormatter alloc] init];
		[releaseDateFormatter setDateFormat:@"d MMMM yyyy, ZZZZZ"];
	});
    return releaseDateFormatter;
}

+ (NSDateFormatter *)publishedDateFormatter
{
	static dispatch_once_t onceToken;
    static NSDateFormatter *publishedDateFormatter;
    dispatch_once(&onceToken, ^{
		publishedDateFormatter = [[NSDateFormatter alloc] init];
		[publishedDateFormatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	});
    return publishedDateFormatter;
}

+ (NSDateFormatter *)yearformedDateFormatter
{
	static dispatch_once_t onceToken;
    static NSDateFormatter *yearformedDateFormatter;
    dispatch_once(&onceToken, ^{
		yearformedDateFormatter = [[NSDateFormatter alloc] init];
		[yearformedDateFormatter setDateFormat:@"yyyy"];
	});
    return yearformedDateFormatter;
}

@end