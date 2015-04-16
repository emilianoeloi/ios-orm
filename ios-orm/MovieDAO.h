//
//  MovieDAO.h
//  ios-orm
//
//  Created by emilianoeloi on 2/25/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "DAOConstants.h"

@interface MovieDAO : NSObject

+(instancetype)sharedDAO;
-(void) fetchMovies:(fetchMoviesBlock)completion;
-(void) insertMovie:(Movie *)movie andCompletion:(insertMovieBlock)completion;
-(void) updateMovie:(Movie *)movie andCompletion:(updateMovieBlock)completion;
-(void) deleteMovie:(Movie *)movie andCompletion:(deleteMovieBlock)completion;

@end
