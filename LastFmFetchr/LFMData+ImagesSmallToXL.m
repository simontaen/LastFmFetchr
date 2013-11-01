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
    return objc_getAssociatedObject(self, ImageSmallKey);
}

- (void)setImageSmall:(NSURL *)newImageSmall {
    objc_setAssociatedObject(self, ImageSmallKey, newImageSmall, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic imageMedium;

- (NSURL *)imageMedium {
    return objc_getAssociatedObject(self, ImageMediumKey);
}

- (void)setImageMedium:(NSURL *)newImageMedium {
    objc_setAssociatedObject(self, ImageMediumKey, newImageMedium, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic imageLarge;

- (NSURL *)imageLarge {
    return objc_getAssociatedObject(self, ImageLargeKey);
}

- (void)setImageLarge:(NSURL *)newImageLarge {
    objc_setAssociatedObject(self, ImageLargeKey, newImageLarge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic imageExtraLarge;

- (NSURL *)imageExtraLarge {
    return objc_getAssociatedObject(self, ImageExtraLargeKey);
}

- (void)setImageExtraLarge:(NSURL *)newImageExtraLarge {
    objc_setAssociatedObject(self, ImageExtraLargeKey, newImageExtraLarge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)imageSmallString
{
	static NSString *smallString = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		smallString = [[self.imageSmall absoluteString] description];
	});
	return smallString;
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

@end
