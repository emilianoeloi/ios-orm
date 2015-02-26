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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *movieTable;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMovies];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell_ID" forIndexPath:indexPath];
    Movie *movie = _movies[indexPath.row];
    cell.textLabel.text = movie.movieTitle;
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
    [m save];
    [self loadMovies];
}

@end
