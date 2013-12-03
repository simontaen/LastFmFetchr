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
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if ([(NSError *)(*error) code] == NSURLErrorCannotDecodeContentData) {
            return nil;
        }
    }
	
    // Workaround for behavior of Rails to return a single space for `head :ok` (a workaround for a bug in Safari), which is not interpreted as valid input by NSJSONSerialization.
    // See https://github.com/rails/rails/issues/1742
    NSStringEncoding stringEncoding = self.stringEncoding;
    if (response.textEncodingName) {
        CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)response.textEncodingName);
        if (encoding != kCFStringEncodingInvalidId) {
            stringEncoding = CFStringConvertEncodingToNSStringEncoding(encoding);
        }
    }
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:stringEncoding];
    if (responseString && ![responseString isEqualToString:@" "]) {
		// Apply regex
		responseString = [self cleanKeys:responseString];
		
        // Workaround for a bug in NSJSONSerialization when Unicode character escape codes are used instead of the actual character
        // See http://stackoverflow.com/a/12843465/157142
        data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
		
        if (data) {
            if ([data length] > 0) {
                return [NSJSONSerialization JSONObjectWithData:data options:self.readingOptions error:error];
            } else {
                return nil;
            }
        } else {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setValue:NSLocalizedStringFromTable(@"Data failed decoding as a UTF-8 string", nil, @"AFNetworking") forKey:NSLocalizedDescriptionKey];
            [userInfo setValue:[NSString stringWithFormat:NSLocalizedStringFromTable(@"Could not decode string: %@", nil, @"AFNetworking"), responseString] forKey:NSLocalizedFailureReasonErrorKey];
            if (error) {
                *error = [[NSError alloc] initWithDomain:AFNetworkingErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:userInfo];
            }
        }
    }
	
    return nil;
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
