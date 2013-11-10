//
//  LFMArtist.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/10/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMArtist.h"
#import "KZPropertyMapper.h"

@implementation LFMArtist

- (instancetype)initWithJson:(NSDictionary *)JSON {
    self = [super initWithJson:JSON];
    if (self) {
		[KZPropertyMapper mapValuesFrom:JSON
							 toInstance:self
						   usingMapping:@{
										  @"mbid" : KZProperty(musicBrianzId),
										  @"name" : KZProperty(name),
										  @"url" : KZProperty(lfmPage)
										  }];
    }
    return self;
}

@end
