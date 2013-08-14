//
//  FakeHUD.m
//  UIView_Animation2
//
//  Created by wang keke on 13-3-15.
//  Copyright (c) 2013年 uxin. All rights reserved.
//

#import "FakeHUD.h"
#import "UIView+Animation.h"

@implementation FakeHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id) newFakeHUD
{
	UINib *nib = [UINib nibWithNibName:@"FakeHUD" bundle:nil];
	NSArray *nibArray = [nib instantiateWithOwner:self options:nil];
    FakeHUD *me = [nibArray objectAtIndex: 0];
	return me;
}

- (IBAction)btnStop
{
	// the following method will be defined and explained later: ignore the warning
//	[self removeWithSinkAnimation:30];
    [self removeWithSkinAnimation_Custom:5];
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
