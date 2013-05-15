//
//  UXViewController.m
//  WSDL2ObjC
//
//  Created by wang keke on 13-3-27.
//  Copyright (c) 2013年 uxin. All rights reserved.
//

#import "UXViewController.h"
#import "ForAndroid.h"

@interface UXViewController ()<ForAndroidSoapBindingResponseDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textField;

@end

@implementation UXViewController
- (IBAction)requestButtonPressed:(id)sender {
    
    ForAndroidSoapBinding *binding = [[ForAndroid ForAndroidSoapBinding]initWithAddress:@"http://test.checkauto.com.cn/Mobile/Service/ForAndroid.asmx"];
    binding.logXMLInOut = YES;
    
    ForAndroid_LoginAndroid *request = [[ForAndroid_LoginAndroid alloc]init];
    request.name = @"ux_mengb";
    request.password = @"666666";
    request.device = @"1111";
    
#ifdef sync
    ForAndroidSoapBindingResponse *res = [binding LoginAndroidUsingParameters:request];
    
    for(id body in res.bodyParts)
    {
        if ([body isKindOfClass:[ForAndroid_LoginAndroidResponse class]]) {
            self.textField.text = [body LoginAndroidResult];
        }
    }
#else
    
    [binding LoginAndroidAsyncUsingParameters:request delegate:self];
    
#endif
        
}

- (void) operation:(ForAndroidSoapBindingOperation *)operation
completedWithResponse:(ForAndroidSoapBindingResponse *)response
{
    for(id body in response.bodyParts)
    {
        if ([body isKindOfClass:[ForAndroid_LoginAndroidResponse class]]) {
            self.textField.text = [body LoginAndroidResult];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
