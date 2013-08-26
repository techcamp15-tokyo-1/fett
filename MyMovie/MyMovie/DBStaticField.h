//
//  DBStaticField.h
//  MyMovie
//
//  Created by 英一 高橋 on 2013/08/25.
//  Copyright (c) 2013年 fett. All rights reserved.
//

//データベースからデータを取得するときに必要な変数
#import <Foundation/Foundation.h>

@interface DBStaticField : NSObject

//ManageObjectを作るときに使う
extern NSString* DB_PLACE;
//ManageObjectからIDを取得するときに使う変数
extern NSString* DB_KEY_FOR_ID;
//ManageobjectらEvaluationを取得するときに使う変数
extern NSString* DB_KEY_FOR_EVAL;
@end
