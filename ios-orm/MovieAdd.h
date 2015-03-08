//
//  MovieAdd.h
//  ios-orm
//
//  Created by emilianoeloi on 2/28/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

#define kFormHeight 200.0f

@protocol MovieAddDelegate <NSObject>

-(void)cancelMovieAdd:(id)movieForm;
-(void)saveMovie:(id)movieForm andMovie:(Movie *)movie;
-(void)onShow;
-(void)onHide;

@end

@interface MovieAdd : UIView<UITextViewDelegate>
@property (nonatomic, strong) id delegate;
@property (nonatomic, assign) id currentResponder;
@property (nonatomic) BOOL beingShown;

-(CGFloat) maxYOfFormFields;
- (IBAction)cancelMovieAdd:(id)sender;
- (IBAction)saveMovieAdd:(id)sender;
-(void)show;
-(void)hide;

@end
