//
//  ViewController.h
//  animations
//
//  Created by v2m  on 11-10-28.
//  Copyright (c) 2011年 DT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITabBarControllerDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *lImage;
@property (retain, nonatomic) IBOutlet UIImageView *mImage;
- (IBAction)blockPress:(id)sender;
- (IBAction)viewPress:(id)sender;
- (IBAction)caPress:(id)sender;
@end
