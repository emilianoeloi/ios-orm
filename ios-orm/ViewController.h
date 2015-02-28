//
//  ViewController.h
//  ios-orm
//
//  Created by emilianoeloi on 2/23/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *formTitle;
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITextField *movieTitle;
@property (weak, nonatomic) IBOutlet UITextField *movieYear;

@end

