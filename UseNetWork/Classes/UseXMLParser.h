//
//  UseXMLParser.h
//  UseNetWork
//
//  Created by  vistech on 11-10-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UseXMLParser : UIViewController<NSXMLParserDelegate> {
	NSString *url;
	NSXMLParser *xmlParser;
	IBOutlet UITextView *textView;
	NSMutableString *textString;
}
@property(nonatomic ,retain) NSString *url;
@property(nonatomic ,retain) NSXMLParser *xmlParser;
@end
