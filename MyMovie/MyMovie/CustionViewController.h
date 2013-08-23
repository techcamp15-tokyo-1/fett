//
//  CustionViewController.h
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/23.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MovieSearcher.h"

#define CELLNIBNAME @"LogCell"
#define CELLIDENTIFIER @"LogCell"

@interface CustionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *appDelegate;
    MovieSearcher *movieSearcher;
    
    NSMutableArray *movieList;
}

@end
