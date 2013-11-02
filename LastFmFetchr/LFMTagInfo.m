//
//  LFMTagInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 02/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMTagInfo.h"
#import "KZPropertyMapper.h"

@implementation LFMTagInfo

- (instancetype)initWithJson:(NSDictionary *)JSON {
    self = [super initWithJson:JSON];
    if (self) {
		// http://www.last.fm/api/show/tag.getInfo
		[KZPropertyMapper mapValuesFrom:JSON
							 toInstance:self
						   usingMapping:@{
										  @"listeners" : KZProperty(listeners),
										  @"releasedate" : KZCall(releaseDateFromString:, releaseDate),
										  @"image" : @{
												  @0 : @{ @"#text" : KZBox(URL, imageSmall) },
												  @1 : @{ @"#text" : KZBox(URL, imageMedium) },
												  @2 : @{ @"#text" : KZBox(URL, imageLarge) },
												  @3 : @{ @"#text" : KZBox(URL, imageExtraLarge) },
												  @4 : @{ @"#text" : KZBox(URL, imageMega) }
												  },
										  }];
    }
    return self;
}

#pragma mark - Private Methods

- (NSDate *)releaseDateFromString:(NSString *)dateString
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"d MMMM yyyy, ZZZZZ"];
	
	return [formatter dateFromString:[dateString stringByReplacingOccurrencesOfString:@"00:00" withString:@"-00:00"]];
}

@end
