//
//  AppDelegate.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "AppDelegate.h"
#import "LastFmFetchr.h"
#import "NSDictionary+LastFmFetchr.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	LastFmFetchr *lastFmFetchr = [LastFmFetchr sharedManager];
	lastFmFetchr.apiKey = @"aed3367b0133ab707cb4e5b6b04da3e7";
	lastFmFetchr.apiSecret = @"d27f4af60d0c89152dedc7cf89ac1e89";
	
	NSMutableSet *operations = [NSMutableSet set];
	
	
	// ------------ Artist calls ------------------
	
	int __block counter = 0;
	NSLog(@"Counter %i", counter);
	for (int i = 0; i < 3; i ++) {
		NSOperation *op = [lastFmFetchr getInfoForArtist:@"Bon Jovi"
													mbid:nil
												 success:^(id JSON) {
													 NSLog(@"Received data for Artist %@", [JSON artistName]);
													 NSLog(@"Counter %i", --counter);
												 }
												 failure:^(NSOperation *operation, NSError *error) {
													 NSLog(@"Error: %@", [lastFmFetchr messageForError:error withOperation:operation]);
													 NSLog(@"Counter %i", --counter);
												 }];
		NSLog(@"Counter %i", ++counter);
		if (i % 2 == 0) {
			[operations addObject:op];
		}
	}
	
	for (NSOperation *op in operations) {
		[op cancel];
		NSLog(@"Cancelled operation");
		NSLog(@"Counter %i", --counter);
	}
	
	[lastFmFetchr getInfoForArtist:@"Pink Floyd"
							  mbid:nil
						   success:^(NSDictionary *JSON) {
							   // NSLog(@"JSON Response was: %@", JSON);
							   /*
								NSLog(@"-------------------------------------------------------------------------------");
								NSLog(@"USING STRAIGHT KEYS");
								NSLog(@"-------------------------------------------------------------------------------");
								NSLog(@"kLFMArtist_Members %@", [JSON valueForKeyPath:kLFMArtist_Members]);
								//NSLog(@"kLFMArtistBio %@", JSON[kLFMArtistBio]);
								NSLog(@"kLFMArtistBio_Content %@", [JSON valueForKeyPath:kLFMArtistBio_Content]);
								NSLog(@"kLFMArtistBio_Formation %@", [JSON valueForKeyPath:kLFMArtistBio_Formation]);
								NSLog(@"kLFMArtistBio_Link %@", [JSON valueForKeyPath:kLFMArtistBio_Link]);
								NSLog(@"kLFMArtistBio_PlaceFormed %@", [JSON valueForKeyPath:kLFMArtistBio_PlaceFormed]);
								NSLog(@"kLFMArtistBio_Published %@", [JSON valueForKeyPath:kLFMArtistBio_Published]);
								NSLog(@"kLFMArtistBio_Summary %@", [JSON valueForKeyPath:kLFMArtistBio_Summary]);
								NSLog(@"kLFMArtistBio_YearFormed %@", [JSON valueForKeyPath:kLFMArtistBio_YearFormed]);
								NSLog(@"kLFMArtistImageList %@", JSON[kLFMArtistImageList]);
								NSLog(@"kLFMArtistMusicBrianzId %@", JSON[kLFMArtistMusicBrianzId]);
								NSLog(@"kLFMArtistName %@", JSON[kLFMArtistName]);
								NSLog(@"kLFMArtistIsOnTour %@", JSON[kLFMArtistIsOnTour]);
								NSLog(@"kLFMArtist_SimilarArtists %@", [JSON valueForKeyPath:kLFMArtist_SimilarArtists]);
								NSLog(@"kLFMArtistStats_Listeners %@", [JSON valueForKeyPath:kLFMArtistStats_Listeners]);
								NSLog(@"kLFMArtistStats_Playcount %@", [JSON valueForKeyPath:kLFMArtistStats_Playcount]);
								NSLog(@"kLFMArtistStreamable %@", JSON[kLFMArtistStreamable]);
								NSLog(@"kLFMArtist_Tags %@", [JSON valueForKeyPath:kLFMArtist_Tags]);
								NSLog(@"kLFMArtistLastFmPageURL %@", JSON[kLFMArtistLastFmPageURL]);
								*/
							   /*
								NSLog(@"-------------------------------------------------------------------------------");
								NSLog(@"NSDictionary+LastFmFetchr");
								NSLog(@"-------------------------------------------------------------------------------");
								NSLog(@"artistMembers %@", [JSON artistMembers]);
								NSLog(@"artistMemberArray %@", [JSON artistMemberArray]);
								NSLog(@"artistBioContent %@", [JSON artistBioContent]);
								NSLog(@"artistBioFormationYears %@", [JSON artistBioFormationYears]);
								NSLog(@"artistBioFormationYearDates %@", [JSON artistBioFormationYearDates]);
								NSLog(@"artistBioLink %@", [JSON artistBioLink]);
								NSLog(@"artistBioLinkURL %@", [JSON artistBioLinkURL]);
								NSLog(@"artistBioPlaceFormed %@", [JSON artistBioPlaceFormed]);
								NSLog(@"artistBioPublished %@", [JSON artistBioPublished]);
								NSLog(@"artistBioPublishedDate %@", [JSON artistBioPublishedDate]);
								NSLog(@"artistBioSummary %@", [JSON artistBioSummary]);
								NSLog(@"artistBioYearFormed %@", [JSON artistBioYearFormed]);
								NSLog(@"artistBioYearFormedDate %@", [JSON artistBioYearFormedDate]);
								NSLog(@"artistImageSmall %@", [JSON artistImageSmall]);
								NSLog(@"artistImageSmallURL %@", [JSON artistImageSmallURL]);
								NSLog(@"artistImageMedium %@", [JSON artistImageMedium]);
								NSLog(@"artistImageMediumURL %@", [JSON artistImageMediumURL]);
								NSLog(@"artistImageLarge %@", [JSON artistImageLarge]);
								NSLog(@"artistImageLargeURL %@", [JSON artistImageLargeURL]);
								NSLog(@"artistImageExtraLarge %@", [JSON artistImageExtraLarge]);
								NSLog(@"artistImageExtraLargeURL %@", [JSON artistImageExtraLargeURL]);
								NSLog(@"artistImageMega %@", [JSON artistImageMega]);
								NSLog(@"artistImageMegaURL %@", [JSON artistImageMegaURL]);
								NSLog(@"artistMusicBrianzId %@", [JSON artistMusicBrianzId]);
								NSLog(@"artistName %@", [JSON artistName]);
								NSLog(@"artistIsOnTour %@", [JSON artistIsOnTour]);
								NSLog(@"artistIsOnTourBool %c", [JSON artistIsOnTourBool]);
								NSLog(@"artistSimilarArtists %@", [JSON artistSimilarArtists]);
								NSLog(@"artistSimilarArtistsArray %@", [JSON artistSimilarArtistsArray]);
								NSLog(@"artistListeners %@", [JSON artistListeners]);
								NSLog(@"artistListenersNumber %@", [JSON artistListenersNumber]);
								NSLog(@"artistPlaycount %@", [JSON artistPlaycount]);
								NSLog(@"artistPlaycountNumber %@", [JSON artistPlaycountNumber]);
								NSLog(@"artistStreamable %@", [JSON artistStreamable]);
								NSLog(@"artistStreamableBool %c", [JSON artistStreamableBool]);
								NSLog(@"artistTags %@", [JSON artistTags]);
								NSLog(@"artistTagNames %@", [JSON artistTagNames]);
								NSLog(@"artistTagURLs %@", [JSON artistTagURLs]);
								NSLog(@"artistLastFmPage %@", [JSON artistLastFmPage]);
								NSLog(@"artistLastFmPageURL %@", [JSON artistLastFmPageURL]);
								*/
							   NSLog(@"Received data for Artist %@", [JSON artistName]);
							   NSLog(@"Counter %i", --counter);
						   }
						   failure:^(NSOperation *operation, NSError *error) {
							   NSLog(@"Error: %@", [lastFmFetchr messageForError:error withOperation:operation]);
							   NSLog(@"Counter %i", --counter);
						   }];
	NSLog(@"Counter %i", ++counter);
	
	// ------------ Ablum calls ------------------
	[lastFmFetchr getInfoForAlbum:@"Highway to Hell"
						 byArtist:@"AC/DC"
							 mbid:nil
						  success:^(id JSON) {
							  //NSLog(@"JSON Response was: %@", JSON);
							  NSLog(@"-------------------------------------------------------------------------------");
							  NSLog(@"NSDictionary+LastFmFetchr");
							  NSLog(@"-------------------------------------------------------------------------------");
							  NSLog(@"albumArtistName %@", [JSON albumArtistName]);
							  NSLog(@"albumId %@", [JSON albumId]);
							  NSLog(@"albumImageSmall %@", [JSON albumImageSmall]);
							  NSLog(@"albumImageSmallURL %@", [JSON albumImageSmallURL]);
							  NSLog(@"albumImageMedium %@", [JSON albumImageMedium]);
							  NSLog(@"albumImageMediumURL %@", [JSON albumImageMediumURL]);
							  NSLog(@"albumImageLarge %@", [JSON albumImageLarge]);
							  NSLog(@"albumImageLargeURL %@", [JSON albumImageLargeURL]);
							  NSLog(@"albumImageExtraLarge %@", [JSON albumImageExtraLarge]);
							  NSLog(@"albumImageExtraLargeURL %@", [JSON albumImageExtraLargeURL]);
							  NSLog(@"albumImageMega %@", [JSON albumImageMega]);
							  NSLog(@"albumImageMegaURL %@", [JSON albumImageMegaURL]);
							  NSLog(@"albumListeners %@", [JSON albumListeners]);
							  NSLog(@"albumListenersNumber %@", [JSON albumListenersNumber]);
							  NSLog(@"albumMusicBrianzId %@", [JSON albumMusicBrianzId]);
							  NSLog(@"albumName %@", [JSON albumName]);
							  NSLog(@"albumPlaycount %@", [JSON albumPlaycount]);
							  NSLog(@"albumPlaycountNumber %@", [JSON albumPlaycountNumber]);
							  NSLog(@"albumReleasedate %@", [JSON albumReleasedate]);
							  NSLog(@"albumReleasedateDate %@", [JSON albumReleasedateDate]);
							  NSLog(@"albumToptags %@", [JSON albumToptags]);
							  NSLog(@"albumToptagNames %@", [JSON albumToptagNames]);
							  NSLog(@"albumToptagURLs %@", [JSON albumToptagURLs]);
							  NSLog(@"albumTracks %@", [JSON albumTracks]);
							  NSLog(@"albumTracksArray %@", [JSON albumTracksArray]);
							  NSLog(@"albumLastFmPage %@", [JSON albumLastFmPage]);
							  NSLog(@"albumLastFmPageURL %@", [JSON albumLastFmPageURL]);
							  NSLog(@"albumWikiContent %@", [JSON albumWikiContent]);
							  NSLog(@"albumWikiPublished %@", [JSON albumWikiPublished]);
							  NSLog(@"albumWikiPublishedDate %@", [JSON albumWikiPublishedDate]);
							  NSLog(@"albumWikiSummary %@", [JSON albumWikiSummary]);
							  NSLog(@"Received data for Album %@ by Artist %@", [JSON albumName], [JSON albumArtistName]);
							  NSLog(@"Counter %i", --counter);
						  }
						  failure:^(NSOperation *operation, NSError *error) {
							  NSLog(@"Error: %@", [lastFmFetchr messageForError:error withOperation:operation]);
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
