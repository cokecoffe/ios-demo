//
//  TableViewViewController.h
//  TableView
//
//  Created by xwwang on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface TableViewViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,UIScrollViewDelegate> {
    
    UITableView   *m_table;
    CGFloat   height;
    
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    NSMutableArray * mutableArr;
	
}

@property(nonatomic,retain)UITableView   *m_table;

@end
