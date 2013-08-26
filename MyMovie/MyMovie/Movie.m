//
//  Movie.m
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/22.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import "Movie.h"

@implementation Movie

@synthesize movie_id = _movie_id;
@synthesize image = _image;
@synthesize title = _title;
@synthesize type = _type;
@synthesize evaluation = _evaluation;
@synthesize imageURL = _imageURL;
/*
- (id)initWithId:(NSString*)movieId
           Image:(UIImage*)movieImage
           Title:(NSString*)movieTitle
            Type:(NSString*)movieType
{
    self = [super init];
    
    if (self) {
        _movie_id = movieId;
        _image = movieImage;
        _title = movieTitle;
        _type = movieType;
    }
    
    return self;
}
*/

- (id)initWithId:(NSString*)movieId
        ImageURL:(NSString*)movieImageURL
           Title:(NSString*)movieTitle
            Type:(NSString*)movieType
{
    self = [super init];
    
    if (self) {
        _movie_id = movieId;
        _imageURL = movieImageURL;
        _title = movieTitle;
        _type = movieType;
    }
    
    return self;
}

/**
 * もし,Movieにevaluationがあった場合にはevaluationを呼び出す
 * evaluationのsetter
 */
-(void) setEvaluation:(NSString*)movieEvaluation{
    _evaluation = movieEvaluation;
}

-(BOOL) doesMovieHaveImage{
    if(self.image == nil){
        return YES;
    }
    else{
        return NO;
    }
}
@end
