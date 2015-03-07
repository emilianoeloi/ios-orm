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

-(void)cancelMovieAdd:(id)movieForm;
-(void)saveMovieAdd:(id)movieForm andMovie:(Movie *)movie;

@end

@interface MovieAdd : UIView<UITextViewDelegate>
@property (nonatomic, strong) id delegate;
@property (nonatomic, assign) id currentResponder;

-(CGFloat) maxYOfFormFields;
- (IBAction)cancelMovieAdd:(id)sender;
- (IBAction)saveMovieAdd:(id)sender;

@end
