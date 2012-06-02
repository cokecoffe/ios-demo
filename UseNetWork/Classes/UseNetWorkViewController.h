//
//  UseNetWorkViewController.h
//  UseNetWork
//
//  Created by  vistech on 11-9-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UseNetWorkAppDelegate.h"
#import "TestNetWorkConnection.h"
#import "TestBed.h"
#import "checkWebSitReachable.h"
#import "DownLoad.h"
#import "AsynchronousDownLoad.h"
#import "Authentication.h"
#import "UseXMLParser.h"
#import "ParserJSON.h"

@interface UseNetWorkViewController : UITableViewController {
	NSArray *netWorks;
	NSMutableDictionary *views;
	UseNetWorkAppDelegate *delegate;
	TestNetWorkConnection *testConnect;
	TestBed *testIP;
	checkWebSitReachable *webSitReachale;
	DownLoad *download;
	AsynchronousDownLoad *asynchronousDown;
	Authentication *authentication;
	UseXMLParser *useXMLParser;
	ParserJSON *parserjson;
}
@property(nonatomic ,retain) NSArray *netWorks;

@end

