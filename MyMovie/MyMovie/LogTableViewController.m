//
//  LogTableViewController.m
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/22.
//  Copyright (c) 2013年 fett. All rights reserved.
//

/*
 * 映画記録画面
 */

#import "LogTableViewController.h"
#import "MovieSearcher.h"
#import "Movie.h"
#import "DBStaticField.h"

#define CELLNIBNAME @"LogCell"
#define CELLIDENTIFIER @"LogCell"

@interface LogTableViewController ()

@end

@implementation LogTableViewController {
    //評価リスト
    NSMutableArray *_evaluationList;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    movieList = [[NSMutableArray alloc] init];
    _evaluationList = [[NSMutableArray alloc] init];
    //データを永続化する為に必要な値の代入
    simpleCoreObject = [[SimpleCoreObject alloc] init];
    simpleCoreObject.xcdatamodelName = @"Model";
    simpleCoreObject.sqliteName = @"Model";

    // カスタムセル利用の宣言
    [_myTableView registerNib:[UINib nibWithNibName:CELLNIBNAME bundle:nil]
     forCellReuseIdentifier:CELLIDENTIFIER];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


// セルを追加する
- (void)insertNewObject:(Movie*)movie
{
    if (!movieList) {
        movieList = [[NSMutableArray alloc] init];
    }
    [movieList insertObject:movie atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_myTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
//    [simpleCoreObject saveMovieToDB:movie.movie_id evaluation:eval];
}

/**
 * データの永続化ができているかテストする為のメソッド
 */
/*
-(void) pushButton{


    NSLog(@"%d",[simpleCoreObject countObjects:DB_PLACE]);
    for(int i = 0; i < [simpleCoreObject countObjects:DB_PLACE]; i++){
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        [simpleCoreObject deleteObject:DB_PLACE WithIndexPath:path];
    }

    
    NSLog(@"before=%d",[simpleCoreObject countObjects:DB_PLACE]);
    [self saveMovieToDB:@"1400614530" evaluation:@"4"];
    NSLog(@"after=%d",[simpleCoreObject countObjects:DB_PLACE]);
    
    MovieSearcher *movieSearcher = [[MovieSearcher alloc] init];
   Movie *movie = [movieSearcher getMovieFromId:[self getMovieIdFromDB:0]];
    for(int i = 0; i < [simpleCoreObject countObjects:DB_PLACE]; i++){
    
    }
    NSLog(@"%@",movie.title);
    NSLog(@"%@",movie.movie_id);

    [_movieList addObject:movie];
    NSLog(@"%d",[_movieList count]);
    Movie *m = [_movieList objectAtIndex:[_movieList count] - 1];
    NSLog(@"%@",m.movie_id);
    NSLog(@"%@",m.title);
//    [simpleCoreObject deleteObject:DB_PLACE WithObject:newManagedObject];
    [self.tableView reloadData];
}
*/



/**
 * TableListの中身をDBから取得する
 * 方法は,
 * 1.DBに保存されているデータの総数の取得
 * 2.DBに保存されているデータからMovieクラスに変更
 * 3._movieListに映画を保存
 * 4._movieListに全ての映画を保存し終わったら,tableViewの表示を更新する
 */
-(void) initTableListData{
    int countInDBObject = [simpleCoreObject countObjects:DB_PLACE];
    for(int i = 0; i < countInDBObject; i++){
        Movie *movie = [movieSearcher getMovieFromId:[simpleCoreObject getMovieIdFromDB:i]];
        [movieList addObject:movie];
        
        [_evaluationList addObject:[simpleCoreObject getEvaluationFromDB:i]];
    }
    [_myTableView reloadData];
}

/**
 * TableListに映画を追加するときに呼ばれるメソッド
 * 1._movieList,_evaluationListに変更内容を追加する
 * 2.DBにその内容を追加する
 */
-(void) addMovies: (NSString*) movieId movieEvaluation :(NSString*) evaluation{
    Movie *movie = [movieSearcher getMovieFromId:movieId];
    [movieList addObject:movie];
    [_evaluationList addObject:evaluation];
    
    [simpleCoreObject saveMovieToDB:movieId evaluation:evaluation];
}

-(void) editMovieInList : (int) index movieId :(NSString*) movieId evaluation :(NSString*) evaluation{
    [simpleCoreObject editMovieInDB:index movieId:movieId evaluation:evaluation];
}

- (IBAction)pushButton:(id)sender {
    [self addMovies:@"1400614530" movieEvaluation:@"5"];
    [self initTableListData];
//[self pushButton];
}

#pragma mark - Select View delegate

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    
    // 対象セグエ以外ならここでリターン
    if(![[segue identifier] isEqualToString:@"go2logselect"])
        return;
    
    // 遷移先コントローラを取得
    LogSelectViewController *lsvc = (LogSelectViewController*)[segue destinationViewController];
    
    // 遷移元ポインタを渡しておく
    lsvc.delegate = self;
}

- (void)returnMovie:(id)movie
{
    [self insertNewObject:(Movie*)movie];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
