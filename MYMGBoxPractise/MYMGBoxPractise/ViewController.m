//
//  ViewController.m
//  MYMGBoxPractise
//
//  Created by keke Wang on 12-12-18.
//  Copyright (c) 2012年 Uxin. All rights reserved.
//

#import "ViewController.h"
#import "MGTableBoxStyled.h"
#import "MGLine.h"
#import "MGLayoutBox.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.scroller = [MGScrollView scrollerWithSize:self.view.bounds.size];
    [self.view addSubview:self.scroller];
    
   // [self setupTable];
    [self setupGrid];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建1个表格
-(void)setupTable
{
  
    MGTableBoxStyled *section = [MGTableBoxStyled box];
    [self.scroller.boxes addObject:section];
        
    // a default row size
    CGSize rowSize = (CGSize){740, 40};
    
    // 头
    MGLine *header = [MGLine lineWithLeft:@"My First Table"
                                    right:nil
                                     size:rowSize];
    header.leftPadding = header.rightPadding = 16;
    [section.topLines addObject:header];
    
    // 单行文本
    MGLine *row1 = [MGLine lineWithLeft:@"Left text"
                                  right:[UIImage imageNamed:@"arrow.png"]
                                   size:rowSize];
    row1.leftPadding = row1.rightPadding = 16;
    [section.topLines addObject:row1];
    
    // 多行文本
    MGLine *row2 = [MGLine multilineWithText:@"This row has **bold** text, //italics// text, __underlined__ text, "
                    "and some `monospaced` text. The text will span more than one line, and the row will "
                    "automatically adjust its height to fit.|mush"
                                        font:nil
                                       width:740
                                     padding:UIEdgeInsetsMake(16, 16, 16, 16)];
    [section.topLines addObject:row2];    

    [self.scroller layoutWithSpeed:0.3 completion:nil];
    [self.scroller scrollToView:section withMargin:8];
}


-(void)setupGrid
{
    CGSize gridSize = (CGSize){400, 400};
    
    MGBox *grid = [MGBox boxWithSize:gridSize];
    grid.contentLayoutMode = MGLayoutStackHorizontal;
    [self.scroller.boxes addObject:grid];
    
    // add ten 100x100 boxes, with 10pt top and left margins
    for (int i = 0; i < 10; i++) {
        MGTableBoxStyled *menu = MGTableBoxStyled.box;
        [grid.boxes addObject:menu];
        
        // header line
        MGLine *header = [MGLine lineWithLeft:@"MGBox Demo" right:nil size:(CGSize){400,40}];
        header.leftPadding = header.rightPadding = 16;
        [menu.topLines addObject:header];
    }
    
    [grid layoutWithSpeed:0.3 completion:nil];
    [self.scroller layoutWithSpeed:0.3 completion:nil];
    [self.scroller scrollToView:grid withMargin:10];
}


@end
