//
//  TestBed.h
//  UseNetWork
//
//  Created by  vistech on 11-9-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TestBed : UIViewController {
	NSMutableString *log;
	IBOutlet UITextView *textView;
}
@property(nonatomic ,retain)NSMutableString *log;
-(IBAction)action:(id)sender;
@end
