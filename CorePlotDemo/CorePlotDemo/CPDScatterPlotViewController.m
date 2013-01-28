//
//  CPDScatterPlotViewController.m
//  CorePlotDemo
//
//  Created by Fahim Farook on 19/5/12.
//  Copyright 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import "CPDScatterPlotViewController.h"

@implementation CPDScatterPlotViewController

@synthesize hostView = hostView_;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UIViewController lifecycle methods
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initPlot];
}

#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];    
}

-(void)configureHost {  
	self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
	self.hostView.allowPinchScaling = YES;    
	[self.view addSubview:self.hostView];    
}

-(void)configureGraph {
	// 1 - Create the graph
	CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
	[graph applyTheme:[CPTTheme themeNamed:kCPTStocksTheme]];
	self.hostView.hostedGraph = graph;
	// 2 - Set graph title
	NSString *title = @"Portfolio Prices: April 2012";
	graph.title = title;  
	// 3 - Create and set text style
	CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
	titleStyle.color = [CPTColor whiteColor];
	titleStyle.fontName = @"Helvetica-Bold";
	titleStyle.fontSize = 16.0f;
	graph.titleTextStyle = titleStyle;
	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
	graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
    
    graph.plotAreaFrame.borderLineStyle = nil;//边框无
    graph.plotAreaFrame.cornerRadius = 10.0f ;
    
    graph.paddingLeft = 0.0;//graph的边界
    graph.paddingRight = 0.0;
    graph.paddingTop = 0.0;
    graph.paddingBottom = 0.0;
    
	// 4 - Set padding for plot area
	[graph.plotAreaFrame setPaddingLeft:20.0f];
	[graph.plotAreaFrame setPaddingBottom:20.0f];
	// 5 - Enable user interactions for plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	plotSpace.allowsUserInteraction = NO;
}

