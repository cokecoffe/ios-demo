//
//  AnimationCurvePicker.m
//  UIView_Animation2
//
//  Created by wang keke on 13-3-15.
//  Copyright (c) 2013年 uxin. All rights reserved.
//

#import "AnimationCurvePicker.h"

@implementation AnimationCurvePicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id) newAnimationCurvePicker:(id)pickerDelegate
{
    UINib *nib = [UINib nibWithNibName:@"AnimationCurvePicker" bundle:nil];
    NSArray *nibArray = [nib instantiateWithOwner:self options:nil];
    AnimationCurvePicker *me = [nibArray objectAtIndex: 0];
    me.animationTable.delegate = pickerDelegate;
    me.animationTable.dataSource = pickerDelegate;
    return me;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
