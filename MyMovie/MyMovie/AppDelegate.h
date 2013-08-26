//
//  AppDelegate.h
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/22.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    // ユーザーのMovieList．起動後初めて検索するときのみ取得．
    NSMutableArray *myMovieList;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *myMovieList;

// データ永続化の為に必要
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end
