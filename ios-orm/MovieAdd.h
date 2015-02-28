//
//  MovieAdd.h
//  ios-orm
//
//  Created by emilianoeloi on 2/28/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@protocol MovieAddDelegate <NSObject>

-(void)cancelMovieAdd;
-(void)saveMovieAdd:(Movie *)movie;

@end

@interface MovieAdd : UIView<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtMovieTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtMovieYear;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (nonatomic, strong) id delegate;

@end
