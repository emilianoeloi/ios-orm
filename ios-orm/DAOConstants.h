//
//  DAOConstants.h
//  ios-orm
//
//  Created by emilianoeloi on 2/25/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "Movie.h"

#ifndef ios_orm_DAOConstants_h
#define ios_orm_DAOConstants_h

typedef void (^fetchMoviesBlock)(NSArray* list, NSError *error);
typedef void (^deleteMovieBlock)(NSError* error);
typedef void (^updateMovieBlock)(Movie* movie, NSError *error);
typedef void (^insertMovieBlock)(Movie* movie, NSError *error);

#endif
