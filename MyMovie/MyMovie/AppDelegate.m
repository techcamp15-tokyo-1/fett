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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // movieList初期化
    self.myMovieList = [[NSMutableArray alloc] init];
    
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

@end
