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

@synthesize delegate = _delegate;


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
    
    [_movieTableView registerNib:[UINib nibWithNibName:CELLNIBNAME bundle:nil]
     forCellReuseIdentifier:CELLIDENTIFIER];
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 120)];
    _movieTableView.tableFooterView = tempView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}


/*
 * キーボードでReturnキーが押されたとき
 */
-(void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    // キーボードを隠す
    [self.view endEditing:YES];
    [self setListFromTerm:searchBar.text];
}


// 入力ワードから映画リストを更新
- (void)setListFromTerm:(NSString*)term
{
    if ([term length]>0) {
        movieList = (NSMutableArray*)[movieSearcher getMovieFromTerm:term];
        [_movieTableView reloadData];
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    Movie *selectedMovie = (Movie*)[movieList objectAtIndex:indexPath.row];
    
    if ([_delegate respondsToSelector:@selector(returnMovie:)]){
        int rnd = rand()%2;
        NSString *str = @"";
        switch (rnd) {
            case 0:
                str = LIKE;
                break;
            case 1:
                str = DISLIKE;
                break;
            default:
                break;
        }
        selectedMovie.evaluation = str;
        [_delegate returnMovie:selectedMovie];
    }
}

@end
