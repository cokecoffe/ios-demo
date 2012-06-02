//
//  Authentication.h
//  UseNetWork
//
//  Created by  vistech on 11-10-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadHelper.h"

#define COOKBOOK_PURPLE_COLOR [UIColor colorWithRed:0.20392f green:0.19607f blue:0.66176f alpha:1.0f]

@interface Authentication : UIViewController {
	NSMutableString *log;
	IBOutlet UITextView *textView;
	IBOutlet UIButton *unauthorized;
	IBOutlet UIButton *authorized;
	NSString *savePath;
}
@property(nonatomic ,retain) NSMutableString *log;
@property(nonatomic ,retain) UITextView *textView;
@property(nonatomic ,retain) UIProgressView *progress;
@property(nonatomic ,retain) NSString *savePath;
@property(nonatomic ,retain) UIButton *unauthorized;
@property(nonatomic ,retain) UIButton *authorized;

-(IBAction)unauthorized:(id)sender;
-(IBAction)authorized:(id)sender;
@end
