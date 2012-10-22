//
//  ViewController.m
//  WebViewDemo
//
//  Created by keke Wang on 12-9-21.
//  Copyright (c) 2012年 checkauto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize webView;


#pragma mark –
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/1"] ) {
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"成功"
                                                     message:@"从网页中调用的" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return false;
    }
    
    return true;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"title=%@",title);
    //NSString *st = [ webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('field_1').value"];
    NSString *st = [webView stringByEvaluatingJavaScriptFromString:@"document.myform.input1.value"];
    NSLog(@"st =%@",st);
    //添加数据
    [webView stringByEvaluatingJavaScriptFromString:@"var field = document.getElementById('field_2');"
     "field.value='通过OC代码写入';"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


- (IBAction)ButtonPressed:(id)sender {
    [webView stringByEvaluatingJavaScriptFromString:@"var field = document.getElementById('field_3');"
     "field.value='test';"];
}

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate=self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc {
    [webView release];
    [super dealloc];
}
@end
