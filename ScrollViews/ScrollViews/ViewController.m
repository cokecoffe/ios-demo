//
//  ViewController.m
//  ScrollViews
//
//  Created by wangkeke on 12-9-9.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UIImageView *imgView;

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;

@end

@implementation ViewController
@synthesize scrollView;
@synthesize imgView;

#pragma mark - ScrollView Delegate
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return self.imgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}

#pragma mark - Actions

//居中图片
//如果图片宽超过屏幕 x = 0,否则在中间
//如果图片高超过屏幕 y = 0,否则在中间
- (void)centerScrollViewContents
{
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imgView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imgView.frame = contentsFrame;
}

//单指双击 放大(+) 以可见范围的中心为中心点 放大
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // 1
    CGPoint pointInView = [recognizer locationInView:self.imgView];
    
    // 2
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);//缩放后的 内容视图 可见范围
    
    // 4
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

//双指单击 缩小(-)
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

#pragma mark - life Cycle

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //4 设置最小放大倍数 使图片能够在屏幕上完全显示
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.minimumZoomScale = minScale;
    
    //5 设置最大放大倍数为1倍
    self.scrollView.maximumZoomScale = 1.0;
    self.scrollView.zoomScale = minScale;
    
    //6 居中图片到scrollview
    [self centerScrollViewContents];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //1 创建图片
    UIImage *img = [UIImage imageNamed:@"photo1.png"];
    self.imgView = [[UIImageView alloc]initWithImage:img];
    self.imgView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=img.size};
    [self.scrollView addSubview:self.imgView];
    
    //2
    self.scrollView.contentSize = img.size;
    
    //3 增加手势（单指双击、双指单击）
    UITapGestureRecognizer *doubleTapRecoginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecoginzer.numberOfTapsRequired = 2;
    doubleTapRecoginzer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecoginzer];
    
    UITapGestureRecognizer *twoFingerTapRecoginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecoginzer.numberOfTapsRequired = 1;
    twoFingerTapRecoginzer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecoginzer];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
