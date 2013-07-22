//
//  LastFmFetchr.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 22/07/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LastFmFetchr.h"
#import "AFNetworking.h"

// Base URL to the API
NSString *const kFCBaseURLString = @"http://ws.audioscrobbler.com/2.0";

// Artist Info keys
NSString *const kLFMArtistBio = @"bio";
NSString *const kLFMArtistSummary = @"summary";
NSString *const kLFMArtistName = @"name";
NSString *const kLFMArtistLastFmPageURL = @"url";
NSString *const kLFMArtistImageLarge = @"image";
NSString *const kLFMArtistListeners = @"listeners";
NSString *const kLFMArtistPlaycount = @"playcount";
NSString *const kLFMArtistTags = @"tags";
NSString *const kLFMArtistIsOnTour = @"ontour";

@interface LastFmFetchr ()
{
    NSUserDefaults *userDefaults;
    
    NSOperationQueue *lastFmFetchrQueue;
    NSMutableSet *pendingRequests;
    dispatch_queue_t async_queue;
}
@end

@implementation LastFmFetchr

# pragma mark - Singleton Methods

+ (id)sharedManager
{
    static LastFmFetchr *_sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (id)init {
    if (self = [super init]) {
        // Init code here
        userDefaults = [NSUserDefaults standardUserDefaults];
        
        // AFNetworking request queues
        lastFmFetchrQueue = [[NSOperationQueue alloc] init];
        pendingRequests = [[NSMutableSet alloc] init];
        
        // Setup the async queue
        async_queue = dispatch_queue_create("com.lastfmfetchr.asyncQueue", NULL);
    }
    return self;
}


#pragma mark - API calls

/// Artist methods
- (NSOperation *)getInfoForArtist:(NSString *)artist
						  success:(void (^)(id JSON))success
						  failure:(void (^)(NSError *error, id response))failure
{
	return nil;
}


#pragma mark - Requests Management

/// Cancels all requests that are currently queued or being executed
- (void)cancelAllRequests
{
    // Cancel any that are in the operations queue
    [lastFmFetchrQueue cancelAllOperations];
    
    // Cancel any in progress (i.e. some subclass of AFHTTPRequestOperation)
    for (id requestOperation in pendingRequests) {
        if ([requestOperation respondsToSelector:@selector(cancel)])
            [requestOperation cancel];
    }
    [pendingRequests removeAllObjects];
}

# pragma mark - Private Methods

/// Check for an empty API key
- (void)checkForAPIKey
{
    if (!self.apiKey || !self.apiKey.length) {
        [NSException raise:@"Forecastr" format:@"Your Forecast.io API key must be populated before you can access the API.", nil];
    }
}

@end
