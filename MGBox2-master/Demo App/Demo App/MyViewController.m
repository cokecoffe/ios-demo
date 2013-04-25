//
//  MyViewController.m
//  MGBox Demo
//
//  Created by wang keke on 13-3-27.
//  Copyright (c) 2013年 Big Paua. All rights reserved.
//

#import "MyViewController.h"

#import "MGScrollView.h"
#import "MGTableBoxStyled.h"
#import "MGLineStyled.h"

#import "MGBox.h"

@interface MyViewController ()
{
    MGScrollView *scroller;
}
@end

@implementation MyViewController


-(void)CreateTableBox
{
    MGTableBoxStyled *table = [MGTableBoxStyled box];
    table.margin = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    
    [scroller.boxes addObject:table];
    
    //表头
    CGSize rowSize = (CGSize){304,40};
    
    MGLineStyled *header = [MGLineStyled lineWithLeft:@"我的表格" right:nil size:rowSize];
    header.leftPadding = header.rightPadding = 40;
    [table.topLines addObject:header];
    
    // 图+文字
    MGLineStyled *row1 = [MGLineStyled lineWithLeft:@"这是一匹马"
                                              right:[UIImage imageNamed:@"horse.jpeg"]
                                               size:rowSize];
    [table.topLines addObject:row1];
    
    // 文字
    MGLineStyled *row2 = MGLineStyled.line;
    row2.multilineLeft = @"This row has **bold** text, //italics// text, __underlined__ text, "
    "and some `monospaced` text. The text will span more than one line, and the row will "
    "automatically adjust its height to fit.|mush";
    row2.minHeight = 40;
    [table.topLines addObject:row2];
    
    //显示
    [scroller layoutWithSpeed:0.3 completion:nil];
    [scroller scrollToView:table withMargin:8];
}

-(void)CreateGrid
{
    CGSize gridSize = (CGSize){320,960};
    
    MGBox *grid = [MGBox boxWithSize:gridSize];
    grid.bottomPadding = 10.0;
    grid.contentLayoutMode = MGLayoutGridStyle;
    grid.borderColors = [UIColor darkGrayColor];
    [scroller.boxes addObject:grid];
    
    // add ten 100x100 boxes, with 10pt top and left margins
    for (int i = 0; i < 12; i++) {
        MGBox *box = [MGBox boxWithSize:(CGSize){80, 80}];
        
        box.leftMargin = box.topMargin = 20;//外边距
        box.backgroundColor = [UIColor darkGrayColor];
        box.layer.shadowColor = [UIColor colorWithWhite:0.12 alpha:1].CGColor;//阴影
        box.layer.shadowOffset = CGSizeMake(0, 0.5);
        box.layer.shadowRadius = 1;
        box.layer.shadowOpacity = 1;
        [self addSpinnerToBox:box];//菊花
        
        __weak MGBox *weakBox = box;
        box.asyncLayoutOnce = ^{
            
            MGBox *strongBox = weakBox;
            if (strongBox) {
                [self loadPhotoToBox:strongBox];
            }
        };
        [grid.boxes addObject:box];
    }
    
    //显示
    [grid layoutWithSpeed:1.0 completion:nil];
    [scroller layoutWithSpeed:0.3 completion:nil];
    [scroller scrollToView:grid withMargin:10];
}

#pragma mark - photobox_helper

#define TOTAL_IMAGES 28

- (void)loadPhotoToBox:(MGBox*)box {
    
    int photoTag = arc4random_uniform(TOTAL_IMAGES) + 1;
    
    // photo url
    id photosDir = @"http://bigpaua.com/images/MGBox";
    id fullPath = [NSString stringWithFormat:@"%@/%d.jpg", photosDir, photoTag];
    NSURL *url = [NSURL URLWithString:fullPath];
    
    // fetch the remote photo
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // do UI stuff back in UI land
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 清除菊花
        UIActivityIndicatorView *spinner = box.subviews.lastObject;
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        
        
        // got the photo, so lets show it
        UIImage *image = [UIImage imageWithData:data];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [box addSubview:imageView];
        imageView.size = box.size;
        imageView.alpha = 0;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
        
        // fade the image in
        [UIView animateWithDuration:0.2 animations:^{
            imageView.alpha = 1;
        }];
    });
}

- (void)addSpinnerToBox:(MGBox*)box
{
    // add a loading spinner
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.center = CGPointMake(box.width / 2, box.height / 2);
    spinner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin;
    spinner.color = UIColor.lightGrayColor;
    [box addSubview:spinner];
    [spinner startAnimating];
}


#pragma mark - lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    scroller = [MGScrollView scrollerWithSize:self.view.bounds.size];
    scroller.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    scroller.contentLayoutMode = MGLayoutGridStyle;
    [self.view addSubview:scroller];
    
    //创建一个静态的表格
    [self CreateTableBox];
    
    //创建一个格子
    [self CreateGrid];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
