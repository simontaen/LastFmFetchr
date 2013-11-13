//
//  LFMData+ImagesSmallToMega.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 02/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData+ImagesSmallToMega.h"
#import <objc/runtime.h>

static void *ImageMegaKey;


@implementation LFMData (ImagesSmallToMega)

@dynamic imageMega;

- (NSURL *)imageMega {
    id obj = objc_getAssociatedObject(self, ImageMegaKey);
	if (!obj) {
		NSURL *url = [NSURL URLWithString:[self megaImageForImageListKeyPath:@"image"]];
		objc_setAssociatedObject(self, ImageMegaKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		return url;
	}
	return obj;
}

-(NSString *)imageMegaString
{
	return [[self.imageMega absoluteString] description];
}

#pragma mark - Helpers

- (NSString *)megaImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self.JSON valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[4][@"#text"] description];
	}
	return kEmpty;
}

@end
