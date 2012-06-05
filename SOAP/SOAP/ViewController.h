//
//  ViewController.h
//  SOAP
//
//  Created by Wang keke on 12-6-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDelegate,NSXMLParserDelegate>
{
    IBOutlet UITextField *nameInput;
    IBOutlet UILabel *greeting;
    NSMutableData *webData;
    NSMutableString *tmpValue;
    NSMutableString *jsonStr;
    NSXMLParser *xmlParser;
    BOOL recordResults;
}

@property(nonatomic, retain) IBOutlet UITextField *nameInput;
@property (retain, nonatomic) IBOutlet UITextField *passwordInput;
@property (retain, nonatomic) IBOutlet UITextField *deviceInput;

@property(nonatomic, retain) IBOutlet UILabel *greeting;
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *tmpValue;
@property(nonatomic, retain) NSMutableString *jsonStr;
@property(nonatomic, retain) NSXMLParser *xmlParser;
-(IBAction)buttonClick: (id) sender;
- (void)getLoginInfo;

@end
