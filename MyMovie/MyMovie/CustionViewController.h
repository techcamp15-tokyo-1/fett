//
//  CustionViewController.h
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/23.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CustionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *appDelegate;
    
    UITableView *moviesView;
    NSMutableArray *movieList;
}

@end