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
#pragma mark - LFMArtistInfo
//http://www.last.fm/api/show/artist.getInfo

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

- (NSString *)bioSummary
{
	static NSString *bioSummary = nil;
	if (!bioSummary) {
		bioSummary = [self notNilStringForKeyPath:@"bio.summary"];
	}
	return bioSummary;
}

- (NSArray *)tags
{
	static NSArray *tags = nil;
	if (!tags) {
		tags = [self tagsFromDictionary:[self.JSON valueForKeyPath:@"tags"]];
	}
	return tags;
}

#pragma mark - LFMArtistsTopAlbums
//http://www.last.fm/api/show/artist.getTopAlbums

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

- (NSArray *)albums
{
	static NSArray *albums = nil;
	if (!albums) {
		id obj = [self.JSON valueForKeyPath:@"album"];
		
		if (![obj isKindOfClass:[NSArray class]]) {
			albums = [NSArray array];
		} else {
			NSArray *array = (NSArray *)obj;
			NSMutableArray *mutableAlbums = [NSMutableArray arrayWithCapacity:[array count]];
			for (id aAlbum in array) {
				if ([aAlbum isKindOfClass:[NSDictionary class]]) {
					[mutableAlbums addObject:((id<LFMAlbumTopAlbum>)[[LFMData alloc] initWithJson:(NSDictionary *)aAlbum])];
				}
			}
			albums = [NSArray arrayWithArray:mutableAlbums];
		}
	}
	return albums;
}

#pragma mark - LFMAlbum

- (NSString *)musicBrianzId
{
	static NSString *musicBrianzId = nil;
	if (!musicBrianzId) {
		musicBrianzId = [self notNilStringForKeyPath:@"mbid"];
	}
	return musicBrianzId;
}

- (NSString *)name
{
	static NSString *name = nil;
	if (!name) {
		name = [self notNilStringForKeyPath:@"name"];
	}
	return name;
}

#pragma mark - LFMAlbumInfoSub
//http://www.last.fm/api/show/album.getInfo

- (NSNumber *)lfmId
{
	static NSNumber *lfmId = nil;
	if (!lfmId) {
		lfmId = [self longLongNumberForKeyPath:@"id"];
	}
	return lfmId;
}

- (NSArray *)topTags
{
	static NSArray *topTags = nil;
	if (!topTags) {
		topTags = [self tagsFromDictionary:[self.JSON valueForKeyPath:@"toptags"]];
	}
	return topTags;
}

- (NSArray *)tracks
{
	static NSArray *tracks = nil;
	if (!tracks) {
		tracks = [self tracksFromArray:[self.JSON valueForKeyPath:@"tracks"]];
	}
	return tracks;
}

- (NSString *)wikiContent
{
	static NSString *wikiContent = nil;
	if (!wikiContent) {
		wikiContent = [self notNilStringForKeyPath:@"wiki.content"];
	}
	return wikiContent;
}

- (NSDate *)wikiPublishedDate
{
	static NSDate *wikiPublishedDate = nil;
	if (!wikiPublishedDate) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
		
		wikiPublishedDate = [formatter dateFromString:[self notNilStringForKeyPath:@"wiki.published"]];
	}
	return wikiPublishedDate;
}

