//
//  AnimationCurvePicker.h
//  UIView_Animation2
//
//  Created by wang keke on 13-3-15.
//  Copyright (c) 2013年 uxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationCurvePicker : UIView

@property (nonatomic,weak) IBOutlet UITableView *animationTable;

+ (id) newAnimationCurvePicker:(id)pickDelegate;

@end
