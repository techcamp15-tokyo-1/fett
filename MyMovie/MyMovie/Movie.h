//
//  Movie.h
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/22.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject
{
    NSString *_movie_id;
    UIImage *_image;
    NSString *_imageURL;
    NSString *_title;
    NSString *_type;
    NSString *_evaluation;
}

@property (nonatomic) NSString *movie_id;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *evaluation;
@property (nonatomic) NSString *imageURL;
/*
- (id)initWithId:(NSString*)movieId
           Image:(UIImage*)movieImage
           Title:(NSString*)movieTitle
            Type:(NSString*)movieType;
*/

- (id)initWithId:(NSString*)movieId
        ImageURL:(NSString*)movieImageURL
           Title:(NSString*)movieTitle
            Type:(NSString*)movieType;

- (void) setEvaluation:(NSString*)evaluation;

- (BOOL) doesMovieHaveImage;
@end
