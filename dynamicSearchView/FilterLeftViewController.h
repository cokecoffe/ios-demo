//
//  FilterLeftViewController.h
//  Buyer
//
//  Created by keke Wang on 13-1-28.
//  Copyright (c) 2013年 checkauto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterDelegate.h"

@interface FilterLeftViewController : UIViewController

@property (assign,nonatomic) id<FilterDelegate>fiterDelegate;

@end
