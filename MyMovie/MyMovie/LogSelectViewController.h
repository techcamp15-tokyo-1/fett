//
//  LogSelectViewController.h
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/23.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import "CustionViewController.h"
#import "SelectViewDelegate.h"
#import "FlatUIKit.h"

@interface LogSelectViewController : CustionViewController<UISearchBarDelegate>
{
    id<SelectViewDelegate> _delegate;
}

@property (weak, nonatomic) IBOutlet UITableView *movieTableView;
@property (nonatomic) id delegate;

- (IBAction)back:(id)sender;


@end
