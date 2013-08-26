//
//  AppDelegate.m
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/22.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize myMovieList = _myMovieList;

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize likeImage = _likeImage;
@synthesize dislikeImage = _dislikeImage;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // movieList初期化
    self.myMovieList = [[NSMutableArray alloc] init];
    self.myMovieList = [self getMovieFromCoreData];
    
    // イメージ初期化
    self.likeImage = [UIImage imageNamed:@"like.png"];
    self.dislikeImage = [UIImage imageNamed:@"dislike.png"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

-(NSMutableArray*) getMovieFromCoreData{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //データを永続化する為に必要な値の代入
    SimpleCoreObject* simpleCoreObject = [[SimpleCoreObject alloc] init];
    simpleCoreObject = [[SimpleCoreObject alloc] init];
    simpleCoreObject.xcdatamodelName = @"Model";
    simpleCoreObject.sqliteName = @"Model";
    MovieSearcher *movieSearcher = [[MovieSearcher alloc] init];
    int countDataInDB = [simpleCoreObject countObjects:DB_PLACE];
    for(int i = 0; i < countDataInDB; i++){
        Movie *movie = [movieSearcher getMovieFromId:[simpleCoreObject getMovieIdFromDB:i]];
        [array addObject:movie];
    }
    return array;
}


@end
