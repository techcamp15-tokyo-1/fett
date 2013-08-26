//
//  LogTableViewController.h
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/22.
//  Copyright (c) 2013年 fett. All rights reserved.
//

/*
 * 映画記録画面
 */

#import <UIKit/UIKit.h>
#import "LogCell.h"
#import "SimpleCoreObject.h"
#import "MovieSearcher.h" 

@interface LogTableViewController : UITableViewController
{
    SimpleCoreObject *simpleCoreObject;
    MovieSearcher *movieSearcher;
}
- (IBAction)pushButton:(id)sender;

@end
