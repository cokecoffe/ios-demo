//
//  OverlayView.m
//  CustomCamaraView
//
//  Created by Wang keke on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OverlayView.h"

@implementation OverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //clear the background color of the overlay
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        //load an image to show in the overlay
        UIImage *searcher = [UIImage imageNamed:@"crosshair.png"];
        UIImageView *searcherView = [[UIImageView alloc]
                                     initWithImage:searcher];
        searcherView.frame = CGRectMake(30, 100, 260, 200);
        [self addSubview:searcherView];
        [searcherView release];
        
        //add a simple button to the overview
        //with no functionality at the moment
        UIButton *button = [UIButton
                            buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"Scan Now" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 430, 320, 40);
        [self addSubview:button];
    }
    return self;
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
