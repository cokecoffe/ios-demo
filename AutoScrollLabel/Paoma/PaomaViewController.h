//
//  PaomaViewController.h
//  Paoma
//
//  Created by  cokecoffe on 2012-8-29.
//  Copyright 2012年 tt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoScrollLabel.h"

@interface PaomaViewController : UIViewController {
    AutoScrollLabel *autoLB;
}
@property (retain, nonatomic) IBOutlet UITextField *inputTextField;

@end
