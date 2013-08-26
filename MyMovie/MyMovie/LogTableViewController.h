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
#import "CustionViewController.h"
#import "SimpleCoreObject.h"
#import "LogSelectViewController.h"

@interface LogTableViewController : CustionViewController<SelectViewDelegate>
{
    SimpleCoreObject *simpleCoreObject;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)pushButton:(id)sender;

@end
