//
//  CustionViewController.m
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/23.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import "CustionViewController.h"
#import "Movie.h"
#import "LogCell.h"



@interface CustionViewController ()

@end

@implementation CustionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    movieSearcher = [MovieSearcher alloc];
    
    // AppDelegateと紐付け
    appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return movieList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LogCell *cell = (LogCell*)[tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER
                                                              forIndexPath:indexPath];
    
    Movie *movie = (Movie*)[movieList objectAtIndex:indexPath.row];
    [cell.imageView setImage:movie.image];
    [cell.titleLabel setText:movie.title];
    [cell.typeLabel setText:movie.type];
    
    if (movie.evaluation) {
        if ([movie.evaluation isEqualToString:LIKE]) {
            [cell.judgeImage setImage:appDelegate.likeImage];
        } else if ([movie.evaluation isEqualToString:DISLIKE]) {
            [cell.judgeImage setImage:appDelegate.dislikeImage];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


@end
