//
//  LFMTagInfo.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 02/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMTagInfo.h"

@implementation LFMTagInfo

#pragma mark - http://www.last.fm/api/show/tag.getInfo

- (NSNumber *)listeners
{
	return [self longLongNumberForKeyPath:@"listeners"];
}

- (NSDate *)releaseDate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"d MMMM yyyy, ZZZZZ"];
	
	NSString *dateString = [[self notNilStringForKeyPath:@"releasedate"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	return [formatter dateFromString:[dateString stringByReplacingOccurrencesOfString:@"00:00" withString:@"-00:00"]];
}

@end
