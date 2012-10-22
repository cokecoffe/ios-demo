//
//  ViewController.h
//  WebViewDemo
//
//  Created by keke Wang on 12-9-21.
//  Copyright (c) 2012年 checkauto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>

@property (retain, nonatomic) IBOutlet UIWebView *webView;

@end
