//
//  SimpleCoreObject.h
//  MyMovie
//
//  Created by 英一 高橋 on 2013/08/24.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SimpleCoreObject : NSObject<NSFetchedResultsControllerDelegate> {
	NSInteger fetchBatchSize_;
	NSString *cacheName_;
	NSString *xcdatamodelName_;
	NSString *sqliteName_;
	id fetchDelegate_;
}

@property (nonatomic, retain) NSString *cacheName;
@property (nonatomic, retain) NSString *xcdatamodelName;
@property (nonatomic, retain) NSString *sqliteName;
@property (nonatomic, retain) id fetchDelegate;

- (NSManagedObject *)fetchObject:(NSString *)entityName WithRow:(NSInteger)row AndSection:(NSInteger)section;
- (NSManagedObject *)fetchObject:(NSString *)entityName WithIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)countObjects:(NSString *)entityName;
- (NSInteger)countSections:(NSString *)entityName;
- (void)deleteObject:(NSString *)entityName WithRow:(NSInteger)row AndSection:(NSInteger)section;
- (void)deleteObject:(NSString *)entityName WithIndexPath:(NSIndexPath *)indexPath;
- (void)deleteObject:(NSString *)entityName WithObject:(NSManagedObject *)managedObject;
- (NSManagedObject *)newManagedObject:(NSString *)entryName;

- (void)saveContext;
- (NSFetchedResultsController *)fetchedResultsController:(NSString *)entityName;
- (NSManagedObjectContext *)managedObjectContext;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory;


/**
 *iphone内部のDBに引数として与えられたデータを保存する。場所はデータベースの一番後ろに挿入される
 *movieId:　映画のID
 *evaluation:映画の評価
 */
-(void) saveMovieToDB : (NSString*) movieId evaluation:(NSString*) evaluation;


/**
 *iphone内部のDBに保存されている映画を削除する。
 * index: 削除されているデータが保存されている場所
 */
-(void) deleteMovieInDB : (int) index;

/**
 *iphone内部のDBに保存されているデータからmovieIdを取得する
 * index: 取得するmovieIdが保存された場所
 */
-(NSString*) getMovieIdFromDB : (int) index;

/**
 *iphone内部のDBに保存されているデータからevaluationを取得する
 * index: 取得するevaluationが保存された場所
 */
-(NSString*) getEvaluationFromDB :(int) index;

/**
 *  DB内のデータを変更する
 * index:変更するデータが保管されている場所
 * movieId:変更後のmovieId
 * evaluation:変更後のevaluation
 */
-(void) editMovieInDB : (int) index movieId :(NSString*) movieId evaluation :(NSString*) evaluation;

@end