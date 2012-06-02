//
//  TestNetWorkConnection.h
//  UseNetWork
//
//  Created by  vistech on 11-9-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface TestNetWorkConnection : UIViewController {
	Reachability *hostReach;
}
@property (nonatomic ,retain) Reachability *hostReach;

-(IBAction)buttonPressed:(id)sender;
-(IBAction)testNetWorkKind:(id)sender;

@end
