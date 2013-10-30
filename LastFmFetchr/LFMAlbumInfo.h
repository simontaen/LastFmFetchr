//
//  LFMAlbumGetInfo.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 30/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"

@interface LFMAlbumInfo : LFMAlbum

@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSNumber *lfmId;
@property (nonatomic, strong) NSURL *imageMega;
@property (nonatomic, strong) NSNumber *listeners;
@property (nonatomic, strong) NSDate *releaseDate;
/// (ordered) Array of albums toptags as NSStrings
@property (nonatomic, strong) NSArray *toptagNames;
/// (ordered) Array of Last.fm tag links as NSURLs
@property (nonatomic, strong) NSArray *toptagURLs;
/// NSArray of NSDictionaries of the album tracks
@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong) NSString *wikiContent;
@property (nonatomic, strong) NSDate *wikiPublishedDate;
@property (nonatomic, strong) NSString *wikiSummary;

@end
