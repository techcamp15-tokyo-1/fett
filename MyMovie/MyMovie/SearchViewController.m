//
//  SearchViewController.m
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/23.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import "SearchViewController.h"

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

/**
 * image以外を呼び出す処理とimageを呼び出す処理を分けてる
 * imageの部分は,別スレッドで動かしている
 */
-(void) pushButton{
//    NSArray *array2 = [movieSearcher getMovieFromId:@"1400614530"];
//    movieList = [[NSMutableArray alloc] init];
    
    movieList = (NSMutableArray*)[movieSearcher getMovieFromTerm:@"ハリーポッター"];
//    NSLog(@"movieCount");
    NSLog(@"%d",movieList.count);
    for(int i = 0; i < movieList.count; i++){
        Movie* movie = [movieList objectAtIndex:i];
        if([movie doesMovieHaveImage]){
            [self loadMovieImage:movie index:i];
        }
//        NSLog(@"%@",((Movie*)[movieList objectAtIndex:i]).title);
        if(movie.image == nil){
        //    NSLog(@"image is null");
        }
        
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

/**
 * imageを呼び出す為に呼ばれるThread
 */
-(void) imageLoadThread : (id) param{
    Movie *movie = [param objectForKey:@"movie"];
    NSNumber *pindex = [param objectForKey:@"index"];
    
//    int index = [pindex intValue];
    id path = movie.imageURL;
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *movieImage = [[UIImage alloc]initWithData:data];
    movie.image = movieImage;
    NSLog(@"errorNumber=%@",pindex);
    for(int i = 0; i < 16; i++){
   //     [resultList reloadSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationNone];
   //     NSLog(@"%d is finish",i);
    }
    [resultList reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    
}




-(void) loadMovieImage : (Movie*) movie index: (int) index{
    NSMutableDictionary* param = [[NSMutableDictionary alloc]init];
    NSNumber *pIndex = [NSNumber numberWithUnsignedInteger:index];
    NSLog(@"pIndex=%@",pIndex);
    [param setObject:movie forKey:@"movie"];
    [param setObject:pIndex forKey:@"index"];
    [NSThread detachNewThreadSelector:@selector(imageLoadThread:)
                             toTarget:self
                           withObject:param];
    NSLog(@"imageLoad=%@",movie.title);
    if(movie.image){
        NSLog(@"noimages");
    }
}
@end
