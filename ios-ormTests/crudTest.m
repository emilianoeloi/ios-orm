//
//  crudTest.m
//  ios-orm
//
//  Created by emilianoeloi on 3/8/15.
//  Copyright (c) 2015 Emiliano Eloi. All rights reserved.
//

#import "crudTest.h"

@implementation crudTest

-(void)beforeEach{
}

-(void)afterEach{
}

///FIXME: Aqui eu utilizei o alfabeto para determinar a ordem da execução dos testes, acredito que exista uma forma melhor.

-(void)testASuccessAddMovie{
    [tester tapViewWithAccessibilityLabel:@"addButton"];
    
    [tester enterText:@"Interstelar" intoViewWithAccessibilityLabel:@"movieTitleAdd"];
    [tester enterText:@"2014" intoViewWithAccessibilityLabel:@"movieYearAdd"];
    
    [tester tapViewWithAccessibilityLabel:@"addMovie"];
    
}

-(void)testBSuccessListMovies{
    [tester tapRowAtIndexPath:[NSIndexPath indexPathForRow:-1 inSection:-1] inTableViewWithAccessibilityIdentifier:@"movieTable"];
    [tester waitForViewWithAccessibilityLabel:@"movieDescription" traits:UIAccessibilityTraitNone];
}

-(void)testCSucessEditMovie{
    [tester tapViewWithAccessibilityLabel:@"loadToEdit"];
    
    [tester clearTextFromViewWithAccessibilityLabel:@"movieTitleEdit"];
    [tester enterText:@"Interstellar" intoViewWithAccessibilityLabel:@"movieTitleEdit"];
    
    [tester tapViewWithAccessibilityLabel:@"editMovie"];
}

-(void)testDSucessDeleteMovie{
    [tester tapViewWithAccessibilityLabel:@"deleteMovie"];
}

@end
