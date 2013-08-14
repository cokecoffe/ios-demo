//
//  CapturePauseViewController.h
//  CapturePause
//
//  Created by Geraint Davies on 27/02/2013.
//  Copyright (c) 2013 Geraint Davies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapturePauseViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *cameraView;

- (void) startPreview;
- (IBAction)startRecording:(id)sender;
- (IBAction)pauseRecording:(id)sender;
- (IBAction)stopRecording:(id)sender;
- (IBAction)resumeRecording:(id)sender;
@end
