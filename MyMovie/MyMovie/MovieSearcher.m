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
    
    NSArray *movies = [self getMovieArrayWithURLString:url];
    return [movies objectAtIndex:0];
}


// キーワードから映画リストを取得．
- (NSArray*)getMovieFromTerm:(NSString*)term
{
    NSString *url = [self getUrlForiTunesWithTerm:term];
    
    return [self getMovieArrayWithURLString:url];
}



// URLをHTTPリクエストした結果のリストを返す．
- (NSArray*)getMovieArrayWithURLString:(NSString*)url
{
    transmitting = YES;
    [SVProgressHUD show];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (!error) {
                                   NSError* parseError;
                                   id parse = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:NSJSONReadingMutableContainers
                                                                                error:&parseError];
                                   transmitting = NO;
                                   receivedData = (NSDictionary*)parse;
                                   [SVProgressHUD dismiss];
                               }
                           }];
    
    return [self dictionaryToMovieArrayWithDictionary:receivedData];
}

// NSDictionary型 から Movie の NSArray に変換．
- (NSArray*)dictionaryToMovieArrayWithDictionary:(NSDictionary*)data
{
    return nil;
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
