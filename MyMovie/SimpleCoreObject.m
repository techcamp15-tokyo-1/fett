//
//  SimpleCoreObject.m
//  MyMovie
//
//  Created by 英一 高橋 on 2013/08/24.
//  Copyright (c) 2013年 fett. All rights reserved.
//
#import "SimpleCoreObject.h"
#import "DBStaticField.h"


@implementation SimpleCoreObject


@synthesize cacheName = cacheName_;
@synthesize xcdatamodelName = xcdatamodelName_;
@synthesize sqliteName = sqliteName_;
@synthesize fetchDelegate = fetchDelegate_;

static NSPersistentStoreCoordinator *persistentStoreCoordinator_ = nil;
static NSManagedObjectModel *managedObjectModel_ = nil;
static NSManagedObjectContext *managedObjectContext_ = nil;
static NSMutableDictionary *fetchedResultsController_ = nil;

/*
- (void)dealloc {

	[cacheName_ release];
	[xcdatamodelName_ release];
	[sqliteName_ release];
	[fetchDelegate_ release];
	[fetchedResultsController_ release];
    
	
	if (persistentStoreCoordinator_)
		[persistentStoreCoordinator_ release];
    
	if (managedObjectModel_)
		[managedObjectModel_ release];
	
	if (managedObjectContext_)
		[managedObjectContext_ release];
	
	[super dealloc];
}
*/

- (id)init {
	if ( self = [super init] ) {
		fetchBatchSize_ = 20;
		cacheName_ = @"Root";
		self.fetchDelegate = self;
		fetchedResultsController_ = [[NSMutableDictionary alloc] init];
	}
	return self;
}


- (NSFetchedResultsController *)fetchedResultsController:(NSString *)entityName {
	NSFetchedResultsController *fetchedResultsController =
    [fetchedResultsController_ objectForKey:entityName];
    
	if (fetchedResultsController != nil) {
		return fetchedResultsController;
	}
	NSLog(@"%@",[self managedObjectContext]);
	// Create the request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription
								   entityForName:entityName
								   inManagedObjectContext:[self managedObjectContext]];
    
	[fetchRequest setEntity:entity];
	[fetchRequest setFetchBatchSize:fetchBatchSize_];
	
	
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor =
    [[NSSortDescriptor alloc]
     initWithKey:@"movieId"
     ascending:NO];
	NSArray *sortDescriptors =
    [[NSArray alloc]
     initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
	
	
	// Edit the section name key and cache name if appropriate.
	NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc]
     initWithFetchRequest:fetchRequest
     managedObjectContext:[self managedObjectContext]
     sectionNameKeyPath:nil
     cacheName:self.cacheName
     ];
	aFetchedResultsController.delegate = self.fetchDelegate;
    
/*
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
*/	
	
	fetchedResultsController = aFetchedResultsController;
	[fetchedResultsController_ setValue:fetchedResultsController forKey:entityName];
	
	NSError *error = nil;
	if ( ![fetchedResultsController performFetch:&error] ) {
        
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return fetchedResultsController;
}


- (void)saveContext {
	NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	
	if (managedObjectContext != nil) {
		if ([managedObjectContext hasChanges] &&
			![managedObjectContext save:&error])
		{
			abort();
		}
	}
}


