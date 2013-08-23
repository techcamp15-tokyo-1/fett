//
//  LogSelectViewController.m
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/23.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import "LogSelectViewController.h"

@interface LogSelectViewController ()

@end

@implementation LogSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    moviesView = _movieTableView;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
