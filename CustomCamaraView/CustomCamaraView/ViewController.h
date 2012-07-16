//
//  ViewController.h
//  CustomCamaraView
//
//  Created by Wang keke on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"

@interface ViewController : UIViewController<CamaraDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImagePickerController *m_picker;
}
@end
