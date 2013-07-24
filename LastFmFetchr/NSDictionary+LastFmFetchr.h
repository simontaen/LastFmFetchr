//
//  NSDictionary+LastFmFetchr.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 24/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//
// This Category gives very easy access to the NSDictionary JSON response from Last.fm
// You can get the data 'raw' as an NSString, or with an actual type.

#import <Foundation/Foundation.h>

@interface NSDictionary (LastFmFetchr)

// artist.getInfo
- (NSString *)artistBioContent;
- (NSString *)artistBioFormation;
- (NSString *)artistBioLinks;
- (NSString *)artistBioPlaceFormed;
- (NSString *)artistBioPublished;
- (NSString *)artistBioSummary;
- (NSString *)artistBioYearFormed;
- (NSString *)artistName;
- (NSString *)artistLastFmPageURL;
- (NSString *)artistImageSmall;
- (NSString *)artistImageMedium;
- (NSString *)artistImageLarge;
- (NSString *)artistImageExtraLarge;
- (NSString *)artistImageMega;
- (NSString *)artistListeners;
- (NSString *)artistPlaycount;
- (NSString *)artistTags;
- (NSString *)artistIsOnTour;

@end
