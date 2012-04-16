//
//  SwitchViewController.h
//  MultiView
//
//  Created by 睢常明 on 12-1-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlueViewController;
@class YellowViewController;

@interface SwitchViewController : UIViewController {
	YellowViewController *yellowViewController;
	BlueViewController *blueViewController;
}
@property (retain,nonatomic) YellowViewController *yellowViewController;
@property (retain,nonatomic) BlueViewController *blueViewController;

-(IBAction)switchViews:(id)sender;

@end
