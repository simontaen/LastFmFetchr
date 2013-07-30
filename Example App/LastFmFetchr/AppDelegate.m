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
												 success:^(LFMArtistsGetInfoDict *data) {
													 NSLog(@"Received data for Artist %@", [data artistName]);
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
						   success:^(LFMArtistsGetInfoDict *data) {
							   /*
								NSLog(@"-------------------------------------------------------------------------------");
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
								NSLog(@"artistMembers %@", [data artistMembers]);
								NSLog(@"artistMemberArray %@", [data artistMemberArray]);
								NSLog(@"artistBioContent %@", [data artistBioContent]);
								NSLog(@"artistBioFormationYears %@", [data artistBioFormationYears]);
								NSLog(@"artistBioFormationYearDates %@", [data artistBioFormationYearDates]);
								NSLog(@"artistBioLink %@", [data artistBioLink]);
								NSLog(@"artistBioLinkURL %@", [data artistBioLinkURL]);
								NSLog(@"artistBioPlaceFormed %@", [data artistBioPlaceFormed]);
								NSLog(@"artistBioPublished %@", [data artistBioPublished]);
								NSLog(@"artistBioPublishedDate %@", [data artistBioPublishedDate]);
								NSLog(@"artistBioSummary %@", [data artistBioSummary]);
								NSLog(@"artistBioYearFormed %@", [data artistBioYearFormed]);
								NSLog(@"artistBioYearFormedDate %@", [data artistBioYearFormedDate]);
								NSLog(@"artistImageSmall %@", [data artistImageSmall]);
								NSLog(@"artistImageSmallURL %@", [data artistImageSmallURL]);
								NSLog(@"artistImageMedium %@", [data artistImageMedium]);
								NSLog(@"artistImageMediumURL %@", [data artistImageMediumURL]);
								NSLog(@"artistImageLarge %@", [data artistImageLarge]);
								NSLog(@"artistImageLargeURL %@", [data artistImageLargeURL]);
								NSLog(@"artistImageExtraLarge %@", [data artistImageExtraLarge]);
								NSLog(@"artistImageExtraLargeURL %@", [data artistImageExtraLargeURL]);
								NSLog(@"artistImageMega %@", [data artistImageMega]);
								NSLog(@"artistImageMegaURL %@", [data artistImageMegaURL]);
								NSLog(@"artistMusicBrianzId %@", [data artistMusicBrianzId]);
								NSLog(@"artistName %@", [data artistName]);
								NSLog(@"artistIsOnTour %@", [data artistIsOnTour]);
								NSLog(@"artistIsOnTourBool %c", [data artistIsOnTourBool]);
								NSLog(@"artistSimilarArtists %@", [data artistSimilarArtists]);
								NSLog(@"artistSimilarArtistsArray %@", [data artistSimilarArtistsArray]);
								NSLog(@"artistListeners %@", [data artistListeners]);
								NSLog(@"artistListenersNumber %@", [data artistListenersNumber]);
								NSLog(@"artistPlaycount %@", [data artistPlaycount]);
								NSLog(@"artistPlaycountNumber %@", [data artistPlaycountNumber]);
								NSLog(@"artistStreamable %@", [data artistStreamable]);
								NSLog(@"artistStreamableBool %c", [data artistStreamableBool]);
								NSLog(@"artistTags %@", [data artistTags]);
								NSLog(@"artistTagNames %@", [data artistTagNames]);
								NSLog(@"artistTagURLs %@", [data artistTagURLs]);
								NSLog(@"artistLastFmPage %@", [data artistLastFmPage]);
								NSLog(@"artistLastFmPageURL %@", [data artistLastFmPageURL]);
								*/
							   NSLog(@"Received data for Artist %@", [data artistName]);
							   NSLog(@"Counter %i", --counter);
						   }
						   failure:^(NSOperation *operation, NSError *error) {
							   NSLog(@"Error: %@", [lastFmFetchr messageForError:error withOperation:operation]);
							   NSLog(@"Counter %i", --counter);
						   }];
	NSLog(@"Counter %i", ++counter);
	
	
	// ------------ Album calls ------------------
	
	[lastFmFetchr getInfoForAlbum:@"Highway to Hell"
						 byArtist:@"AC/DC"
							 mbid:nil
						  success:^(LFMAlbumGetInfoDict *data) {
							  /*
							   NSLog(@"-------------------------------------------------------------------------------");
							   NSLog(@"albumArtistName %@", [data albumArtistName]);
							   NSLog(@"albumId %@", [data albumId]);
							   NSLog(@"albumImageSmall %@", [data albumImageSmall]);
							   NSLog(@"albumImageSmallURL %@", [data albumImageSmallURL]);
							   NSLog(@"albumImageMedium %@", [data albumImageMedium]);
							   NSLog(@"albumImageMediumURL %@", [data albumImageMediumURL]);
							   NSLog(@"albumImageLarge %@", [data albumImageLarge]);
							   NSLog(@"albumImageLargeURL %@", [data albumImageLargeURL]);
							   NSLog(@"albumImageExtraLarge %@", [data albumImageExtraLarge]);
							   NSLog(@"albumImageExtraLargeURL %@", [data albumImageExtraLargeURL]);
							   NSLog(@"albumImageMega %@", [data albumImageMega]);
							   NSLog(@"albumImageMegaURL %@", [data albumImageMegaURL]);
							   NSLog(@"albumListeners %@", [data albumListeners]);
							   NSLog(@"albumListenersNumber %@", [data albumListenersNumber]);
							   NSLog(@"albumMusicBrianzId %@", [data albumMusicBrianzId]);
							   NSLog(@"albumName %@", [data albumName]);
							   NSLog(@"albumPlaycount %@", [data albumPlaycount]);
							   NSLog(@"albumPlaycountNumber %@", [data albumPlaycountNumber]);
							   NSLog(@"albumReleasedate %@", [data albumReleasedate]);
							   NSLog(@"albumReleasedateDate %@", [data albumReleasedateDate]);
							   NSLog(@"albumToptags %@", [data albumToptags]);
							   NSLog(@"albumToptagNames %@", [data albumToptagNames]);
							   NSLog(@"albumToptagURLs %@", [data albumToptagURLs]);
							   NSLog(@"albumTracks %@", [data albumTracks]);
							   NSLog(@"albumTracksArray %@", [data albumTracksArray]);
							   NSLog(@"albumLastFmPage %@", [data albumLastFmPage]);
							   NSLog(@"albumLastFmPageURL %@", [data albumLastFmPageURL]);
							   NSLog(@"albumWikiContent %@", [data albumWikiContent]);
							   NSLog(@"albumWikiPublished %@", [data albumWikiPublished]);
							   NSLog(@"albumWikiPublishedDate %@", [data albumWikiPublishedDate]);
							   NSLog(@"albumWikiSummary %@", [data albumWikiSummary]);
							   */
							  NSLog(@"Received data for Album %@ by Artist %@", [data albumName], [data albumArtistName]);
							  NSLog(@"Counter %i", --counter);
						  }
						  failure:^(NSOperation *operation, NSError *error) {
							  NSLog(@"Error: %@", [lastFmFetchr messageForError:error withOperation:operation]);
							  NSLog(@"Counter %i", --counter);
						  }];
	NSLog(@"Counter %i", ++counter);
	
	[lastFmFetchr getAllAlbumsByArtist:@"Bruce Springsteen"
								  mbid:nil
							   success:^(LFMArtistGetTopAlbumsDict *data) {
								   NSLog(@"JSON Response was: %@", data.JSON);
								   NSLog(@"-------------------------------------------------------------------------------");
								   NSLog(@"Received TopAlbums by Artist %@", [data albumArtistName]);
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
