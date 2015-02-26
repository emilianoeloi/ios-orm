//
//  Movie.h
//  ios-orm
//
//  Created by emilianoeloi on 2/23/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "ZIMOrmModel.h"

@interface Movie : ZIMOrmModel

@property (nonatomic, strong) NSNumber *movieId;
@property (nonatomic, strong) NSString *movieTitle;
@property (nonatomic, strong) NSString *movieYear;

@end
