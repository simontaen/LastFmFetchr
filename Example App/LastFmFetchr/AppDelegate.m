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
    // Override point for customization after application launch.
	
	
	LastFmFetchr *lastFmFetchr = [LastFmFetchr sharedManager];
	lastFmFetchr.apiKey = @"aed3367b0133ab707cb4e5b6b04da3e7";
	lastFmFetchr.apiSecret = @"d27f4af60d0c89152dedc7cf89ac1e89";
	
	int __block counter = 0;
	NSLog(@"Counter %i", counter);
	for (int i = 0; i < 5; i ++) {
		[lastFmFetchr getInfoForArtist:@"Bon Jovi"
							   success:^(id JSON) {
								   NSLog(@"Counter %i", --counter);
								   //NSLog(@"JSON Response was: %@", JSON);
								   if (![JSON isKindOfClass:[NSDictionary class]]) {
									   NSLog(@"JSON is Kind of class %@", [[JSON class] description]);
								   }
								   NSLog(@"kLFMArtistLastFmPageURL %@", JSON[kLFMArtistLastFmPageURL]);
								   if (JSON[@"error"]) {
									   NSLog(@"Error: %@", [lastFmFetchr messageForError:nil withResponse:JSON]);
								   }
							   }
							   failure:^(id response, NSError *error) {
								   NSLog(@"Counter %i", --counter);
								   NSLog(@"Error: %@", [lastFmFetchr messageForError:error withResponse:response]);
							   }];
		NSLog(@"Counter %i", ++counter);
	}
	
	[lastFmFetchr cancelAllArtistsGetInfoRequests];
	[lastFmFetchr getInfoForArtist:@"Pink Floyd"
						   success:^(id JSON) {
							   NSLog(@"Counter %i", --counter);
							   //NSLog(@"JSON Response was: %@", JSON);
							   if (![JSON isKindOfClass:[NSDictionary class]]) {
								   NSLog(@"JSON is Kind of class %@", [[JSON class] description]);
							   }
							   NSLog(@"kLFMArtistLastFmPageURL %@", JSON[kLFMArtistLastFmPageURL]);
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
