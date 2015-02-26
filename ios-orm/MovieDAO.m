//
//  MovieDAO.m
//  ios-orm
//
//  Created by emilianoeloi on 2/25/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "MovieDAO.h"
#import "ZIMOrmModel.h"
#import "Movie.h"
#import "ZIMOrmSelectStatement.h"

@implementation MovieDAO

+(instancetype)sharedDAO{
    static MovieDAO *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[MovieDAO alloc]init];
    });
    return sharedInstance;
    
}

-(void) fetchMovies:(fetchMoviesBlock)completion{
    
    NSArray *list;
    NSError *error;
    
    ZIMOrmSelectStatement *select = [[ZIMOrmSelectStatement alloc] initWithModel:[Movie class]];
    list = [select query];
    
    if (completion) {
        completion(list, error);
    }
}

@end