- (NSManagedObjectContext *)managedObjectContext {
	if (managedObjectContext_ != nil) {
		return managedObjectContext_;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	
	if (coordinator != nil) {
		managedObjectContext_ =
        [[NSManagedObjectContext alloc] init];
		[managedObjectContext_ setPersistentStoreCoordinator:coordinator];
	}
	
	return managedObjectContext_;
}


- (NSManagedObjectModel *)managedObjectModel {
	if (managedObjectModel_ != nil) {
		return managedObjectModel_;
	}
	
	NSString *modelPath = [[NSBundle mainBundle]
						   pathForResource:self.xcdatamodelName
						   ofType:@"momd"];
	NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
	managedObjectModel_ = [[NSManagedObjectModel alloc]
						   initWithContentsOfURL:modelURL];
	
	return managedObjectModel_;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	if (persistentStoreCoordinator_ != nil) {
		return persistentStoreCoordinator_;
	}
	
	NSURL *storeURL =
    [[self applicationDocumentsDirectory]
     URLByAppendingPathComponent:self.sqliteName];
	NSError *error = nil;
	
//    NSLog(@"%@",[self managedObjectModel]);
	persistentStoreCoordinator_ =
    [[NSPersistentStoreCoordinator alloc]
     initWithManagedObjectModel:[self managedObjectModel]];
	
	if ( ![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType
													configuration:nil
															  URL:storeURL
														  options:nil error:&error] )
	{
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return persistentStoreCoordinator_;
}


- (NSURL *)applicationDocumentsDirectory {
	return [[[NSFileManager defaultManager]
			 URLsForDirectory:NSDocumentDirectory
			 inDomains:NSUserDomainMask] lastObject];
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	//NSLog(@"SimpleCoreData");
}



#pragma mark -
#pragma mark API


- (NSManagedObject *)fetchObject:(NSString *)entityName
						 WithRow:(NSInteger)row AndSection:(NSInteger)section
{
	NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
	return [self fetchObject:entityName WithIndexPath:path];
}


- (NSManagedObject *)fetchObject:(NSString *)entityName
				   WithIndexPath:(NSIndexPath *)indexPath
{
	NSFetchedResultsController *fetchedResultsController = [self fetchedResultsController:entityName];
	return [fetchedResultsController objectAtIndexPath:indexPath];
}


- (NSInteger)countObjects:(NSString *)entityName {
	NSFetchedResultsController *fetchedResultsController = [self fetchedResultsController:entityName];
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:0];
	return [sectionInfo numberOfObjects];
}


- (NSInteger)countSections:(NSString *)entityName {
	return [[[self fetchedResultsController:entityName] sections] count];
}


- (void)deleteObject:(NSString *)entityName WithRow:(NSInteger)row AndSection:(NSInteger)section {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
	[self deleteObject:entityName WithIndexPath:indexPath];
}


- (void)deleteObject:(NSString *)entityName WithIndexPath:(NSIndexPath *)indexPath {
	NSFetchedResultsController *fetchedResultsController = [self fetchedResultsController:entityName];
	@try {
		NSManagedObject *managedObject = [fetchedResultsController objectAtIndexPath:indexPath];
		if (managedObject) {
			[self deleteObject:entityName WithObject:managedObject];
		}
	}
	@catch (NSException * e) {
		NSLog(@"%@", e);
	}
}


- (void)deleteObject:(NSString *)entityName WithObject:(NSManagedObject *)managedObject {
	NSFetchedResultsController *fetchedResultsController = [self fetchedResultsController:entityName];
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	[context deleteObject:managedObject];
	[self saveContext];
}


- (NSManagedObject *)newManagedObject:(NSString *)entryName {
	NSFetchedResultsController *fetchedResultsController = [self fetchedResultsController:entryName];
	
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	NSManagedObject *newManagedObject =
	[NSEntityDescription
	 insertNewObjectForEntityForName:entryName
	 inManagedObjectContext:context];
	
	return newManagedObject;
}


/**
 *iphone内部のDBに引数として与えられたデータを保存する。場所はデータベースの一番後ろに挿入される
 *movieId:　映画のID
 *evaluation:映画の評価
 */
-(void) saveMovieToDB : (NSString*) movieId evaluation:(NSString*) evaluation{
    NSManagedObject *newManagedObject = [self newManagedObject:DB_PLACE];
    [newManagedObject setValue:movieId forKey:DB_KEY_FOR_ID];
    [newManagedObject setValue:evaluation forKey:DB_KEY_FOR_EVAL];
    [self saveContext];
}

/**
 *iphone内部のDBに保存されている映画を削除する。
 * index: 削除されているデータが保存されている場所
 */
-(void) deleteMovieInDB : (int) index{
    NSManagedObject *managedObject = [self fetchObject:DB_PLACE WithRow:index AndSection:0];
    [self deleteObject:DB_PLACE WithObject:managedObject];
}

/**
 *iphone内部のDBに保存されているデータからmovieIdを取得する
 * index: 取得するmovieIdが保存された場所
 */
-(NSString*) getMovieIdFromDB : (int) index{
    NSManagedObject *managedObject = [self fetchObject:DB_PLACE WithRow:index AndSection:0];
    return [managedObject valueForKey:DB_KEY_FOR_ID];
}

/**
 *iphone内部のDBに保存されているデータからevaluationを取得する
 * index: 取得するevaluationが保存された場所
 */
-(NSString*) getEvaluationFromDB :(int) index{
    NSManagedObject *managedObject = [self fetchObject:DB_PLACE WithRow:index AndSection:0];
    return [managedObject valueForKey:DB_KEY_FOR_EVAL];
}

/**
 *  DB内のデータを変更する
 * index:変更するデータが保管されている場所
 * movieId:変更後のmovieId
 * evaluation:変更後のevaluation
 */
-(void) editMovieInDB : (int) index movieId :(NSString*) movieId evaluation :(NSString*) evaluation{
    NSManagedObject *managedObject = [self fetchObject:DB_PLACE WithRow:index AndSection:0];
[managedObject setValue:movieId forKey:DB_KEY_FOR_ID];
[managedObject setValue:evaluation forKey:DB_KEY_FOR_EVAL];
[self saveContext];

}

@end