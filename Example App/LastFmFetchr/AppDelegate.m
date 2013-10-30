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
	LastFmFetchr *fetchr = [LastFmFetchr fetchr];
	fetchr.apiKey = @"aed3367b0133ab707cb4e5b6b04da3e7";
	fetchr.apiSecret = @"d27f4af60d0c89152dedc7cf89ac1e89";
	
	
	// ------------ Artist calls ------------------
	
	int __block counter = 0;
	NSLog(@"Counter %i", counter);
	/*
	NSMutableSet *tasks = [NSMutableSet set];
	 
	for (int i = 0; i < 3; i ++) {
		NSURLSessionDataTask *task = [lastFmFetchr getInfoForArtist:@"Bon Jovi"
															   mbid:nil
															success:^(LFMArtistGetInfo *data) {
																NSLog(@"Received data for Artist %@", [data name]);
																NSLog(@"Counter %i", --counter);
															}
															failure:^(NSURLSessionDataTask *task, NSError *error) {
																NSLog(@"Error: %@", [lastFmFetchr messageForError:error withTask:task]);
																NSLog(@"Counter %i", --counter);
															}];
		NSLog(@"Counter %i", ++counter);
		if (i % 2 == 0) {
			[tasks addObject:task];
		}
	}
	
	
	for (NSURLSessionDataTask *task in tasks) {
		[task cancel];
		NSLog(@"Cancelled task");
		NSLog(@"Counter %i", --counter);
	}
	 */
	
	[fetchr getInfoForArtist:@"Pink Floyd"
						mbid:nil
					 success:^(LFMArtistInfo *data) {
						 //NSLog(@"JSON Response was: %@", data.JSON);
						 NSLog(@"------------------------------ getInfoForArtist -----------------------------------");
						 
						 /*
						  NSLog(@"kLFMArtist_Members %@", [self.JSON valueForKeyPath:kLFMArtist_Members]);
						  NSLog(@"kLFMArtistBio_Content %@", [self.JSON valueForKeyPath:kLFMArtistBio_Content]);
						  NSLog(@"kLFMArtistBio_Formation %@", [self.JSON valueForKeyPath:kLFMArtistBio_Formation]);
						  NSLog(@"kLFMArtistBio_Link %@", [self.JSON valueForKeyPath:kLFMArtistBio_Link]);
						  NSLog(@"kLFMArtistBio_PlaceFormed %@", [self.JSON valueForKeyPath:kLFMArtistBio_PlaceFormed]);
						  NSLog(@"kLFMArtistBio_Published %@", [self.JSON valueForKeyPath:kLFMArtistBio_Published]);
						  NSLog(@"kLFMArtistBio_Summary %@", [self.JSON valueForKeyPath:kLFMArtistBio_Summary]);
						  NSLog(@"kLFMArtistBio_YearFormed %@", [self.JSON valueForKeyPath:kLFMArtistBio_YearFormed]);
						  NSLog(@"kLFMArtistImageList %@", self.JSON[kLFMArtistImageList]);
						  NSLog(@"kLFMArtistMusicBrianzId %@", self.JSON[kLFMArtistMusicBrianzId]);
						  NSLog(@"kLFMArtistName %@", self.JSON[kLFMArtistName]);
						  NSLog(@"kLFMArtistIsOnTour %@", self.JSON[kLFMArtistIsOnTour]);
						  NSLog(@"kLFMArtist_SimilarArtists %@", [self.JSON valueForKeyPath:kLFMArtist_SimilarArtists]);
						  NSLog(@"kLFMArtistStats_Listeners %@", [self.JSON valueForKeyPath:kLFMArtistStats_Listeners]);
						  NSLog(@"kLFMArtistStats_Playcount %@", [self.JSON valueForKeyPath:kLFMArtistStats_Playcount]);
						  NSLog(@"kLFMArtistStreamable %@", self.JSON[kLFMArtistStreamable]);
						  NSLog(@"kLFMArtist_Tags %@", [self.JSON valueForKeyPath:kLFMArtist_Tags]);
						  NSLog(@"kLFMArtistLastFmPageURL %@", self.JSON[kLFMArtistLastFmPageURL]);
						  */
						 /*
						  NSLog(@"-------------------------------------------------------------------------------");
						  NSLog(@"members %@", [data members]);
						  NSLog(@"memberArray %@", [data memberArray]);
						  NSLog(@"bioContent %@", [data bioContent]);
						  NSLog(@"bioFormationYears %@", [data bioFormationYears]);
						  NSLog(@"bioFormationYearDates %@", [data bioFormationYearDates]);
						  NSLog(@"bioLink %@", [data bioLink]);
						  NSLog(@"bioLinkURL %@", [data bioLinkURL]);
						  NSLog(@"bioPlaceFormed %@", [data bioPlaceFormed]);
						  NSLog(@"bioPublished %@", [data bioPublished]);
						  NSLog(@"bioPublishedDate %@", [data bioPublishedDate]);
						  NSLog(@"bioSummary %@", [data bioSummary]);
						  NSLog(@"bioYearFormed %@", [data bioYearFormed]);
						  NSLog(@"bioYearFormedDate %@", [data bioYearFormedDate]);
						  NSLog(@"imageSmall %@", [data imageSmall]);
						  NSLog(@"imageSmallURL %@", [data imageSmallURL]);
						  NSLog(@"imageMedium %@", [data imageMedium]);
						  NSLog(@"imageMediumURL %@", [data imageMediumURL]);
						  NSLog(@"imageLarge %@", [data imageLarge]);
						  NSLog(@"imageLargeURL %@", [data imageLargeURL]);
						  NSLog(@"imageExtraLarge %@", [data imageExtraLarge]);
						  NSLog(@"imageExtraLargeURL %@", [data imageExtraLargeURL]);
						  NSLog(@"imageMega %@", [data imageMega]);
						  NSLog(@"imageMegaURL %@", [data imageMegaURL]);
						  NSLog(@"musicBrianzId %@", [data musicBrianzId]);
						  NSLog(@"name %@", [data name]);
						  NSLog(@"isOnTour %@", [data isOnTour]);
						  NSLog(@"isOnTourBool %c", [data isOnTourBool]);
						  NSLog(@"similarArtists %@", [data similarArtists]);
						  NSLog(@"similarArtistsArray %@", [data similarArtistsArray]);
						  NSLog(@"listeners %@", [data listeners]);
						  NSLog(@"listenersNumber %@", [data listenersNumber]);
						  NSLog(@"playcount %@", [data playcount]);
						  NSLog(@"playcountNumber %@", [data playcountNumber]);
						  NSLog(@"streamable %@", [data streamable]);
						  NSLog(@"streamableBool %c", [data streamableBool]);
						  NSLog(@"tags %@", [data tags]);
						  NSLog(@"tagNames %@", [data tagNames]);
						  NSLog(@"tagURLs %@", [data tagURLs]);
						  NSLog(@"lastFmPage %@", [data lastFmPage]);
						  NSLog(@"lastFmPageURL %@", [data lastFmPageURL]);
						  */
						 NSLog(@"Received data for Artist %@", [data name]);
						 NSLog(@"Counter %i", --counter);
					 }
					 failure:^(NSURLSessionDataTask *task, NSError *error) {
						 NSLog(@"Error: %@", [fetchr messageForError:error withTask:task]);
						 NSLog(@"Counter %i", --counter);
					 }];
	NSLog(@"Counter %i", ++counter);
	
	
	// ------------ Album calls ------------------
	
	[fetchr getInfoForAlbum:@"Highway to Hell"
				   byArtist:@"AC/DC"
					   mbid:nil
					success:^(LFMAlbumInfo *data) {
						//NSLog(@"JSON Response was: %@", data.JSON);
						NSLog(@"------------------------------- getInfoForAlbum --------------------------------");
						
						NSLog(@"artistName %@", [data artistName]);
						//NSLog(@"identification %@", [data identification]);
						NSLog(@"lfmId %@", [data lfmId]);
						NSLog(@"imageSmall %@", [data imageSmall]);
						//NSLog(@"imageSmallURL %@", [data imageSmallURL]);
						NSLog(@"imageMedium %@", [data imageMedium]);
						//NSLog(@"imageMediumURL %@", [data imageMediumURL]);
						NSLog(@"imageLarge %@", [data imageLarge]);
						//NSLog(@"imageLargeURL %@", [data imageLargeURL]);
						NSLog(@"imageExtraLarge %@", [data imageExtraLarge]);
						//NSLog(@"imageExtraLargeURL %@", [data imageExtraLargeURL]);
						NSLog(@"imageMega %@", [data imageMega]);
						//NSLog(@"imageMegaURL %@", [data imageMegaURL]);
						NSLog(@"listeners %@", [data listeners]);
						//NSLog(@"listenersNumber %@", [data listenersNumber]);
						NSLog(@"musicBrianzId %@", [data musicBrianzId]);
						NSLog(@"name %@", [data name]);
						NSLog(@"playcount %@", [data playcount]);
						//NSLog(@"playcountNumber %@", [data playcountNumber]);
						//NSLog(@"releasedate %@", [data releasedate]);
						NSLog(@"releaseDate %@", [data releaseDate]);
						//NSLog(@"toptags %@", [data toptags]);
						NSLog(@"toptagNames %@", [data toptagNames]);
						NSLog(@"toptagURLs %@", [data toptagURLs]);
						NSLog(@"tracks %@", [data tracks]);
						//NSLog(@"tracksArray %@", [data tracksArray]);
						NSLog(@"lastFmPage %@", [data lastFmPage]);
						//NSLog(@"lastFmPageURL %@", [data lastFmPageURL]);
						//NSLog(@"wikiContent %@", [data wikiContent]);
						NSLog(@"omitting wikiContent");
						//NSLog(@"wikiPublished %@", [data wikiPublished]);
						NSLog(@"wikiPublishedDate %@", [data wikiPublishedDate]);
						//NSLog(@"wikiSummary %@", [data wikiSummary]);
						NSLog(@"omitting wikiSummary");
						
						NSLog(@"Received data for Album %@ by Artist %@", [data name], [data artistName]);
						NSLog(@"Counter %i", --counter);
					}
					failure:^(NSURLSessionDataTask *task, NSError *error) {
						NSLog(@"Error: %@", [fetchr messageForError:error withTask:task]);
						NSLog(@"Counter %i", --counter);
					}];
	NSLog(@"Counter %i", ++counter);
	
	[fetchr getAllAlbumsByArtist:@"Bruce Springsteen"
							mbid:nil
						 success:^(LFMArtistsTopAlbums *data) {
							 //NSLog(@"JSON Response was: %@", data.JSON);
							 NSLog(@"----------------------------- getAllAlbumsByArtist -------------------------------");
							 
							 NSLog(@"artistName %@", data.artist);
							 // of LFMAlbumTopAlbum
							 NSArray *albums = data.albums;
							 for (int i = 0; i < 3; i++) {
								 LFMAlbumTopAlbum *album = albums[i];
								 NSLog(@"---------------------- %@ ----------------------", [album name]);
								 
								 NSLog(@"rankInAllArtistAlbums %@", [album rankInAllArtistAlbums]);
								 NSLog(@"rankInAllArtistAlbumsNumber %@", [album rankInAllArtistAlbums]);
								 
								 NSLog(@"imageSmall %@", [album imageSmall]);
								 //NSLog(@"imageSmallURL %@", [album imageSmallURL]);
								 NSLog(@"imageMedium %@", [album imageMedium]);
								 //NSLog(@"imageMediumURL %@", [album imageMediumURL]);
								 NSLog(@"imageLarge %@", [album imageLarge]);
								 //NSLog(@"imageLargeURL %@", [album imageLargeURL]);
								 NSLog(@"imageExtraLarge %@", [album imageExtraLarge]);
								 //NSLog(@"imageExtraLargeURL %@", [album imageExtraLargeURL]);
								 NSLog(@"musicBrianzId %@", [album musicBrianzId]);
								 NSLog(@"playcount %@", [album playcount]);
								 //NSLog(@"playcountNumber %@", [album playcountNumber]);
								 NSLog(@"lastFmPage %@", [album lastFmPage]);
								 //NSLog(@"lastFmPageURL %@", [album lastFmPageURL]);
							 }
							 
							 
							 NSLog(@"Received %d TopAlbums by Artist %@", [albums count], data.artist);
							 NSLog(@"Counter %i", --counter);
							 
						 }
						 failure:^(NSURLSessionDataTask *task, NSError *error) {
							 NSLog(@"Error: %@", [fetchr messageForError:error withTask:task]);
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
