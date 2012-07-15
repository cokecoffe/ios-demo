//
//  WKKViewController.h
//  CameraWithAVFoudation
//
//  Created by 可可 王 on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKKViewController : UIViewController
{
    UIView *RealView;
}
@property (retain, nonatomic) UIView *RealView;
@property (retain, nonatomic) IBOutlet UIView *liveView;
@property (retain, nonatomic) IBOutlet UIImageView *Preview;
@end
