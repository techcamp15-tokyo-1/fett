//
//  LogCell.h
//  MyMovie
//
//  Created by Tetsuro Fuji on 13/08/22.
//  Copyright (c) 2013年 fett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogCell : UITableViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *jacketImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *evaluation;


@end
