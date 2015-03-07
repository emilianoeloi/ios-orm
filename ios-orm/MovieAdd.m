//
//  MovieAdd.m
//  ios-orm
//
//  Created by emilianoeloi on 2/28/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "MovieAdd.h"

@interface MovieAdd()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtMovieTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtMovieYear;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
    
@end

@implementation MovieAdd

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"MovieAdd" owner:self options:nil] objectAtIndex:0]];
    }
    return self;
}

- (IBAction)cancelMovieAdd:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cancelMovieAdd:)]) {
        [_delegate cancelMovieAdd:self];
    }
}
- (IBAction)saveMovieAdd:(id)sender {
    Movie *movie = [[Movie alloc]init];
    [movie setMovieYear:_txtMovieYear.text];
    [movie setMovieTitle:_txtMovieTitle.text];
    if (_delegate && [_delegate respondsToSelector:@selector(saveMovieAdd:andMovie:)]) {
        [_delegate saveMovieAdd:self andMovie:movie];
    }
}

#pragma mark TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}
-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    [self saveMovieAdd:nil];
    return YES;
}

-(CGFloat) maxYOfFormFields{
    return CGRectGetMaxY(_txtMovieYear.frame);
}

@end
