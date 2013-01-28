//
//  ViewController.h
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordDao;

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *myTableView;
	RecordDao *recordDao;
}

@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) RecordDao *recordDao;

@end