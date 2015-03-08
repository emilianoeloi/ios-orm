//
//  ViewController.m
//  ios-orm
//
//  Created by emilianoeloi on 2/23/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"
#import "MovieDAO.h"
#import "MovieCell.h"
#import "MovieAdd.h"
#import "MovieEdit.h"

#define kKeyboardOffset 260.0f
#define kFormHeight 200.0f

@interface ViewController ()<MovieCellDelegate, MovieAddDelegate>
@property (weak, nonatomic) IBOutlet UITableView *movieTable;
@property (nonatomic) CGRect normalFrame;
@property (nonatomic) CGRect keyboardOpenFrame;
@property (weak, nonatomic) IBOutlet MovieAdd *viewMovieAdd;
@property (weak, nonatomic) IBOutlet MovieEdit *viewMovieEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnAddMovie;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMovies];
    
    _normalFrame = self.view.frame;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
    
    _viewMovieAdd.delegate = self;
    _viewMovieEdit.delegate = self;
    
    [self screenStart:nil];
    [self layoutBtnAddMovie];
}

-(void)layoutBtnAddMovie{
    [_btnAddMovie setTitle:@"+" forState:UIControlStateNormal];
    [_btnAddMovie setBackgroundColor:[UIColor redColor]];
    [_btnAddMovie setTintColor:[UIColor whiteColor]];
    [_btnAddMovie.layer setCornerRadius:30.0f];
    [_btnAddMovie.layer setShadowColor:[UIColor blackColor].CGColor];
    [_btnAddMovie.layer setShadowOpacity:0.8f];
    [_btnAddMovie.layer setShadowRadius:3.0f];
    [_btnAddMovie.layer setShadowOffset:CGSizeMake(2.0f, 2.0f)];
}

- (void)resignOnTap:(id)iSender {
    [_viewMovieAdd.currentResponder resignFirstResponder];
    [_viewMovieEdit.currentResponder resignFirstResponder];
}


-(void)createKeyboardOpenedFrame:(CGFloat)keyboardHeight{
    //[_viewMovieAdd setNeedsLayout];
    CGFloat keyboardOpenY = CGRectGetMinY(_normalFrame) - keyboardHeight + (CGRectGetHeight(_viewMovieAdd.frame) - [_viewMovieAdd maxYOfFormFields]) - 10;
    _keyboardOpenFrame = CGRectMake(CGRectGetMinX(_normalFrame),
                                    keyboardOpenY,
                                    CGRectGetWidth(_normalFrame),
                                    CGRectGetHeight(_normalFrame));
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerNotification];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self unregisterNotification];
}

#pragma mark Notifications
-(void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)unregisterNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark IBAction
- (IBAction)openMovieAdd:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    
    self.view.frame = _normalFrame;
    [_viewMovieAdd show];
    
    [UIView commitAnimations];
}
- (IBAction)screenStart:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    
    _movieTable.transform = CGAffineTransformTranslate(_movieTable.transform, 0, kFormHeight*2);
    _viewMovieAdd.transform = CGAffineTransformTranslate(_viewMovieAdd.transform, 0, kFormHeight*2);
    _viewMovieEdit.transform =CGAffineTransformTranslate(_viewMovieEdit.transform, 0, kFormHeight);
    
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _movies.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell_ID" forIndexPath:indexPath];
    cell.viewControllerDelegate = self;
    Movie *movie = _movies[indexPath.row];
    [cell setMovie:movie];
    return cell;
}

-(void)loadMovies{
    [[MovieDAO sharedDAO] fetchMovies:^(NSArray *list, NSError *error) {
        _movies = list;
        [_movieTable reloadData];
    }];
    
}

- (IBAction)movieSave:(id)sender {
    Movie *m = [[Movie alloc]init];
    [m setMovieTitle:_movieTitle.text];
    [m setMovieYear:_movieYear.text];
    [[MovieDAO sharedDAO] insertMovie:m andCompletion:^(Movie *movie, NSError *error) {
        [self loadMovies];
    }];
    [_viewMovieAdd.currentResponder resignFirstResponder];
    
}

#pragma mark Keyboard Method
-(void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    [self createKeyboardOpenedFrame:[[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.40f];
    
    self.view.frame = _keyboardOpenFrame;
    
    [UIView commitAnimations];
}
-(void)keyboardWillHide{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10f];
    
    self.view.frame = _normalFrame;
    
    [UIView commitAnimations];
}

#pragma mark MovieCell Delegate
-(void)loadMovieToEdit:(Movie *)movie{
    _viewMovieEdit.movie = movie;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.50f];
    
    [_viewMovieAdd hide];
    [_viewMovieEdit show];
    
    [UIView commitAnimations];
    
}
-(void)deleteMovie:(Movie *)movie{
    [[MovieDAO sharedDAO] deleteMovie:movie andCompletion:^(NSError *error) {
        [self loadMovies];
    }];
}

#pragma mark MovieAdd Delegate
-(void)cancelMovieAdd:(id)movieForm{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    
    [movieForm hide];
    
    [UIView commitAnimations];
}
-(void)saveMovie:(id)movieForm andMovie:(Movie *)movie{
    [self cancelMovieAdd:movieForm];
    if ([movieForm isKindOfClass:[MovieEdit class]]) {
        [[MovieDAO sharedDAO] updateMovie:movie andCompletion:^(Movie *movie, NSError *error) {
            [self loadMovies];
        }];
    }else{
        [[MovieDAO sharedDAO] insertMovie:movie andCompletion:^(Movie *movie, NSError *error) {
            [self loadMovies];
        }];
    }
}
-(void)onShow{
    _movieTable.transform = CGAffineTransformTranslate(_movieTable.transform, 0, -kFormHeight);
    _btnAddMovie.transform = CGAffineTransformTranslate(_btnAddMovie.transform, kFormHeight, kFormHeight);
}
-(void)onHide{
    _movieTable.transform = CGAffineTransformTranslate(_movieTable.transform, 0, kFormHeight);
    _btnAddMovie.transform = CGAffineTransformTranslate(_btnAddMovie.transform, -kFormHeight, -kFormHeight);
}

@end