-(void)configurePlots { 
	// 1 - Get graph and plot space
	CPTGraph *graph = self.hostView.hostedGraph;
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	// 2 - Create the three plots
	CPTScatterPlot *aaplPlot = [[CPTScatterPlot alloc] init];
	aaplPlot.dataSource = self;
	aaplPlot.identifier = CPDTickerSymbolAAPL;
	CPTColor *aaplColor = [CPTColor redColor];
	[graph addPlot:aaplPlot toPlotSpace:plotSpace];    
	CPTScatterPlot *googPlot = [[CPTScatterPlot alloc] init];
	googPlot.dataSource = self;
	googPlot.identifier = CPDTickerSymbolGOOG;
	CPTColor *googColor = [CPTColor greenColor];
	[graph addPlot:googPlot toPlotSpace:plotSpace];    
	CPTScatterPlot *msftPlot = [[CPTScatterPlot alloc] init];
	msftPlot.dataSource = self;
	msftPlot.identifier = CPDTickerSymbolMSFT;
	CPTColor *msftColor = [CPTColor blueColor];
	[graph addPlot:msftPlot toPlotSpace:plotSpace];  
	// 3 - Set up plot space
	[plotSpace scaleToFitPlots:[NSArray arrayWithObjects:aaplPlot, googPlot, msftPlot, nil]];
	CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
	[xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];        
	plotSpace.xRange = xRange;
	CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
	[yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
	plotSpace.yRange = yRange;    
	// 4 - Create styles and symbols
	CPTMutableLineStyle *aaplLineStyle = [aaplPlot.dataLineStyle mutableCopy];
	aaplLineStyle.lineWidth = 2.5;
	aaplLineStyle.lineColor = aaplColor;
	aaplPlot.dataLineStyle = aaplLineStyle;
	CPTMutableLineStyle *aaplSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	aaplSymbolLineStyle.lineColor = aaplColor;
	CPTPlotSymbol *aaplSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	aaplSymbol.fill = [CPTFill fillWithColor:aaplColor];
	aaplSymbol.lineStyle = aaplSymbolLineStyle;
	aaplSymbol.size = CGSizeMake(6.0f, 6.0f);
	aaplPlot.plotSymbol = aaplSymbol;
    
    // 创建渐变区
    CPTColor *areaColor = [CPTColor colorWithComponentRed:255.0 green:255.0 blue:255.0 alpha:1.0];// 渐变色 1
    CPTGradient *areaGradient =[CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];//创建一个颜色渐变：从 建变色 1 渐变到 无色
    CPTFill *areaGradientFill = [ CPTFill fillWithGradient :areaGradient];// 创建一个颜色填充：以颜色渐变进行填充
    areaGradient. angle = - 90.0f ;// 渐变角度： -90 度（顺时针旋转）
    aaplPlot.areaFill = areaGradientFill;    // 为图形 1 设置渐变区
    aaplPlot. areaBaseValue = CPTDecimalFromString ( @"0.0" );// 渐变区起始值，小于这个值的图形区域不再填充渐变色
    //
    
    
	CPTMutableLineStyle *googLineStyle = [googPlot.dataLineStyle mutableCopy];
	googLineStyle.lineWidth = 1.0;
	googLineStyle.lineColor = googColor;
	googPlot.dataLineStyle = googLineStyle;
	CPTMutableLineStyle *googSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	googSymbolLineStyle.lineColor = googColor;
	CPTPlotSymbol *googSymbol = [CPTPlotSymbol starPlotSymbol];
	googSymbol.fill = [CPTFill fillWithColor:googColor];
	googSymbol.lineStyle = googSymbolLineStyle;
	googSymbol.size = CGSizeMake(6.0f, 6.0f);
	googPlot.plotSymbol = googSymbol;       
	CPTMutableLineStyle *msftLineStyle = [msftPlot.dataLineStyle mutableCopy];
	msftLineStyle.lineWidth = 2.0;
	msftLineStyle.lineColor = msftColor;
	msftPlot.dataLineStyle = msftLineStyle;  
	CPTMutableLineStyle *msftSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	msftSymbolLineStyle.lineColor = msftColor;
	CPTPlotSymbol *msftSymbol = [CPTPlotSymbol diamondPlotSymbol];
	msftSymbol.fill = [CPTFill fillWithColor:msftColor];
	msftSymbol.lineStyle = msftSymbolLineStyle;
	msftSymbol.size = CGSizeMake(6.0f, 6.0f);
	msftPlot.plotSymbol = msftSymbol;      
}

-(void)configureAxes {
	// 1 - Create styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor whiteColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 8.0f;
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 2.0f;
	axisLineStyle.lineColor = [CPTColor whiteColor];
	CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
	axisTextStyle.color = [CPTColor whiteColor];
	axisTextStyle.fontName = @"Helvetica-Bold";    
	axisTextStyle.fontSize = 8.0f;
	CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor whiteColor];
	tickLineStyle.lineWidth = 2.0f;
	CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor blackColor];
	tickLineStyle.lineWidth = 1.0f;
    
	// 2 - Get axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
	// 3 - Configure x-axis
	CPTAxis *x = axisSet.xAxis;
	x.title = @"Day of Month"; 
	x.titleTextStyle = axisTitleStyle;    
	x.titleOffset = 15.0f;
	x.axisLineStyle = axisLineStyle;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	x.labelTextStyle = axisTextStyle;    
	x.majorTickLineStyle = axisLineStyle;
	x.majorTickLength = 4.0f;
	x.tickDirection = CPTSignNegative;
	CGFloat dateCount = [[[CPDStockPriceStore sharedInstance] datesInMonth] count];
	NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
	NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount]; 
	NSInteger i = 0;
	for (NSString *date in [[CPDStockPriceStore sharedInstance] datesInMonth]) {
		CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:date  textStyle:x.labelTextStyle];
		CGFloat location = i++;
		label.tickLocation = CPTDecimalFromCGFloat(location);
		label.offset = x.majorTickLength;
		if (label) {
			[xLabels addObject:label];
			[xLocations addObject:[NSNumber numberWithFloat:location]];                        
		}
	}
	x.axisLabels = xLabels;    
	x.majorTickLocations = xLocations;
	// 4 - Configure y-axis
	CPTAxis *y = axisSet.yAxis;    
	y.title = @"Price";
	y.titleTextStyle = axisTitleStyle;
	y.titleOffset = -40.0f;       
	y.axisLineStyle = axisLineStyle;
	y.majorGridLineStyle = gridLineStyle;
	y.labelingPolicy = CPTAxisLabelingPolicyNone;
	y.labelTextStyle = axisTextStyle;    
	y.labelOffset = 16.0f;
	y.majorTickLineStyle = axisLineStyle;
	y.majorTickLength = 4.0f;
	y.minorTickLength = 2.0f;    
	y.tickDirection = CPTSignPositive;
	NSInteger majorIncrement = 200;
	NSInteger minorIncrement = 100;
	CGFloat yMax = 800.0f;  // should determine dynamically based on max price
	NSMutableSet *yLabels = [NSMutableSet set];
	NSMutableSet *yMajorLocations = [NSMutableSet set];
	NSMutableSet *yMinorLocations = [NSMutableSet set];
	for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
		NSUInteger mod = j % majorIncrement;
		if (mod == 0) {
			CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
			NSDecimal location = CPTDecimalFromInteger(j); 
			label.tickLocation = location;
			label.offset = -y.majorTickLength - y.labelOffset;
			if (label) {
				[yLabels addObject:label];
			}
			[yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
		} else {
			[yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
		}
	}
	y.axisLabels = yLabels;    
	y.majorTickLocations = yMajorLocations;
	y.minorTickLocations = yMinorLocations; 
}

#pragma mark - Rotation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
	return [[[CPDStockPriceStore sharedInstance] datesInMonth] count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
	NSInteger valueCount = [[[CPDStockPriceStore sharedInstance] datesInMonth] count];
	switch (fieldEnum) {
		case CPTScatterPlotFieldX:
			if (index < valueCount) {
				return [NSNumber numberWithUnsignedInteger:index];
			}
			break;
			
		case CPTScatterPlotFieldY:
			if ([plot.identifier isEqual:CPDTickerSymbolAAPL] == YES) {
				return [[[CPDStockPriceStore sharedInstance] monthlyPrices:CPDTickerSymbolAAPL] objectAtIndex:index];
			} else if ([plot.identifier isEqual:CPDTickerSymbolGOOG] == YES) {
				return [[[CPDStockPriceStore sharedInstance] monthlyPrices:CPDTickerSymbolGOOG] objectAtIndex:index];               
			} else if ([plot.identifier isEqual:CPDTickerSymbolMSFT] == YES) {
				return [[[CPDStockPriceStore sharedInstance] monthlyPrices:CPDTickerSymbolMSFT] objectAtIndex:index];               
			}
			break;
	}
	return [NSDecimalNumber zero];
}

@end
