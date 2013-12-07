//
//  LFMMember.h
//  LastFmFetchr
//
//  Created by Simon Tännler on 07/12/13.
//  Copyright (c) 2013 edgeguard. All rights reserved.
//

#import "LFMData.h"

@interface LFMMember : LFMData

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDate *yearfrom;
@property (nonatomic, strong, readonly) NSDate *yearto;

@end
