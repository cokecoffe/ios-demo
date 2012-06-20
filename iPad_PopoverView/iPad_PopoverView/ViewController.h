//
//  ViewController.h
//  iPad_PopoverView
//
//  Created by Wang keke on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopContentViewController.h"

@interface ViewController : UIViewController<UIPopoverControllerDelegate>
{
    UIPopoverController *popoverVC;
    
    //!!!
    //内容视图在nib中创建,在加载nib的时候被加载到内存。当一个视图弹出框比较多的时候不适合这种方式，而是采用即时创建.
    IBOutlet PopContentViewController *popContentVC;
}

@property(retain,nonatomic) IBOutlet PopContentViewController *popContentVC;

@end
