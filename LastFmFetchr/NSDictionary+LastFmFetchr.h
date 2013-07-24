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
- (NSURL *)artistImageSmallURL;
- (NSString *)artistImageMedium;
- (NSURL *)artistImageMediumURL;
- (NSString *)artistImageLarge;
- (NSURL *)artistImageLargeURL;
- (NSString *)artistImageExtraLarge;
- (NSURL *)artistImageExtraLargeURL;
- (NSString *)artistImageMega;
- (NSString *)artistImageMegaURL;
- (NSString *)artistListeners;
- (NSString *)artistPlaycount;
/// Straight JSON ouput
- (NSString *)artistTags;
/// (ordered) Array of Names as NSStrings
- (NSArray *)artistTagNames;
/// (ordered) Array of Last.fm tag links as NSURLs
- (NSArray *)artistTagURLs;
- (NSString *)artistIsOnTour;

@end
