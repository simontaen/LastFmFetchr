//
//  LFMDictionary.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns

static NSString *const kEmpty = @"";

@interface LFMDictionary : NSDictionary

+ (instancetype)dictionaryWithDictionary:(NSDictionary *)dict;

- (NSArray *)tagNamesArrayWithTagListKeyPath:(NSString *)tagListKeyPath;
- (NSArray *)tagURLsArrayWithTagListKeyPath:(NSString *)tagListKeyPath;

- (NSString *)smallImageForImageListKeyPath:(NSString *)imageListKeyPath;
- (NSString *)mediumImageForImageListKeyPath:(NSString *)imageListKeyPath;
- (NSString *)largeImageForImageListKeyPath:(NSString *)imageListKeyPath;
- (NSString *)extraLargeImageForImageListKeyPath:(NSString *)imageListKeyPath;
- (NSString *)megaImageForImageListKeyPath:(NSString *)imageListKeyPath;

- (NSString *)notNilStringForKeyPath:(NSString *)keyPath;

@end
