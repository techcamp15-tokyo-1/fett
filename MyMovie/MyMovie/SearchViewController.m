//
//  SearchViewController.m
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/23.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import "SearchViewController.h"
#import "MovieSearcher.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize resultList;

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
    [super viewDidLoad];
    //movieListを初期化

	// Do any additional setup after loading the view.
    [resultList registerNib:[UINib nibWithNibName:CELLNIBNAME bundle:nil]
     forCellReuseIdentifier:CELLIDENTIFIER];

}

-(void) pushButton{
//    NSArray *array2 = [movieSearcher getMovieFromId:@"1400614530"];
    movieList = [[NSMutableArray alloc] init];
    
    movieList = (NSMutableArray*)[movieSearcher getMovieFromTerm:@"ハリーポッター"];
    NSLog(@"movieCount");
    NSLog(@"%d",movieList.count);
    for(int i = 0; i < movieList.count; i++){
        NSLog(@"%@",((Movie*)[movieList objectAtIndex:i]).title);
    }
    [resultList reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushAction:(id)sender {
        [self pushButton];
}
@end
