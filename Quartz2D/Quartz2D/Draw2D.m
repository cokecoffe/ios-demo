//
//  Draw2D.m
//  Quartz2D
//
//  Created by wangkeke on 12-8-13.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "Draw2D.h"

@implementation Draw2D

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5.0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGFloat dashArray[] = {2,6,4,2};
    
    CGContextSetLineDash(context, 8, dashArray, 4);
    
    CGContextMoveToPoint(context, 0, 200);
    
    CGContextAddLineToPoint(context, 200, 200);
    
    CGContextStrokePath(context);
}


@end
