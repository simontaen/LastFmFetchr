//
//  LFMTag.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMTag.h"
#import "KZPropertyMapper.h"

@implementation LFMTag

- (instancetype)initWithJson:(NSDictionary *)JSON {
    self = [super initWithJson:JSON];
    if (self) {
		[KZPropertyMapper mapValuesFrom:JSON
							 toInstance:self
						   usingMapping:@{
										  @"name" : KZProperty(name),
										  @"url" : KZBox(URL, lfmPage)
										  }];
    }
    return self;
}

- (NSString *)description
{
	return self.name;
}

@end
