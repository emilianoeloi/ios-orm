//
//  MovieDAO.m
//  ios-orm
//
//  Created by emilianoeloi on 2/25/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "MovieDAO.h"
#import "ZIMOrmModel.h"
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

-(void) insertMovie:(Movie *)movie andCompletion:(insertMovieBlock)completion{
    NSError *error;
    Movie *movieToInsert = [[Movie alloc]init];
    [movieToInsert setMovieTitle:movie.movieTitle];
    [movieToInsert setMovieYear:movie.movieYear];
    [movieToInsert save];
    
    if (completion) {
        completion(movieToInsert, error);
    }
}

-(void) updateMovie:(Movie *)movie andCompletion:(updateMovieBlock)completion{
    NSError *error;
    Movie *movieToUpdate = [[Movie alloc]init];
    
    [movieToUpdate setMovieId:movie.movieId];
    [movieToUpdate load];
    [movieToUpdate setMovieTitle:movie.movieTitle];
    [movieToUpdate setMovieYear:movie.movieYear];
    [movieToUpdate save];
    
    if (completion) {
        completion(movieToUpdate, error);
    }
}

-(void) deleteMovie:(Movie *)movie andCompletion:(deleteMovieBlock)completion{
    NSError *error;
    Movie *movieToDelete = [[Movie alloc]init];
    
    [movieToDelete setMovieId:movie.movieId];
    [movieToDelete delete];
    if (completion) {
        completion(error);
    }
}

@end
