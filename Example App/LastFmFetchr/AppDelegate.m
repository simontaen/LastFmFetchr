//
//  AppDelegate.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "AppDelegate.h"
#import "LastFmFetchr.h"

static NSString *const kDashes = @"-------------------------------";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	LastFmFetchr *fetchr = [LastFmFetchr setApiKey:@"aed3367b0133ab707cb4e5b6b04da3e7"];
	//fetchr.apiSecret = @"d27f4af60d0c89152dedc7cf89ac1e89";
	
	//[[LFMTesting alloc] initForTesting];
	
	
	// ------------ Artist calls ------------------
	
	int __block counter = 0;
	NSLog(@"Counter %i", counter);
		
	[fetchr getInfoForArtist:@"Pink Floyd"
						mbid:nil
				  completion:^(LFMArtistInfo *data, NSError *error) {
					  if (error) {
						  NSLog(@"Error: %@", [error localizedDescription]);
					  } else {
						  //NSLog(@"JSON Response was: %@", data.JSON);
						  NSLog(@"%@ getInfoForArtist (%@) %@", kDashes, [LFMArtistInfo contentKey], kDashes);
						  NSAssert([data.members count], @"members should not be empty");
						  NSParameterAssert(data.bioContent);
						  NSParameterAssert(data.bioFormationYears);
						  NSAssert([data.bioFormationYears count], @"bioFormationYears should not be empty");
						  NSParameterAssert(data.lfmWikiPage);
						  NSParameterAssert(data.bioPlaceFormed);
						  NSParameterAssert(data.bioPublishedDate);
						  NSParameterAssert(data.bioSummary);
						  NSParameterAssert(data.bioYearFormedDate);

						  NSParameterAssert(data.imageSmall);
						  NSParameterAssert(data.imageSmallString);
						  NSParameterAssert(data.imageMedium);
						  NSParameterAssert(data.imageMediumString);
						  NSParameterAssert(data.imageLarge);
						  NSParameterAssert(data.imageLargeString);
						  NSParameterAssert(data.imageExtraLarge);
						  NSParameterAssert(data.imageExtraLargeString);
						  
						  NSParameterAssert(data.imageMega);
						  NSParameterAssert(data.imageMegaString);

						  NSParameterAssert(data.musicBrianzId);
						  NSParameterAssert(data.name);
						  NSParameterAssert(data.isOnTour);
						  NSParameterAssert(data.similarArtists);
						  NSParameterAssert(data.listeners);
						  NSParameterAssert(data.playcount);
						  NSParameterAssert(data.isStreamable);
						  NSParameterAssert(data.tags);
						  NSAssert([data.tags count], @"tags should not be empty");
						  NSParameterAssert(data.lfmPage);
						  
						  NSLog(@"Received data for Artist %@", data.name);
					  };
					  NSLog(@"Counter %i", --counter);
				  }];
	NSLog(@"Counter %i", ++counter);
	
	
	// ------------ Album calls ------------------
	
	[fetchr getInfoForAlbum:@"Highway to Hell"
				   byArtist:@"AC/DC"
					   mbid:nil
				 completion:^(LFMAlbumInfo *data, NSError *error) {
					 if (error) {
						 NSLog(@"Error: %@", [error localizedDescription]);
					 } else {
						 //NSLog(@"JSON Response was: %@", data.JSON);
						 NSLog(@"%@ getInfoForAlbum (%@) %@", kDashes, [LFMAlbumInfo contentKey], kDashes);
						 
						 NSParameterAssert(data.artistName);
						 NSParameterAssert(data.lfmId);

						 NSParameterAssert(data.imageSmall);
						 NSParameterAssert(data.imageSmallString);
						 NSParameterAssert(data.imageMedium);
						 NSParameterAssert(data.imageMediumString);
						 NSParameterAssert(data.imageLarge);
						 NSParameterAssert(data.imageLargeString);
						 NSParameterAssert(data.imageExtraLarge);
						 NSParameterAssert(data.imageExtraLargeString);
						 
						 NSParameterAssert(data.imageMega);
						 NSParameterAssert(data.imageMegaString);

						 NSParameterAssert(data.listeners);
						 NSParameterAssert(data.releaseDate);
						 NSParameterAssert(data.topTags);
						 NSAssert([data.topTags count], @"topTags should not be empty");
						 NSParameterAssert(data.tracks);
						 NSAssert([data.tracks count], @"tracks should not be empty");
						 for (LFMTrack *track in data.tracks) {
							 LFMArtist *artist = track.artist;
							 NSParameterAssert(artist);
						 }
						 NSParameterAssert([data.tracks[0] artist]);
						 NSParameterAssert(data.wikiContent);
						 NSParameterAssert(data.wikiPublishedDate);
						 NSParameterAssert(data.wikiSummary);
						 
						 NSParameterAssert(data.musicBrianzId);
						 NSParameterAssert(data.name);
						 NSParameterAssert(data.playcount);
						 NSParameterAssert(data.lfmPage);
						 
						 NSLog(@"Received data for Album %@ by Artist %@", data.name, data.artistName);
						 
					 };
					 NSLog(@"Counter %i", --counter);
				 }];
	NSLog(@"Counter %i", ++counter);
	
	[fetchr getAllAlbumsByArtist:@"Bruce Springsteen"
							mbid:nil
					  completion:^(LFMArtistsTopAlbums *data, NSError *error) {
						  if (error) {
							  NSLog(@"Error: %@", [error localizedDescription]);
						  } else {
							  //NSLog(@"JSON Response was: %@", data.JSON);
							  NSLog(@"%@ getAllAlbumsByArtist (%@) %@", kDashes, [LFMArtistsTopAlbums contentKey], kDashes);
							  
							  NSLog(@"artistName %@", data.artistName);
							  NSParameterAssert(data.albums);
							  
							  NSArray *albums = data.albums;
							  for (int i = 0; i < 3; i++) {
								  LFMAlbumTopAlbum *album = albums[i];
								  NSParameterAssert(album.rankInAllArtistAlbums);

								  NSParameterAssert(album.imageSmall);
								  NSParameterAssert(album.imageSmallString);
								  NSParameterAssert(album.imageMedium);
								  NSParameterAssert(album.imageMediumString);
								  NSParameterAssert(album.imageLarge);
								  NSParameterAssert(album.imageLargeString);
								  NSParameterAssert(album.imageExtraLarge);
								  NSParameterAssert(album.imageExtraLargeString);

								  NSParameterAssert(album.musicBrianzId);
								  NSParameterAssert(album.name);
								  NSParameterAssert(album.playcount);
								  NSParameterAssert(album.lfmPage);
								  
								  NSLog(@"-- Received LFMAlbumTopAlbum %@", album.name);
							  }
							  NSLog(@"Received %lu TopAlbums by Artist %@", (unsigned long)[albums count], data.artistName);
							  
						  };
						  NSLog(@"Counter %i", --counter);
					  }];
	NSLog(@"Counter %i", ++counter);
	
	
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
