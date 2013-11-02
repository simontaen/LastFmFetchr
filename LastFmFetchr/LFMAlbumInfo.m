//
//  LFMAlbumGetInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbumInfo.h"
#import "LastFmFetchr.h"
#import "KZPropertyMapper.h"

@implementation LFMAlbumInfo

- (instancetype)initWithJson:(NSDictionary *)JSON {
    self = [super initWithJson:JSON];
    if (self) {
		// http://www.last.fm/api/show/album.getInfo
		[KZPropertyMapper mapValuesFrom:JSON
							 toInstance:self
						   usingMapping:@{
										  @"artist" : KZProperty(artistName),
										  @"id" : KZProperty(lfmId),
										  @"image" : @{
												  @4 : @{ @"#text" : KZBox(URL, imageMega) }
												  },
										  @"listeners" : KZProperty(listeners),
										  @"releasedate" : KZCall(releaseDateFromString:, releaseDate),
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
										  @"toptags" : @{
												  @"tag" : KZCall(tagsFromArray:, topTags)
												  },
#pragma clang diagnostic pop
										  @"tracks" : @{ // TODO: here too, LFMTrack
												  @"track" : KZProperty(tracks)
												  },
										  @"wiki" : @{
												  @"content" : KZProperty(wikiContent),
												  @"published" : KZCall(wikiPublishedDateFromString:, wikiPublishedDate),
												  @"summary" : KZProperty(wikiSummary)
												  }
										  }];
    }
    return self;
}

#pragma mark - Property Getter Implementations

-(NSString *)imageMegaString
{
	return [[self.imageMega absoluteString] description];
}

#pragma mark - Private Methods

- (NSDate *)releaseDateFromString:(NSString *)dateString
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"d MMMM yyyy, ZZZZZ"];
	
	return [formatter dateFromString:[dateString stringByReplacingOccurrencesOfString:@"00:00" withString:@"-00:00"]];
}

- (NSDate *)wikiPublishedDateFromString:(NSString *)dateString
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEE, d MMM yyyy hh:mm:ss Z"];
	
	return [formatter dateFromString:dateString];
}

@end
