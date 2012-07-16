//
//  ViewController.m
//  CustomCamaraView
//
//  Created by Wang keke on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "OverlayView.h"

@interface ViewController ()

@end

@implementation ViewController


#pragma mark - 
#pragma mark Camera Delegate

-(void)TakePhoto
{
    [m_picker takePicture];
}

-(void)CancelTakePhoto
{
    [m_picker dismissModalViewControllerAnimated:YES]; 
    [m_picker release];
}
-(void)RetakePhoto
{
    [[[m_picker.cameraOverlayView subviews]objectAtIndex:0]removeFromSuperview];
    [m_picker.cameraOverlayView ShowTakingView];
}
-(void)SavedPhoto
{
    [m_picker dismissModalViewControllerAnimated:YES];
}


#pragma mark -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *t_Photo = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSLog(@"OriginImage size:width = %f height = %f",t_Photo.size.width,t_Photo.size.height);
     
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 1024.0, 768.0)];
    [imgView setImage:t_Photo];
    
    [picker.cameraOverlayView insertSubview:imgView atIndex:0];
    [imgView release];
  
    [picker.cameraOverlayView ShowPreview];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancel");
}

- (IBAction)catch:(id)sender 
{
    //create an overlay view instance from nib    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"OverlayView"
                                                      owner:self
                                                    options:nil];    
    OverlayView *overlay = [nibViews objectAtIndex: 0];    
    [overlay ShowTakingView];
    [overlay setDelegate:self];
    
    
    //create a new image picker instance
<<<<<<< HEAD
    m_picker =[[UIImagePickerController alloc] init];

    //set source to Camera!
    m_picker.sourceType = UIImagePickerControllerSourceTypeCamera;

=======
    picker =[[UIImagePickerController alloc] init];
    //set source to video!
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
>>>>>>> b4587b669f941c77600260b8fe3fd0122a737228
    //hide all controls
    m_picker.showsCameraControls = NO;
    m_picker.navigationBarHidden = YES;
    m_picker.toolbarHidden = YES;
    
    //make the video preview full size
    m_picker.wantsFullScreenLayout = YES;
 
    m_picker.cameraOverlayView = overlay;
    
    //set Delegate
    [m_picker setDelegate:self];
       
    //show picker
    [self presentModalViewController:m_picker animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self catch:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
<<<<<<< HEAD
    m_picker = nil;
}

-(void)dealloc
{
    [m_picker release];
    [super dealloc];
=======
    [picker release];
>>>>>>> b4587b669f941c77600260b8fe3fd0122a737228
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        return NO;
    }
  
    CGAffineTransform transform = picker.cameraOverlayView.transform;
    transform = CGAffineTransformRotate(transform, 1);
    [picker.cameraOverlayView setTransform:transform];
  

    return YES;
}



@end
