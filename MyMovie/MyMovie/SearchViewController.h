//
//  SearchViewController.h
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/23.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import "CustionViewController.h"

@interface SearchViewController : CustionViewController
@property (weak, nonatomic) IBOutlet UITableView *resultList;
- (IBAction)pushAction:(id)sender;


@end
