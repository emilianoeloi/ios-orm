//
//  MovieAdd.m
//  ios-orm
//
//  Created by emilianoeloi on 2/28/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "MovieAdd.h"

@implementation MovieAdd

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"MovieAdd" owner:self options:nil] objectAtIndex:0]];
    }
    return self;
}
- (IBAction)cancelMovieAdd:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cancelMovieAdd)]) {
        [_delegate cancelMovieAdd];
    }
}
- (IBAction)saveMovieAdd:(id)sender {
    Movie *movie = [[Movie alloc]init];
    [movie setMovieYear:_txtMovieYear.text];
    [movie setMovieTitle:_txtMovieTitle.text];
    if (_delegate && [_delegate respondsToSelector:@selector(saveMovieAdd:)]) {
        [_delegate saveMovieAdd:movie];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
