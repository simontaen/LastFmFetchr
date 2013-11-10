//
//  LFMTesting.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 10/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMTesting.h"
#import "KZPropertyMapper.h"

@implementation LFMTesting

- (instancetype)initForTesting {
	self = [super init];
    if (self) {
		NSDictionary *working = @{
								  @"toptags" : @{
										  @"tag" : @[
											  @{ @"name" : @"hard rock",
												 @"url" : @"http://www.google.com"
												},
											  @{ @"name" : @"albums i own",
												 @"url" : @"http://www.google.com"
												},
											  @{
												@"name" : @"70s",
												@"url" : @"http://www.google.com"
												}
											  ]
										  }
								  };
		
		
		NSLog(@"%@", working);
		[KZPropertyMapper mapValuesFrom:working
							 toInstance:self
						   usingMapping:@{
										  @"toptags" : @{
												  @"tag" : KZCall(tagsFromArray:, topTags)
												  }
										  }];

		NSDictionary *causingAssertionFailure = @{
												  @"toptags" : @"\n      "
												  };

		NSLog(@"%@", causingAssertionFailure);
		[KZPropertyMapper mapValuesFrom:causingAssertionFailure
							 toInstance:self
						   usingMapping:@{
										  @"toptags" : @{
												  @"tag" : KZCall(tagsFromArray:, topTags)
												  }
										  }];
		
		
    }
    return self;
}


- (NSArray *)tagsFromArray:(id)obj
{
	if (![obj isKindOfClass:[NSArray class]]) {
		return [NSArray array];
	}
	NSArray *jsonArray = (NSArray *)obj;
	// do stuff with jsonArray
	return jsonArray;
}

@end
