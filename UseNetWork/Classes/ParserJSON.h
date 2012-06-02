//
//  ParserJSON.h
//  UseNetWork
//
//  Created by  vistech on 11-10-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ParserJSON : UIViewController {
	IBOutlet UITextView *textView;
	NSMutableDictionary *dic;
	NSMutableString *jsonString;
	NSArray *jsonArray;
}
@property(nonatomic ,retain) UITextView *textView;
@property(nonatomic ,retain) NSMutableDictionary *dic;
@property(nonatomic ,retain) NSMutableString *jsonString;
@property(nonatomic ,retain) NSArray *jsonArray;

-(IBAction)pressed;
@end
