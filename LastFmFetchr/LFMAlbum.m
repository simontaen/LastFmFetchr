//
//  LFMAlbum.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 31/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"
#import "LastFmFetchr.h"
#import "KZPropertyMapper.h"

@implementation LFMAlbum

- (instancetype)initWithJson:(NSDictionary *)JSON {
    self = [super initWithJson:JSON];
    if (self) {
		[KZPropertyMapper mapValuesFrom:JSON
							 toInstance:self
						   usingMapping:@{
										  @"image" : @{
												  @0 : @{ @"#text" : KZBox(URL, imageSmall) },
												  @1 : @{ @"#text" : KZBox(URL, imageMedium) },
												  @2 : @{ @"#text" : KZBox(URL, imageLarge) },
												  @3 : @{ @"#text" : KZBox(URL, imageExtraLarge) }
												  },
										  @"mbid" : KZProperty(musicBrianzId),
										  @"name" : KZProperty(name),
										  @"playcount" : KZProperty(playcount),
										  @"url" : KZProperty(lastFmPage)
										  }];
    }
    return self;
}

@end
