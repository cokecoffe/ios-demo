//
//  CCLevelView.h
//  LevelView
//
//  Created by keke Wang on 13-7-11.
//  Copyright (c) 2013年 keke Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCLevelView : UIView

@property (assign,nonatomic) NSInteger level;

@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;

@end
