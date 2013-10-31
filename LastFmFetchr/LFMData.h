//
//  LFMData.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns

static NSString *const kEmpty = @"";

@interface LFMData : NSObject

@property (strong, nonatomic) NSDictionary *JSON;

#pragma mark - Access to JSON

- (NSString *)notNilStringForKeyPath:(NSString *)keyPath;

#pragma mark - Lifecycle

- (instancetype)initWithJson:(NSDictionary *)JSON;

@end
