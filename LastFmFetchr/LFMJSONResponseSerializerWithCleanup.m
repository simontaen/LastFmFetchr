//
//  LFMJSONResponseSerializerWithCleanup.m
//  LastFmFetchr
//
//  Created by Simon Tännler on 03/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMJSONResponseSerializerWithCleanup.h"
#import "AFURLConnectionOperation.h"
#import "LFMData.h"

@implementation LFMJSONResponseSerializerWithCleanup

#pragma mark - AFURLRequestSerialization

/// uses the same implementation as AFJSONResponseSerializer, but adds regex cleanup
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
	NSString *responseString = [[NSString alloc] initWithData:data encoding:self.stringEncoding];
	responseString = [self cleanKeys:responseString];
	
	return [super responseObjectForResponse:response data:[responseString dataUsingEncoding:self.stringEncoding] error:error];
}

- (NSString *)cleanKeys:(NSString *)str
{
	// see http://stackoverflow.com/questions/1567850/using-valueforkeypath-on-nsdictionary-if-a-key-starts-the-symbol
	static dispatch_once_t onceToken;
	static NSRegularExpression *regex;
	static NSString *template;
    dispatch_once(&onceToken, ^{
		// don't need to handle the error, the passed pattern is fine
		regex = [NSRegularExpression regularExpressionWithPattern:@",\"@([^\"]*)\":" options:0 error:nil];
		template = [NSString stringWithFormat:@"%@%@%@", @",\"", kAtPrefixReplacement, @"$1\":"];
	});
	return [regex stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:template];;
}

@end
