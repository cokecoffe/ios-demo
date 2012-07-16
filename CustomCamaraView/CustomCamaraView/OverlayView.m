//
//  OverlayView.m
//  CustomCamaraView
//
//  Created by Wang keke on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OverlayView.h"

@implementation OverlayView
@synthesize delegate;
@synthesize TakeBT;
@synthesize RetakeBT;
@synthesize ExitBT;
@synthesize EnterBT;
@synthesize TitleImage;
@synthesize TitleLB;
@synthesize CenterImage;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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

-(id)init
{
    self = [super init];
    if (self) {
        //initCode.
    }
    return self;
}


//将按钮的消息转发给使用相机的对象

- (IBAction)ShootPressed:(id)sender 
{
    if([delegate respondsToSelector:@selector(TakePhoto)])
    {
        [delegate TakePhoto];
    }
}

- (IBAction)CancelPressed:(id)sender
{
    if([delegate respondsToSelector:@selector(CancelTakePhoto)])
    {
        [delegate CancelTakePhoto];
    }

}
- (IBAction)EnterPressed:(id)sender 
{
    if([delegate respondsToSelector:@selector(SavedPhoto)])
    {
        [delegate SavedPhoto];
    }
}
- (IBAction)RetakePressed:(id)sender 
{
    if([delegate respondsToSelector:@selector(RetakePhoto)])
    {
        [delegate RetakePhoto];
    }
}
//end

-(void)ShowTakingView
{
    //隐藏确定重拍按钮
    [RetakeBT setHidden:YES];
    [EnterBT setHidden:YES];
    
    //显示拍摄按钮
    [TakeBT setHidden:NO];
    [ExitBT setHidden:NO];
}

-(void)ShowPreview
{
    //显示确定重拍按钮
    [RetakeBT setHidden:NO];
    [EnterBT setHidden:NO];

    //隐藏拍摄按钮
    [TakeBT setHidden:YES];
    [ExitBT setHidden:YES];
}

- (void)dealloc {
    [EnterBT release];
    [TakeBT release];
    [RetakeBT release];
    [ExitBT release];
    [TitleImage release];
    [TitleLB release];
    [CenterImage release];
    [super dealloc];
}
@end