- (NSString *)wikiSummary
{
	static NSString *wikiSummary = nil;
	if (!wikiSummary) {
		wikiSummary = [self notNilStringForKeyPath:@"wiki.summary"];
	}
	return wikiSummary;
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

- (id<LFMArtist>)artist
{
	static id<LFMArtist> artist = nil;
	if (!artist) {
		id obj = [self.JSON valueForKeyPath:@"artist"];
		
		if ([obj isKindOfClass:[NSDictionary class]]) {
			artist = (id<LFMArtist>)[[LFMData alloc] initWithJson:(NSDictionary *)obj];
		} else {
			// TODO: this is a problem now, I changed it here,
			// but it won't be reflected at the other place where
			// we do the exact same thing
			// intentionally returning nil, not sure what to do here.
			artist = nil;
		}
	}
	return artist;
}

- (NSNumber *)duration
{
	static NSNumber *duration = nil;
	if (!duration) {
		duration = [self longLongNumberForKeyPath:@"duration"];
	}
	return duration;
}

- (BOOL)isTrackStreamable
{
	return [self boolFromString:[self notNilStringForKeyPath:@"streamable.fulltrack"]];
}

#pragma mark - Mapping Helpers

- (NSArray *)tagsFromDictionary:(id)obj
{
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return [NSArray array];
	}
	
	id jsonArray = ((NSDictionary *)obj)[@"tag"];
	
	if (![jsonArray isKindOfClass:[NSArray class]]) {
		return [NSArray array];
	}
	NSArray *array = (NSArray *)jsonArray;
	
	NSMutableArray *tagArray = [NSMutableArray arrayWithCapacity:[array count]];
	
	for (id JSON in array) {
		if (![JSON isKindOfClass:[NSDictionary class]]) {
			return [NSArray array];
		}
		[tagArray addObject:((id<LFMTag>)[[LFMData alloc] initWithJson:((NSDictionary *)JSON)])];
	}
	
	return tagArray;
}

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

#pragma mark - Access to JSON

- (NSString *)notNilStringForKeyPath:(NSString *)keyPath
{
	id obj = self.JSON;
	// this is nil value save
	for (NSString *key in [keyPath componentsSeparatedByString:@"."]) {
		if ([obj isKindOfClass:[NSDictionary class]]) {
			// go "down" the keyPath
			obj = obj[key];
		} else {
			return kEmpty;
		}
	}
	
	if (obj) {
		return [obj description];
	}
	return kEmpty;
}

#pragma mark - Lifecycle

- (instancetype)initWithJson:(NSDictionary *)JSON;
{
	self = [super init];
	if (self) {
		_JSON = JSON;
	}
	return self;
}
*/

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary dictionary];
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
{
	if (JSONDictionary[@"artist"] != nil) {
		// TODO: more logic needed to differentiate between sublcasses
		// not sure if subclass could implement themselfes though
		[LFMData setContentKey:@"artist"];
        return LFMArtistInfo.class;
    }
	
	if (JSONDictionary[@"album"] != nil) {
		[LFMData setContentKey:@"album"];
        return LFMAlbumInfo.class;
    }
	
	if (JSONDictionary[@"topalbums"] != nil) {
		[LFMData setContentKey:@"topalbums"];
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

+ (NSString *)contentKeyWithDelimiter
{
	@synchronized(self) {
		return [contentKey stringByAppendingString:kDelim];
	}
}

#pragma mark - <key>JSONTransformer

+ (NSValueTransformer *)lfmPageJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)bioFormationYearsJSONTransformer
{
	/*
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
	 */
	// TODO
	return nil;
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
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
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
	// TODO: generalize this value transformer, like for bool
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NSNumber numberWithLongLong:[str longLongValue]];
    } reverseBlock:^(NSNumber *num) {
		return [num description];
    }];
}

+ (NSValueTransformer *)playcountJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NSNumber numberWithLongLong:[str longLongValue]];
    } reverseBlock:^(NSNumber *num) {
		return [num description];
    }];
}

+ (NSValueTransformer *)isStreamableJSONTransformer
{
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
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

#pragma mark - JSON helpers

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
		NSDateFormatter *publishedDateFormatter = [[NSDateFormatter alloc] init];
		[publishedDateFormatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	});
    return publishedDateFormatter;
}

+ (NSDateFormatter *)yearformedDateFormatter
{
	static dispatch_once_t onceToken;
    static NSDateFormatter *yearformedDateFormatter;
    dispatch_once(&onceToken, ^{
		NSDateFormatter *yearformedDateFormatter = [[NSDateFormatter alloc] init];
		[yearformedDateFormatter setDateFormat:@"yyyy"];
	});
    return yearformedDateFormatter;
}

@end