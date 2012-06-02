//
//  RootViewController.h
//  ipad.demo
//
//  Created by wangjun on 10-10-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailViewController;
@interface RootViewController : UITableViewController {

	IBOutlet DetailViewController *detailViewController;
	
}
@property (nonatomic,retain) DetailViewController *detailViewController;
@end
