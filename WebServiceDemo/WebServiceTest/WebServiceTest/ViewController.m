//
//  ViewController.m
//  WebServiceTest
//
//  Created by 可可 王 on 12-6-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "MBProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [textView release];
    [super dealloc];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Want to redeem: %@", textField.text);
    
    // Get device unique ID
    UIDevice *device = [UIDevice currentDevice];
    NSString *uniqueId= [device uniqueIdentifier];
    
    // Start request
    NSString *code = textField.text;
    NSURL *url = [NSURL URLWithString:@"http://www.wildfables.com/promos/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"rw_app_id"];
    [request setPostValue:code forKey:@"code"];
    [request setPostValue:uniqueId forKey:@"device_id"];
    [request setDelegate:self];
    [request startAsynchronous];
    
    // Hide keyword
    [textField resignFirstResponder];
    
    // Clear text field
    textView.text = @"";  
    
    //状态指示器
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Redeeming code...";
    return TRUE;
}

/*请求完成后回调*/
- (void)requestFinished:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (request.responseStatusCode == 400) {
        textView.text = @"Invalid code";        
    } else if (request.responseStatusCode == 403) {
        textView.text = @"Code already used";
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        NSDictionary *responseDict = [responseString JSONValue];
        NSString *unlockCode = [responseDict objectForKey:@"unlock_code"];
        
        if ([unlockCode compare:@"com.razeware.test.unlock.cake"] == NSOrderedSame) {
            textView.text = @"The cake is a lie!";
        } else {        
            textView.text = [NSString stringWithFormat:@"Received unexpected unlock code: %@", unlockCode];
        }
        
    } else {
        textView.text = @"Unexpected error";
    }
    
}
/*请求失败后回调*/
- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSError *error = [request error];
    textView.text = error.localizedDescription;
}

@end
