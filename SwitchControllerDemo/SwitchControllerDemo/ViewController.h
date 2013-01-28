//
//  ViewController.h
//  SwitchControllerDemo
//
//  Created by 可可 王 on 12-3-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowViewController.h"
#import "BlueViewController.h"

enum CURVIEW {
    BLUE = 1,
    YELLOW = 2
    };

@interface ViewController : UIViewController
{
    int curView;
    YellowViewController *yellow_controller;
    BlueViewController *blue_controller;
}

@property (retain,nonatomic) YellowViewController *yellow_controller;
@property (retain,nonatomic) BlueViewController *blue_controller;

-(IBAction)switchViews:(id)sender;

@end
