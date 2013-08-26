//
//  MovieDB.h
//  MyMovie
//
//  Created by 英一 高橋 on 2013/08/24.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MovieDB : NSManagedObject

@property (nonatomic, retain) NSString * movieId;
@property (nonatomic, retain) NSString * evaluation;

@end
