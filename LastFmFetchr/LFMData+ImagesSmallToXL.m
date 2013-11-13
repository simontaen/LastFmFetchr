//
//  LFMData+ImagesSmallToXL.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 01/11/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData+ImagesSmallToXL.h"
#import <objc/runtime.h>

static void *ImageSmallKey;
static void *ImageMediumKey;
static void *ImageLargeKey;
static void *ImageExtraLargeKey;


@implementation LFMData (ImagesSmallToXL)


// file:///Users/simon/Library/Developer/Shared/Documentation/DocSets/com.apple.adc.documentation.AppleOSX10.9.CoreReference.docset/Contents/Resources/Documents/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html#//apple_ref/doc/uid/TP40011210-CH6-SW2
//	--> Properties are NOT synthesized in categories, NO ivar available!!
// http://stackoverflow.com/questions/8733104/objective-c-property-in-category
// http://oleb.net/blog/2011/05/faking-ivars-in-objc-categories-with-associative-references/

@dynamic imageSmall;

- (NSURL *)imageSmall {
    id obj = objc_getAssociatedObject(self, ImageSmallKey);
	if (!obj) {
		NSURL *url = [NSURL URLWithString:[self smallImageForImageListKeyPath:@"image"]];
		objc_setAssociatedObject(self, ImageSmallKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		return url;
	}
	return obj;
}

@dynamic imageMedium;

- (NSURL *)imageMedium {
    id obj = objc_getAssociatedObject(self, ImageMediumKey);
	if (!obj) {
		NSURL *url = [NSURL URLWithString:[self mediumImageForImageListKeyPath:@"image"]];
		objc_setAssociatedObject(self, ImageMediumKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		return url;
	}
	return obj;
}

@dynamic imageLarge;

- (NSURL *)imageLarge {
    id obj = objc_getAssociatedObject(self, ImageLargeKey);
	if (!obj) {
		NSURL *url = [NSURL URLWithString:[self largeImageForImageListKeyPath:@"image"]];
		objc_setAssociatedObject(self, ImageLargeKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		return url;
	}
	return obj;
}

@dynamic imageExtraLarge;

- (NSURL *)imageExtraLarge {
    id obj = objc_getAssociatedObject(self, ImageExtraLargeKey);
	if (!obj) {
		NSURL *url = [NSURL URLWithString:[self extraLargeImageForImageListKeyPath:@"image"]];
		objc_setAssociatedObject(self, ImageExtraLargeKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		return url;
	}
	return obj;
}

-(NSString *)imageSmallString
{
	return [[self.imageSmall absoluteString] description];
}

-(NSString *)imageMediumString
{
	return [[self.imageMedium absoluteString] description];
}

-(NSString *)imageLargeString
{
	return [[self.imageLarge absoluteString] description];
}

-(NSString *)imageExtraLargeString
{
	return [[self.imageExtraLarge absoluteString] description];
}

#pragma mark - Helpers

- (NSString *)smallImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self.JSON valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[0][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)mediumImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self.JSON valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[1][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)largeImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self.JSON valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[2][@"#text"] description];
	}
	return kEmpty;
}

- (NSString *)extraLargeImageForImageListKeyPath:(NSString *)imageListKeyPath
{
	id obj = [self.JSON valueForKeyPath:imageListKeyPath];
	if ([obj isKindOfClass:[NSArray class]]) {
		return [obj[3][@"#text"] description];
	}
	return kEmpty;
}

@end
