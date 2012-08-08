//
//  DetailViewController.h
//  Pop_TableDemo
//
//  Created by wangkeke on 12-8-8.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController
{
    NSString *province;
    NSDictionary *citys;
}
@property (retain,nonatomic)NSString *province;
@property (retain,nonatomic)NSDictionary *citys;
@end
