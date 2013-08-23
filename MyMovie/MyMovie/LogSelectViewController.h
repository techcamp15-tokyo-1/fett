//
//  LogSelectViewController.h
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/23.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import "CustionViewController.h"

@interface LogSelectViewController : CustionViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *movieTableView;

- (IBAction)back:(id)sender;


@end
