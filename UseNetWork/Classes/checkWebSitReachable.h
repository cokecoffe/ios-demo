//
//  checkWebSitReachable.h
//  UseNetWork
//
//  Created by  vistech on 11-9-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface checkWebSitReachable : UIViewController {
	IBOutlet UITextView *textView;
	IBOutlet UIButton *btn;
	NSMutableString *log;
}
@property(nonatomic ,retain)UITextView *textView;
@property(nonatomic ,retain)UIButton *btn;
@property(nonatomic ,retain)NSMutableString *log;
@end
