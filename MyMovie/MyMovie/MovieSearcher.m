//
//  MovieSearcher.m
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/22.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import "MovieSearcher.h"
#import "Const.h"

@implementation MovieSearcher

// 映画IDから映画情報を取得．
- (Movie*)getMovieFromId:(NSString*)movieId
{
    int initial = [[movieId substringToIndex:1] intValue];
    NSString *key = [movieId substringWithRange:NSMakeRange(1,[movieId length]-1)];
    
    NSString *url;
    
    switch (initial)
    {
        case ITUNES:
            url = [self getUrlForiTunesWithKey:key];
            break;
        case GOOGLE:
            break;
        case ELSE:
            url = @"";
            break;
    }
    NSDictionary* resultDictionary = [self getMovieArrayWithURLString:url];
//    NSArray *movies = [self getMovieArrayWithURLString:url];
    NSArray *movies;
    switch (initial)
    {
        case ITUNES:
            movies = [self dictionaryToMovieArrayWithDictionary:resultDictionary];
            break;
        case GOOGLE:
            break;
        case ELSE:
            url = @"";
            break;
    }
    
    
    return [movies objectAtIndex:0];
}


// キーワードから映画リストを取得．
- (NSArray*)getMovieFromTerm:(NSString*)term
{
    NSString *url = [self getUrlForiTunesWithTerm:term];
    
    NSDictionary* itunesResultDictionary = [self getMovieArrayWithURLString:url];
    
    //Google番は後で実装を行った後コメントを外す
//    NSDictionary*googleResultDictionary;
    
    
    return [self dictionaryToMovieArrayWithDictionary:itunesResultDictionary];
}



// URLをHTTPリクエストした結果のリストを返す．
- (NSDictionary*)getMovieArrayWithURLString:(NSString*)url
{
    transmitting = YES;
    [SVProgressHUD show];
    __block BOOL isFinishConnection = NO;
    int i = 0;

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (!error) {
                                   NSError* parseError;
                                   id parse = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:NSJSONReadingMutableContainers
                                                                                error:&parseError];
//                                   transmitting = NO;
                                   receivedData = (NSDictionary*)parse;
                                   [SVProgressHUD dismiss];
                                   isFinishConnection = YES;
                               }
                           }];
    do{
        i++;
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
        NSLog(@"isFinish=%d",isFinishConnection);

    }while(isFinishConnection);
//    return nil;
    return receivedData;
//    return [self dictionaryToMovieArrayWithDictionary:receivedData];
}

// NSDictionary型 から Movie の NSArray に変換．
- (NSArray*)dictionaryToMovieArrayWithDictionary:(NSDictionary*)data
{
    NSMutableArray *movieArray = [NSMutableArray array];
    NSDictionary *dictionary = [data objectForKey:@"results"];
    for(NSDictionary *result in dictionary){
        [movieArray addObject:[self createMovieFromJSONForITunes:result]];
    }
    return (NSArray*)movieArray;
}

/**
 * ITuneから返ってきたJSONをMovieクラスに変更する。
 * result : JSONの一つのresultを入れる
 * 戻り値 : 引数をMoVieクラスに変更したものが返ってくる
 */
-(Movie*) createMovieFromJSONForITunes: (NSDictionary*) result{
    //iTuneIdの取得
    NSString *movieId = [result objectForKey:@"trackId"];
    //タイトルの取得
    NSString *movieTitle = [result objectForKey:@"trackCensoredName"];
    //ジャンルの取得
    NSString *movieType = [result objectForKey:@"primaryGenreName"];
    //映画の画像の取得
    NSString *imageUrl = [result objectForKey:@"artworkUrl30"];
    id path = imageUrl;
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *movieImage = [[UIImage alloc]initWithData:data];
    
    return [[Movie alloc] initWithId:movieId Image:movieImage Title:movieTitle Type:movieType];
}

// iTunes Api用のリクエストURLを生成．
- (NSString*)getUrlForiTunesWithKey:(NSString*)movieId
{
    NSString *result = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?country=JP&id=%@",movieId];
    
    return result;
}
- (NSString*)getUrlForiTunesWithTerm:(NSString*)term
{
    NSString *result =
    [NSString stringWithFormat:@"https://itunes.apple.com/search?country=JP&entity=movie&term=%@",term];
    return result;
}

// Google Api用のリクエストURLを生成．


@end
