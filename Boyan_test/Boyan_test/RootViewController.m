//
//  RootViewController.m
//  Boyan_test
//
//  Created by 可可 王 on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "CustomCell.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize listData;
@synthesize AllDataDic;


-(NSString*)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirctory = [paths objectAtIndex:0];
    
    return [documentsDirctory stringByAppendingPathComponent:FileName];
}

-(void)SaveInfo
{
    NSLog(@"保存");
    
    for (id key in AllDataDic)
    {
        NSLog(@"key: %@ ,value: %@",key,[AllDataDic objectForKey:key]);
    }
    
    [AllDataDic writeToFile:[self dataFilePath] atomically:YES];    
}

-(BOOL)readInfo
{
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self dataFilePath]]) 
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:[self dataFilePath]];
        self.AllDataDic = dic;
        
        [dic release];
        return  YES;
    }else 
    {
        return NO;
    }
}

#pragma mark - TextField Delegate

/*当字符串发生改变的时候就要保存数据*/
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@: string is [%@] Location [%d] Len [%d]", 
          textField.text, string, range.location, range.length); 
    
    NSString *str = textField.text;
    NSString *str_all;
    
    if (range.length == 1 &&
        [string isEqualToString:@""]) 
    {
        str_all = [str substringToIndex:([str length] - 1)];
    }else{
        str_all = [str stringByAppendingString:string];
    }
    
    NSLog(@"key = %@",[listData objectAtIndex:textField.tag]);
    
    [AllDataDic setObject:str_all forKey:[listData objectAtIndex:textField.tag]];
    
    return YES;
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (!cell) 
    {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    NSUInteger row = [indexPath row];
    cell.LabelName.text = [listData objectAtIndex:row];
    if(row<3)
    {       
        cell.InputFiled.placeholder = [self.AllDataDic objectForKey:[self.listData objectAtIndex:row]];
        cell.InputFiled.tag = row;
        cell.InputFiled.delegate = self;
        if (row == 1)// 
        {
            cell.InputFiled.keyboardType = UIKeyboardTypeNumberPad;
        }
    }
    else 
    {
        [cell.InputFiled setHidden:YES];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *array = [[NSArray alloc]initWithObjects:@"姓名",@"联系方式",@"工作年限",@"专长",nil];   
    self.listData = array;    
    [array release];
    
    if(NO == [self readInfo])//若没有本地文件
    {
        self.AllDataDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"姓名",@"请输入姓名",@"联系方式","请输入联系方式",@"工作年限",@"日期选择",nil];        
    }
}

- (void)viewDidUnload
{
    self.listData = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}
-(void)dealloc
{
    [listData release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
