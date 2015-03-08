//
//  MovieCell.m
//  ios-orm
//
//  Created by emilianoeloi on 2/26/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)updateMovie:(id)sender {
    NSLog(@"updateMovie %@", _movie.movieYear);
    if(_viewControllerDelegate && [_viewControllerDelegate respondsToSelector:@selector(loadMovieToEdit:)]){
        [_viewControllerDelegate loadMovieToEdit:_movie];
    }
}


- (IBAction)deleteMovie:(id)sender {
    NSLog(@"deleteMovie %@", _movie.movieYear);
    if (_viewControllerDelegate && [_viewControllerDelegate respondsToSelector:@selector(deleteMovie:)]) {
        [_viewControllerDelegate deleteMovie:_movie];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMovie:(Movie *)movie{
    _movie = movie;
    _movieTitle.text = [NSString stringWithFormat:@"%@ %@",_movie.movieTitle, _movie.movieYear];
}

@end
