//
//  MovieCell.h
//  ios-orm
//
//  Created by emilianoeloi on 2/26/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@protocol MovieCellDelegate <NSObject>

-(void)loadMovieToEdit:(Movie *) movie;
-(void)deleteMovie:(Movie *)movie;

@end

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong) Movie *movie;
@property (nonatomic, strong) id viewControllerDelegate;

@end
