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

#define kKeyboardOffset 260.0f

@interface ViewController ()<MovieCellDelegate, MovieAddDelegate>
@property (weak, nonatomic) IBOutlet UITableView *movieTable;
@property (nonatomic) CGRect normalFrame;
@property (nonatomic) CGRect keyboardOpenFrame;
@property (nonatomic, assign) id currentResponder;
@property (weak, nonatomic) IBOutlet MovieAdd *viewMovieAdd;

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
}

- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
}


-(void)createKeyboardOpenFrame:(CGFloat)keyboardHeight{
    CGFloat keyboardOpenY = CGRectGetMinY(_normalFrame) - keyboardHeight;
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
    [self.currentResponder resignFirstResponder];
    
}

#pragma mark Keyboard Method
-(void)keyboardWillShow:(NSNotification *)notification{
    
    NSDictionary *info = [notification userInfo];
    [self createKeyboardOpenFrame:[[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height];
    
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

#pragma mark TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}
-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark MovieCell Delegate
-(void)loadMovieToEdit:(Movie *)movie{
    
}
-(void)deleteMovie:(Movie *)movie{
    [[MovieDAO sharedDAO] deleteMovie:movie andCompletion:^(NSError *error) {
        [self loadMovies];
    }];
}

#pragma mark MovieAdd Delegate
-(void)cancelMovieAdd{
    
}
-(void)saveMovieAdd:(Movie *)movie{
    [[MovieDAO sharedDAO] insertMovie:movie andCompletion:^(Movie *movie, NSError *error) {
        [self loadMovies];
    }];
}

@end
