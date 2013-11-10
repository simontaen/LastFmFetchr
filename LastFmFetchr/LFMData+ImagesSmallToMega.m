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
    return objc_getAssociatedObject(self, ImageMegaKey);
}

- (void)setImageMega:(NSURL *)newImageMega {
    objc_setAssociatedObject(self, ImageMegaKey, newImageMega, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)imageMegaString
{
	return [[self.imageMega absoluteString] description];
}

@end
