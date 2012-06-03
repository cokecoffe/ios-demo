//
//  DetailViewController.h
//  NavigationController
//
//  Created by 可可 王 on 12-6-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    NSString *detail_title;//中间变量，没问题
    IBOutlet UILabel *ViewTitle;
}
@property (retain, nonatomic) NSString *detail_title;
@property (retain, nonatomic) IBOutlet UILabel *ViewTitle;

@end
