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
    // 記録リスト
    NSMutableArray *_movieList;
    
    //評価リスト
    NSMutableArray *_evaluationList;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _movieList = [[NSMutableArray alloc] init];
    _evaluationList = [[NSMutableArray alloc] init];
    //データを永続化する為に必要な値の代入
    simpleCoreObject = [[SimpleCoreObject alloc] init];
    simpleCoreObject.xcdatamodelName = @"Model";
    simpleCoreObject.sqliteName = @"Model";

    movieSearcher = [[MovieSearcher alloc] init];
    // カスタムセル利用の宣言
    [self.tableView registerNib:[UINib nibWithNibName:CELLNIBNAME bundle:nil]
         forCellReuseIdentifier:CELLIDENTIFIER];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


// セルを追加する
- (void)insertNewObject:(id)sender
{
    if (!_movieList) {
        _movieList = [[NSMutableArray alloc] init];
    }
    [_movieList insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"enter");
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
        [_movieList addObject:movie];
        
        [_evaluationList addObject:[simpleCoreObject getEvaluationFromDB:i]];
    }
    [self.tableView reloadData];
}

/**
 * TableListに映画を追加するときに呼ばれるメソッド
 * 1._movieList,_evaluationListに変更内容を追加する
 * 2.DBにその内容を追加する
 */
-(void) addMovies: (NSString*) movieId movieEvaluation :(NSString*) evaluation{
    Movie *movie = [movieSearcher getMovieFromId:movieId];
    [_movieList addObject:movie];
    [_evaluationList addObject:evaluation];
    
    [simpleCoreObject saveMovieToDB:movieId evaluation:evaluation];
}

-(void) editMovieInList : (int) index movieId :(NSString*) movieId evaluation :(NSString*) evaluation{
    [simpleCoreObject editMovieInDB:index movieId:movieId evaluation:evaluation];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _movieList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LogCell *cell = (LogCell*)[tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER forIndexPath:indexPath];
    Movie *movie = [_movieList objectAtIndex:indexPath.row];
    cell.titleLabel.text = movie.title;
    cell.jacketImageView.image = movie.image;
    cell.evaluation.text = [_evaluationList objectAtIndex:indexPath.row];
    cell.typeLabel.text = movie.type;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

- (IBAction)pushButton:(id)sender {
    [self addMovies:@"1400614530" movieEvaluation:@"5"];
    [self initTableListData];
//[self pushButton];
}
@end
