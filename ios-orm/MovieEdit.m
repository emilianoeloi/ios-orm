//
//  MovieEdit.m
//  ios-orm
//
//  Created by emilianoeloi on 3/7/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "MovieEdit.h"

@interface MovieEdit()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtMovieTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtMovieYear;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end

@implementation MovieEdit

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"MovieEdit" owner:self options:nil] objectAtIndex:0]];
    }
    return self;
}
- (IBAction)cancelAcction:(id)sender {
    [super cancelMovieAdd:sender];
}
- (IBAction)saveAction:(id)sender {
    [super saveMovieAdd:sender];
}

@end
