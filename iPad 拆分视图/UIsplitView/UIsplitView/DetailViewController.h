//
//  DetailViewController.h
//  UIsplitView
//
//  Created by 可可 王 on 12-5-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    IBOutlet UILabel *TextLabel;
    id detailItem;
}

@property (nonatomic,retain) id detailItem;
@property (nonatomic,retain) IBOutlet UILabel *TextLabel;
- (IBAction)Click:(id)sender;

@end
