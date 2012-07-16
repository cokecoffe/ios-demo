//
//  OverlayView.h
//  CustomCamaraView
//
//  Created by Wang keke on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CamaraDelegate;

@interface OverlayView : UIView
{
    id<CamaraDelegate>delegate;
}

//Left View
@property (retain, nonatomic) IBOutlet UIImageView *TitleImage;
@property (retain, nonatomic) IBOutlet UILabel *TitleLB;

//驾驶证瞄准
@property (retain, nonatomic) IBOutlet UIImageView *CenterImage;


//Right View
@property (assign,nonatomic) id<CamaraDelegate>delegate;
@property (retain, nonatomic) IBOutlet UIButton *TakeBT;
@property (retain, nonatomic) IBOutlet UIButton *RetakeBT;
@property (retain, nonatomic) IBOutlet UIButton *ExitBT;
@property (retain, nonatomic) IBOutlet UIButton *EnterBT;


-(void)ShowTakingView;
-(void)ShowPreview;
@end


////////////////////////////////////////////////////////
@protocol CamaraDelegate <NSObject>

-(void)TakePhoto;
-(void)CancelTakePhoto;
-(void)RetakePhoto;
-(void)SavedPhoto;

@end
