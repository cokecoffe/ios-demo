//
//  ViewController.h
//  Pop_TableDemo
//
//  Created by wangkeke on 12-8-8.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPopoverControllerDelegate>
{
    UIPopoverController *popVC;
}

@property (retain, nonatomic) IBOutlet UIButton *PopButton;

-(void)setButtonTitle:(NSString*)m_title;

@end
