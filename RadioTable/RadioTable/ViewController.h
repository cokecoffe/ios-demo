//
//  ViewController.h
//  RadioTable
//
//  Created by Wang keke on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioTableController.h"


@interface ViewController : UIViewController<UIPopoverControllerDelegate,SelectTableDelegate,provideTableDataDelegate>
{
    UIPopoverController *popVC;
    IBOutlet UIButton *selectBT;
}
@property (retain, nonatomic) IBOutlet RadioTableController *myRadioTable;
@property (retain, nonatomic) IBOutlet UIButton *selectBT;
@end
