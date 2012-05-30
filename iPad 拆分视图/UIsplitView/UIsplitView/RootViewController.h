//
//  RootViewController.h
//  UIsplitView
//
//  Created by 可可 王 on 12-5-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface RootViewController : UITableViewController
{
    DetailViewController *detailVC;
}

@property (nonatomic,retain) IBOutlet DetailViewController *detailVC;

@end
