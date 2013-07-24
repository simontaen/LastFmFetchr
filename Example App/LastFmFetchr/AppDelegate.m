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
    // Override point for customization after application launch.
	
	
	LastFmFetchr *lastFmFetchr = [LastFmFetchr sharedManager];
	lastFmFetchr.apiKey = @"aed3367b0133ab707cb4e5b6b04da3e7";
	lastFmFetchr.apiSecret = @"d27f4af60d0c89152dedc7cf89ac1e89";
	
	NSMutableSet *operations = [NSMutableSet set];
	
	int __block counter = 0;
	NSLog(@"Counter %i", counter);
//	for (int i = 0; i < 5; i ++) {
//		NSOperation *op = [lastFmFetchr getInfoForArtist:@"Bon Jovi"
//												 success:^(id JSON) {
//													 if (JSON[@"error"]) {
//														 NSLog(@"Error: %@", [lastFmFetchr messageForError:nil withResponse:JSON]);
//													 } else {
//														 NSLog(@"Counter %i", --counter);
//														 //NSLog(@"JSON Response was: %@", JSON);
//														 if (![JSON isKindOfClass:[NSDictionary class]]) {
//															 NSLog(@"JSON is Kind of class %@", [[JSON class] description]);
//														 }
//														 NSLog(@"kLFMArtistLastFmPageURL %@", JSON[kLFMArtistLastFmPageURL]);
//													 }
//												 }
//												 failure:^(id response, NSError *error) {
//													 NSLog(@"Error: %@", [lastFmFetchr messageForError:error withResponse:response]);
//												 }];
//		if (i % 2 == 0) {
//			[operations addObject:op];
//		}
//		NSLog(@"Counter %i", ++counter);
//	}
//	
	for (NSOperation *op in operations) {
		[op cancel];
	}
	
	[lastFmFetchr getInfoForArtist:@"Pink Floyd"
						   success:^(NSDictionary *JSON) {
							   NSLog(@"Counter %i", --counter);
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
							   NSLog(@"artistLastFmPageURL %@", [JSON artistLastFmPageURL]);
							   NSLog(@"artistLastFmPageURL %@", [JSON artistLastFmPageURL]);

							   
							   if (JSON[@"error"]) {
								   NSLog(@"Error: %@", [lastFmFetchr messageForError:nil withResponse:JSON]);
							   }
						   }
						   failure:^(id response, NSError *error) {
							   NSLog(@"Counter %i", --counter);
							   NSLog(@"Error: %@", [lastFmFetchr messageForError:error withResponse:response]);
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
