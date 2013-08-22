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

@end
