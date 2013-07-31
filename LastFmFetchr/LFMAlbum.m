//
//  LFMAlbum.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 31/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMAlbum.h"
#import "LastFmFetchr.h"

@implementation LFMAlbum

- (NSString *)imageSmall
{
	return [self smallImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)imageSmallURL
{
	return [NSURL URLWithString:[self imageSmall]];
}

- (NSString *)imageMedium
{
	return [self mediumImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)imageMediumURL
{
	return [NSURL URLWithString:[self imageMedium]];
}

- (NSString *)imageLarge
{
	return [self largeImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)imageLargeURL
{
	return [NSURL URLWithString:[self imageLarge]];
}

- (NSString *)imageExtraLarge
{
	return [self extraLargeImageForImageListKeyPath:kLFMAlbumImageList];
}

- (NSURL *)imageExtraLargeURL
{
	return [NSURL URLWithString:[self imageExtraLarge]];
}

- (NSString *)musicBrianzId
{
	return [self notNilStringForKeyPath:kLFMAlbumMusicBrianzId];
}

- (NSString *)name
{
	return [self notNilStringForKeyPath:kLFMAlbumName];
}

- (NSString *)playcount
{
	return [self notNilStringForKeyPath:kLFMAlbumPlaycount];
}

- (NSNumber *)playcountNumber
{
	return [NSNumber numberWithLongLong:[[self playcount] longLongValue]];
}

- (NSString *)lastFmPage
{
	return [self notNilStringForKeyPath:kLFMAlbumLastFmPageURL];
}

- (NSURL *)lastFmPageURL
{
	return [NSURL URLWithString:[self lastFmPage]];
}

@end
