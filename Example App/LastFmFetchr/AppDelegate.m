//
//  AppDelegate.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "AppDelegate.h"
#import "LastFmFetchr.h"

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
				  completion:^(id<LFMArtistInfo> data, NSError *error) {
					  if (error) {
						  NSLog(@"Error: %@", [error localizedDescription]);
					  } else {
						  //NSLog(@"JSON Response was: %@", data.JSON);
						  NSLog(@"------------------------------ getInfoForArtist -----------------------------------");
						  //NSLog(@"members %@", data.members);
						  NSLog(@"omitting members");
						  //NSLog(@"bioContent %@", data.bioContent);
						  NSLog(@"omitting bioContent");
						  NSLog(@"bioFormationYears %@", data.bioFormationYears);
						  NSLog(@"lfmWikiPage %@", data.lfmWikiPage);
						  NSLog(@"bioPlaceFormed %@", data.bioPlaceFormed);
						  NSLog(@"bioPublishedDate %@", data.bioPublishedDate);
						  //NSLog(@"bioSummary %@", data.bioSummary);
						  NSLog(@"omitting bioSummary");
						  NSLog(@"bioYearFormedDate %@", data.bioYearFormedDate);
						  /*
						  NSLog(@"imageSmall %@", data.imageSmall);
						  NSLog(@"imageSmallString %@", data.imageSmallString);
						  NSLog(@"imageMedium %@", data.imageMedium);
						  NSLog(@"imageMediumString %@", data.imageMediumString);
						  NSLog(@"imageLarge %@", data.imageLarge);
						  NSLog(@"imageLargeString %@", data.imageLargeString);
						  NSLog(@"imageExtraLarge %@", data.imageExtraLarge);
						  NSLog(@"imageExtraLargeString %@", data.imageExtraLargeString);
						  
						  NSLog(@"imageMega %@", data.imageMega);
						  NSLog(@"imageMegaString %@", data.imageMegaString);
						  */
						  NSLog(@"musicBrianzId %@", data.musicBrianzId);
						  NSLog(@"name %@", data.name);
						  NSLog(@"isOnTour %d", data.isOnTour);
						  //NSLog(@"similarArtists %@", data.similarArtists);
						  NSLog(@"omitting similarArtists");
						  NSLog(@"listeners %@", data.listeners);
						  NSLog(@"playcount %@", data.playcount);
						  NSLog(@"isStreamable %c", data.isStreamable);
						  NSLog(@"tags %@", data.tags);
						  NSLog(@"lfmPage %@", data.lfmPage);
						  
						  NSLog(@"Received data for Artist %@", data.name);
						  
					  };
					  NSLog(@"Counter %i", --counter);
				  }];
	NSLog(@"Counter %i", ++counter);
	
	
	// ------------ Album calls ------------------
	
	[fetchr getInfoForAlbum:@"Highway to Hell"
				   byArtist:@"AC/DC"
					   mbid:nil
				 completion:^(id<LFMAlbumInfo> data, NSError *error) {
					 if (error) {
						 NSLog(@"Error: %@", [error localizedDescription]);
					 } else {
						 //NSLog(@"JSON Response was: %@", data.JSON);
						 NSLog(@"------------------------------- getInfoForAlbum --------------------------------");
						 
						 NSLog(@"artistName %@", data.artistName);
						 NSLog(@"lfmId %@", data.lfmId);
						 /*
						 NSLog(@"imageSmall %@", data.imageSmall);
						 NSLog(@"imageSmallString %@", data.imageSmallString);
						 NSLog(@"imageMedium %@", data.imageMedium);
						 NSLog(@"imageMediumString %@", data.imageMediumString);
						 NSLog(@"imageLarge %@", data.imageLarge);
						 NSLog(@"imageLargeString %@", data.imageLargeString);
						 NSLog(@"imageExtraLarge %@", data.imageExtraLarge);
						 NSLog(@"imageExtraLargeString %@", data.imageExtraLargeString);
						 
						 NSLog(@"imageMega %@", data.imageMega);
						 NSLog(@"imageMegaString %@", data.imageMegaString);
						 */
						 NSLog(@"listeners %@", data.listeners);
						 NSLog(@"releaseDate %@", data.releaseDate);
						 NSLog(@"toptags %@", data.topTags);
						 NSLog(@"tracks %@", data.tracks);
						 NSLog(@"omitting wikiContent");
						 NSLog(@"wikiPublishedDate %@", data.wikiPublishedDate);
						 NSLog(@"omitting wikiSummary");
						 
						 NSLog(@"musicBrianzId %@", data.musicBrianzId);
						 NSLog(@"name %@", data.name);
						 NSLog(@"playcount %@", data.playcount);
						 NSLog(@"lfmPage %@", data.lfmPage);
						 
						 NSLog(@"Received data for Album %@ by Artist %@", data.name, data.artistName);
						 
					 };
					 NSLog(@"Counter %i", --counter);
				 }];
	NSLog(@"Counter %i", ++counter);
	
	[fetchr getAllAlbumsByArtist:@"Bruce Springsteen"
							mbid:nil
					  completion:^(id<LFMArtistsTopAlbums> data, NSError *error) {
						  if (error) {
							  NSLog(@"Error: %@", [error localizedDescription]);
						  } else {
							  //NSLog(@"JSON Response was: %@", data.JSON);
							  NSLog(@"----------------------------- getAllAlbumsByArtist -------------------------------");
							  
							  NSLog(@"artistName %@", data.artistName);
							  // of LFMAlbumTopAlbum
							  NSArray *albums = data.albums;
							  for (int i = 0; i < 3; i++) {
								  id<LFMAlbumTopAlbum> album = albums[i];
								  NSLog(@"---------------------- %@ ----------------------", [album name]);
								  
								  NSLog(@"rankInAllArtistAlbums %@", [album rank]);
								  NSLog(@"rankInAllArtistAlbumsNumber %@", [album rank]);
								  /*
								  NSLog(@"imageSmall %@", [album imageSmall]);
								  NSLog(@"imageMedium %@", [album imageMedium]);
								  NSLog(@"imageLarge %@", [album imageLarge]);
								  NSLog(@"imageExtraLarge %@", [album imageExtraLarge]);
								   */
								  NSLog(@"musicBrianzId %@", [album musicBrianzId]);
								  NSLog(@"playcount %@", [album playcount]);
								  NSLog(@"lfmPage %@", [album lfmPage]);
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
