//
//  FilterLeftViewController.m
//  Buyer
//
//  Created by keke Wang on 13-1-28.
//  Copyright (c) 2013年 checkauto. All rights reserved.
//

#import "FilterLeftViewController.h"
#import "FilterScrollView.h"

@interface FilterLeftViewController ()<FilterScrollViewDataSource,FilterScrollViewDelegate>

@property (retain, nonatomic) IBOutlet FilterScrollView *AreaScrollView;
@property (retain, nonatomic) IBOutlet FilterScrollView *priceScrollView;
@property (retain, nonatomic) IBOutlet FilterScrollView *yearScrollView;

@property (retain, nonatomic) NSMutableArray *years;
@property (retain, nonatomic) NSMutableArray *prices;
@property (retain, nonatomic) NSMutableArray *areas;

@end

@implementation FilterLeftViewController

#pragma mark - Filter DataSource

-(NSDictionary*)FiterDataForView:(FilterScrollView*)view atIndex:(NSInteger)index//条件:title:tag
{
    if (view == self.yearScrollView) {
        return [self.years objectAtIndex:index];
    }else if (view == self.AreaScrollView){
        return [self.areas objectAtIndex:index];
    }else if (view == self.priceScrollView){
        return [self.prices objectAtIndex:index];
    }
    return nil;
}

-(NSInteger)numberInFiterView:(FilterScrollView*)view//个数
{
    if (view == self.yearScrollView) {
        return [self.years count];
    }else if (view == self.AreaScrollView){
        return [self.areas count];
    }else if (view == self.priceScrollView){
        return [self.prices count];
    }
    return 0;
}

#pragma mark - Filter Delegate

-(void)deleteFilterAtIndex:(NSInteger)index inView:(FilterScrollView*)view//删除一个条件
{   
    if (view == self.yearScrollView) {
        [self.years removeObjectAtIndex:index];
    }else if (view == self.AreaScrollView){
        [self.areas removeObjectAtIndex:index];
    }else if (view == self.priceScrollView){
         [self.prices removeObjectAtIndex:index];
    }
}

#pragma mark - Actions

//year
- (IBAction)AddYear:(UIButton *)sender {
    
    if (![self.years containsObject:@{@"title":sender.titleLabel.text ,@"tag":[NSNumber numberWithInt:sender.tag]}]) {
        [self.years insertObject:@{@"title":sender.titleLabel.text ,@"tag":[NSNumber numberWithInt:sender.tag]}atIndex:0];
        [self.yearScrollView addButton];
    }
}

- (IBAction)clearYear:(id)sender {
    [self.years removeAllObjects];
    [self.yearScrollView removeAllbuttons];
}


//price
- (IBAction)addPrice:(UIButton *)sender {
    if (![self.prices containsObject:@{@"title":sender.titleLabel.text ,@"tag":[NSNumber numberWithInt:sender.tag]}]) {
        [self.prices insertObject:@{@"title":sender.titleLabel.text ,@"tag":[NSNumber numberWithInt:sender.tag]}atIndex:0];
        [self.priceScrollView addButton];
    }
}

- (IBAction)clearPrice:(id)sender {
    [self.prices removeAllObjects];
    [self.priceScrollView removeAllbuttons];
}


//area
- (IBAction)addArea:(UIButton*)sender {
    if (![self.areas containsObject:@{@"title":sender.titleLabel.text ,@"tag":[NSNumber numberWithInt:sender.tag]}]) {
        [self.areas insertObject:@{@"title":sender.titleLabel.text ,@"tag":[NSNumber numberWithInt:sender.tag]}atIndex:0];
        [self.AreaScrollView addButton];
    }
}

- (IBAction)clearArea:(id)sender {
    [self.areas removeAllObjects];
    [self.AreaScrollView removeAllbuttons];
}

- (IBAction)search:(id)sender {
    [self finishSelected];
}

//将所选tag值拼串传递给委托
-(void)finishSelected
{
    
    NSMutableString *areStr = [NSMutableString string];
    NSMutableString *yearStr = [NSMutableString string];
    NSMutableString *priceStr = [NSMutableString string];
    
    for (NSDictionary *Aarea in self.areas) {
        [areStr appendString:[Aarea[@"tag"]stringValue]];
        [areStr appendString:@","];
    }
    if ([areStr length]==0) {
        [areStr appendString:@"0"];
    }
    
    for (NSDictionary *Ayear in self.years) {
        [yearStr appendString:[Ayear[@"tag"]stringValue]];
        [yearStr appendString:@","];
    }
    if ([yearStr length]==0) {
        [yearStr appendString:@"1"];
    }
    
    for (NSDictionary *Aprice in self.prices) {
        [priceStr appendString:[Aprice[@"tag"]stringValue]];
        [priceStr appendString:@","];
    }
    if ([priceStr length]==0) {
        [priceStr appendString:@"1"];
    }
    
    NSLog(@"%@\n%@\n%@\n",areStr,yearStr,priceStr);
    
    [self.fiterDelegate FinishedSelectwithArea:areStr
                                    Price:priceStr
                                     Year:yearStr];
}


#pragma mark - life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.years = [NSMutableArray array];
        self.prices = [NSMutableArray array];
        self.areas = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.yearScrollView setFilterdataSource:self];
    [self.yearScrollView setFilterdelegate:self];
    
    [self.AreaScrollView setFilterdataSource:self];
    [self.AreaScrollView setFilterdelegate:self];
    
    [self.priceScrollView setFilterdataSource:self];
    [self.priceScrollView setFilterdelegate:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_yearScrollView release];
    [_priceScrollView release];
    [_AreaScrollView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setYearScrollView:nil];
    [self setPriceScrollView:nil];
    [self setAreaScrollView:nil];
    [super viewDidUnload];
}
@end
