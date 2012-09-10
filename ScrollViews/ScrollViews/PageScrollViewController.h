//
//  PageScrollViewController.h
//  ScrollViews
//
//  Created by wangkeke on 12-9-10.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageScrollViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@end
