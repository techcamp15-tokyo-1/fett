//
//  MovieSearcher.h
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/22.
//  Copyright (c) 2013年 fett. All rights reserved.
//

/*
 * 映画情報をHTTPリクエストで取得するクラス．
 */


#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import "Movie.h"

@interface MovieSearcher : NSObject
{
    // 通信中かどうか
    BOOL transmitting;
    
    // リクエスト結果
    NSDictionary *receivedData;
}

// 映画IDから映画情報を取得．
- (Movie*)getMovieFromId:(NSString*)movieId;

// キーワードから映画リストを取得．
- (NSArray*)getMovieFromTerm:(NSString*)term;

@end
