//
//  MyLocalTimeSoapViewController.h
//  MyLocalTimeSoap
//
//  Created by Vincent on 10-10-24.
//  Copyright DevDiv Community 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLocalTimeSoapViewController : UIViewController {
	UITextField *field;
}

@property (nonatomic, retain) IBOutlet UITextField *field;
- (IBAction)buttonPressed:(id)sender;

@end

