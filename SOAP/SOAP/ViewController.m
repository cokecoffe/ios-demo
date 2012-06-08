//
//  ViewController.m
//  SOAP
//
//  Created by Wang keke on 12-6-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/* ***** ***** ***** ***** ***** ***** ***** ***** ***** ***** 
 以下是 SOAP 1.2 请求和响应示例。所显示的占位符需替换为实际值。
 
 请求：
 POST /Mobile/Service/ForAndroid.asmx HTTP/1.1
 Host: test.checkauto.com.cn
 Content-Type: text/xml; charset=utf-8
 Content-Length: length
 SOAPAction: "http://chake.net/Login"
 
 <?xml version="1.0" encoding="utf-8"?>
 <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
 <soap:Body>
 <Login xmlns="http://chake.net/">
 <name>string</name>
 <password>string</password>
 <device>string</device>
 </Login>
 </soap:Body>
 </soap:Envelope>

 响应：
 HTTP/1.1 200 OK
 Content-Type: text/xml; charset=utf-8
 Content-Length: length
 
 <?xml version="1.0" encoding="utf-8"?>
 <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
 <soap:Body>
 <LoginResponse xmlns="http://chake.net/">
 <LoginResult>string</LoginResult>
 </LoginResponse>
 </soap:Body>
 </soap:Envelope>
 ***** ***** ***** ***** ***** ***** ***** ***** ***** *****/



#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize nameInput;
@synthesize passwordInput;
@synthesize deviceInput;
@synthesize greeting;
@synthesize webData;
@synthesize tmpValue;
@synthesize xmlParser;
@synthesize jsonStr;


-(IBAction)buttonClick: (id) sender
{
    greeting.text = @"获取数据中...";	
	[nameInput resignFirstResponder];
    [passwordInput resignFirstResponder];
    [deviceInput resignFirstResponder];
    
	[self getLoginInfo];
}

- (void)getLoginInfo
{
    recordResults = NO;
    /*soap消息封装*/
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<Login xmlns=\"http://chake.net/\">\n"
                             "<name>%@</name>\n"
                             "<password>%@</password>\n"
                             "<device>%@</device>\n"
                             "</Login>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",nameInput.text,passwordInput.text,deviceInput.text];
    
    NSLog(@"soap消息为%@",soapMessage);
    
    //请求发送到的路径
	NSURL *url = [NSURL URLWithString:@"http://test.checkauto.com.cn/Mobile/Service/ForAndroid.asmx"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    //为请求添加属性
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://chake.net/Login" forHTTPHeaderField:@"SOAPAction"];	
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];    
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	//如果连接已经建好，则初始化data
	if( theConnection )
	{
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}

}
#pragma mark - ConnectDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
	NSLog(@"connection: didReceiveResponse:1");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
	NSLog(@"connection: didReceiveData:2");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
	[connection release];
	[webData release];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"3 DONE. Received Bytes: %d", [webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
	NSLog(theXML);
	[theXML release];
	
	//重新加載xmlParser
	if( xmlParser )
	{
		[xmlParser release];
	}
	
	xmlParser = [[NSXMLParser alloc] initWithData: webData];
	[xmlParser setDelegate: self];
	[xmlParser setShouldResolveExternalEntities: YES];
	[xmlParser parse];
	
	[connection release];
    
    
    if(![jsonStr isEqualToString:@""])
    {
        NSLog(@"%@",jsonStr);
              
        
        //json String->Data
        NSData *jsData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];        

        //Data->Dictionary
        NSError *error;
        NSDictionary *jsDic =  [NSJSONSerialization JSONObjectWithData:jsData options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"字典内");
        NSLog(@"%@",jsDic);
        
        greeting.text = [jsDic objectForKey:@"message"];
        
    }   
    [webData release];
}
#pragma mark -
#pragma mark PraserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	NSLog(@"-------------------start--------------");
    tmpValue = [[NSMutableString alloc]initWithString:@""];//用来临时存储解析出来的元素的值
    
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"-------------------end--------------");
    [tmpValue release];
}


/*遇到可解析的元素，开始解析此元素*/
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{   
    if( [elementName isEqualToString:@"LoginResult"])
	{
        NSLog(@"Node%@:开始解析",elementName);
		jsonStr = [[NSMutableString alloc]initWithString:@""];
	}
	
    [tmpValue appendString:@""];
}
/*如果此元素有值，则回调这个函数*/
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	NSLog(@"Value:%@",string);
    if (![string isEqualToString:@""]) 
    {
        [tmpValue appendString:string];
    }
    
    
}
/*解析此元素完毕*/
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //对所有元素的值进行分类处理
    if ([elementName isEqualToString:@"LoginResult"])
    {
        NSLog(@"Node%@:解析完毕",elementName);
        [jsonStr appendString:tmpValue];       
    }    
}


#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setPasswordInput:nil];
    [self setDeviceInput:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc
{
    [xmlParser release];
    [greeting release];
    [passwordInput release];
    [deviceInput release];
    [super dealloc];
}
@end
