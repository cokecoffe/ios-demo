//
//  ViewController.m
//  HTTP
//
//  Created by 可可 王 on 12-6-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//将JSON格式的Data转换为Foundation(NSDictionary、NSData)   用来解析
//+ JSONObjectWithData:options:error:
//
//将Foundation(NSDictionary、NSData) 转换为JSon格式的NSData 用来发送
//+ dataWithJSONObject:options:error:
//
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString: @"http://api.kivaws.org/v1/loans/search.json?status=fundraising"]

#import "ViewController.h"

@interface ViewController ()

@end

/*NSDictionary提供json支持*/
@interface NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
(NSString*)urlAddress;
-(NSData*)toJSON;
@end

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data 
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self 
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;    
}
@end
/*end*/

@implementation ViewController
@synthesize statusLabel;
@synthesize UserNameField;
@synthesize PasswordField;
@synthesize activity;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [activity setHidden:YES];
}

- (void)viewDidUnload
{
    [self setUserNameField:nil];
    [self setPasswordField:nil];
    [self setStatusLabel:nil];
    [self setActivity:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc {
    [UserNameField release];
    [PasswordField release];
    [statusLabel release];
    [activity release];
    [super dealloc];
}
- (IBAction)Login:(id)sender 
{
#if 1
//POST
    
    
    NSURL* url = [NSURL URLWithString:@"http://test.checkauto.com.cn/mobile/api/ForMobileApi.aspx"];  

    //创建请求http请求对象
    NSMutableURLRequest*  request = [[NSMutableURLRequest alloc]initWithURL:url];  
    
    //生成json数据结构
    NSMutableDictionary *jsonDic = [[NSMutableDictionary alloc]init];
    [jsonDic setObject:UserNameField.text forKey:@"user"];
    [jsonDic setObject:PasswordField.text forKey:@"password"];
    [jsonDic setObject:[NSNumber numberWithInt:1234567] forKey:@"device"];
    [jsonDic setObject:[NSNumber numberWithInt:1234567] forKey:@"task"];
    [jsonDic setObject:@"login"forKey:@"req"];    
    NSData *jsData = [jsonDic toJSON];
    
    [request setHTTPBody:jsData];
    [request setHTTPMethod:@"POST"];
    
    //开始发起同步请求
    NSURLResponse *reponse;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) 
    {
        NSLog(@"Something wrong: %@",[error description]);
    }
    else 
    {       
        if (responseData) {//解析收到的JSON
            NSError *error;
            NSDictionary* json = [NSJSONSerialization 
                                  JSONObjectWithData:responseData                         
                                  options:NSJSONReadingAllowFragments 
                                  error:&error];
            
            statusLabel.text = [json objectForKey:@"message"];
            
        }
    }
    
    [jsonDic release];
    [request release];
#else 
//GET

    [activity setHidden:NO];
    [activity startAnimating];
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: 
                        kLatestKivaLoansURL];//get data
        [self performSelectorOnMainThread:@selector(fetchedData:) //prase data
                               withObject:data waitUntilDone:YES];
    });
#endif
    
}
//GET后，解析收到的JSON
- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData //1                          
                          options:NSJSONReadingAllowFragments 
                          error:&error];
    
    NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    
    
    NSLog(@"loans: %@", latestLoans); //3
    [activity stopAnimating];
    [activity setHidden:YES];

}
@end



