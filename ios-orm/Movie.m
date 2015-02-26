//
//  Movie.m
//  ios-orm
//
//  Created by emilianoeloi on 2/23/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype) init {
    if ((self = [super init])) {
        _saved = nil;
    }
    return self;
}

+ (NSString *) dataSource {
    return @"database";
}

+ (NSString *) table {
    return @"movies";
}

+ (NSArray *) primaryKey {
    return [NSArray arrayWithObject: @"movieId"];
}

+ (BOOL) isAutoIncremented {
    return YES;
}

@end
