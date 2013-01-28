//
//  CPDSecondViewController.m
//  CorePlotDemo
//
//  Created by Fahim Farook on 19/5/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import "CPDBarGraphViewController.h"

@interface CPDBarGraphViewController ()

@property (nonatomic, strong) IBOutlet CPTGraphHostingView *hostView;
@property (nonatomic, strong) CPTBarPlot *aaplPlot;
@property (nonatomic, strong) CPTBarPlot *googPlot;
@property (nonatomic, strong) CPTBarPlot *msftPlot;
@property (nonatomic, strong) CPTPlotSpaceAnnotation *priceAnnotation;

-(IBAction)aaplSwitched:(id)sender;
-(IBAction)googSwitched:(id)sender;
-(IBAction)msftSwitched:(id)sender;

-(void)initPlot;
-(void)configureGraph;
-(void)configurePlots;
-(void)configureAxes;
-(void)hideAnnotation:(CPTGraph *)graph;

@end

@implementation CPDBarGraphViewController

CGFloat const CPDBarWidth = 0.25f;
CGFloat const CPDBarInitialX = 0.25f;

@synthesize hostView    = hostView_;
@synthesize aaplPlot    = aaplPlot_;
@synthesize googPlot    = googPlot_;
@synthesize msftPlot    = msftPlot_;
@synthesize priceAnnotation = priceAnnotation_;

#pragma mark - Rotation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

#pragma mark - UIViewController lifecycle methods
-(void)viewDidLoad {
    [super viewDidLoad];
    [self initPlot];
}

#pragma mark - IBActions
-(IBAction)aaplSwitched:(id)sender {
    BOOL on = [((UISwitch *) sender) isOn];
    if (!on) {
        [self hideAnnotation:self.aaplPlot.graph]; 
    }    
    [self.aaplPlot setHidden:!on];    
}

-(IBAction)googSwitched:(id)sender {
    BOOL on = [((UISwitch *) sender) isOn];    
    if (!on) {
        [self hideAnnotation:self.googPlot.graph];
    }    
    [self.googPlot setHidden:!on];     
}

-(IBAction)msftSwitched:(id)sender {
    BOOL on = [((UISwitch *) sender) isOn];    
    if (!on) {
        [self hideAnnotation:self.msftPlot.graph];
    }
    [self.msftPlot setHidden:!on];
}

#pragma mark - Chart behavior
-(void)initPlot {
    self.hostView.allowPinchScaling = NO;
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];    
}

-(void)configureGraph {
	// 1 - Create the graph
	CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
	graph.plotAreaFrame.masksToBorder = NO;
	self.hostView.hostedGraph = graph;    
	// 2 - Configure the graph    
	[graph applyTheme:[CPTTheme themeNamed:kCPTPlainBlackTheme]];    
	graph.paddingBottom = 30.0f;      
	graph.paddingLeft  = 30.0f;
	graph.paddingTop    = -1.0f;
	graph.paddingRight  = -5.0f;
	// 3 - Set up styles
	CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
	titleStyle.color = [CPTColor whiteColor];
	titleStyle.fontName = @"Helvetica-Bold";
	titleStyle.fontSize = 16.0f;
	// 4 - Set up title
	NSString *title = @"Portfolio Prices: April 23 - 27, 2012";
	graph.title = title;  
	graph.titleTextStyle = titleStyle;
	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
	graph.titleDisplacement = CGPointMake(0.0f, -16.0f);
	// 5 - Set up plot space
	CGFloat xMin = 0.0f;
	CGFloat xMax = [[[CPDStockPriceStore sharedInstance] datesInWeek] count];
	CGFloat yMin = 0.0f;
	CGFloat yMax = 800.0f;  // should determine dynamically based on max price
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax)];
	plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax)];
}

-(void)configurePlots {
	// 1 - Set up the three plots
	self.aaplPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor redColor] horizontalBars:NO];
	self.aaplPlot.identifier = CPDTickerSymbolAAPL;
	self.googPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor greenColor] horizontalBars:NO];
	self.googPlot.identifier = CPDTickerSymbolGOOG;
	self.msftPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
	self.msftPlot.identifier = CPDTickerSymbolMSFT;
	// 2 - Set up line style
	CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
	barLineStyle.lineColor = [CPTColor lightGrayColor];
	barLineStyle.lineWidth = 0.5;
	// 3 - Add plots to graph
	CPTGraph *graph = self.hostView.hostedGraph;
	CGFloat barX = CPDBarInitialX;
	NSArray *plots = [NSArray arrayWithObjects:self.aaplPlot, self.googPlot, self.msftPlot, nil];
	for (CPTBarPlot *plot in plots) {
		plot.dataSource = self;
		plot.delegate = self;
		plot.barWidth = CPTDecimalFromDouble(CPDBarWidth);
		plot.barOffset = CPTDecimalFromDouble(barX);
		plot.lineStyle = barLineStyle;
		[graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
		barX += CPDBarWidth;
	} 
}

-(void)configureAxes {
	// 1 - Configure styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor whiteColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 12.0f;
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 2.0f;
	axisLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:1];
	// 2 - Get the graph's axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
	// 3 - Configure the x-axis
	axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
	axisSet.xAxis.title = @"Days of Week (Mon - Fri)"; 
	axisSet.xAxis.titleTextStyle = axisTitleStyle;    
	axisSet.xAxis.titleOffset = 10.0f;
	axisSet.xAxis.axisLineStyle = axisLineStyle;    
	// 4 - Configure the y-axis
	axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
	axisSet.yAxis.title = @"Price";
	axisSet.yAxis.titleTextStyle = axisTitleStyle;
	axisSet.yAxis.titleOffset = 5.0f;      
	axisSet.yAxis.axisLineStyle = axisLineStyle;        
}

-(void)hideAnnotation:(CPTGraph *)graph {
	if ((graph.plotAreaFrame.plotArea) && (self.priceAnnotation)) {
		[graph.plotAreaFrame.plotArea removeAnnotation:self.priceAnnotation];
		self.priceAnnotation = nil;
	}
}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
	return [[[CPDStockPriceStore sharedInstance] datesInWeek] count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
	if ((fieldEnum == CPTBarPlotFieldBarTip) && (index < [[[CPDStockPriceStore sharedInstance] datesInWeek] count])) {
		if ([plot.identifier isEqual:CPDTickerSymbolAAPL]) {
			return [[[CPDStockPriceStore sharedInstance] weeklyPrices:CPDTickerSymbolAAPL] objectAtIndex:index];
		} else if ([plot.identifier isEqual:CPDTickerSymbolGOOG]) {
			return [[[CPDStockPriceStore sharedInstance] weeklyPrices:CPDTickerSymbolGOOG] objectAtIndex:index];            
		} else if ([plot.identifier isEqual:CPDTickerSymbolMSFT]) {
			return [[[CPDStockPriceStore sharedInstance] weeklyPrices:CPDTickerSymbolMSFT] objectAtIndex:index];            
		}
	}
	return [NSDecimalNumber numberWithUnsignedInteger:index]; 
}

#pragma mark - CPTBarPlotDelegate methods
-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)index {
	// 1 - Is the plot hidden?
	if (plot.isHidden == YES) {
		return;
	}
	// 2 - Create style, if necessary
	static CPTMutableTextStyle *style = nil;
	if (!style) {
		style = [CPTMutableTextStyle textStyle];    
		style.color= [CPTColor yellowColor];
		style.fontSize = 16.0f;
		style.fontName = @"Helvetica-Bold";        
	}
	// 3 - Create annotation, if necessary
	NSNumber *price = [self numberForPlot:plot field:CPTBarPlotFieldBarTip recordIndex:index];
	if (!self.priceAnnotation) {
		NSNumber *x = [NSNumber numberWithInt:0];
		NSNumber *y = [NSNumber numberWithInt:0];
		NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
		self.priceAnnotation = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:plot.plotSpace anchorPlotPoint:anchorPoint];        
	}
	// 4 - Create number formatter, if needed
	static NSNumberFormatter *formatter = nil;
	if (!formatter) {
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setMaximumFractionDigits:2];        
	}
	// 5 - Create text layer for annotation
	NSString *priceValue = [formatter stringFromNumber:price];
	CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:priceValue style:style];
	self.priceAnnotation.contentLayer = textLayer;
	// 6 - Get plot index based on identifier
	NSInteger plotIndex = 0;
	if ([plot.identifier isEqual:CPDTickerSymbolAAPL] == YES) {
		plotIndex = 0;
	} else if ([plot.identifier isEqual:CPDTickerSymbolGOOG] == YES) {
		plotIndex = 1;
	} else if ([plot.identifier isEqual:CPDTickerSymbolMSFT] == YES) {
		plotIndex = 2;
	}    
	// 7 - Get the anchor point for annotation
	CGFloat x = index + CPDBarInitialX + (plotIndex * CPDBarWidth); 
	NSNumber *anchorX = [NSNumber numberWithFloat:x];    
	CGFloat y = [price floatValue] + 40.0f;
	NSNumber *anchorY = [NSNumber numberWithFloat:y];    
	self.priceAnnotation.anchorPlotPoint = [NSArray arrayWithObjects:anchorX, anchorY, nil]; 
	// 8 - Add the annotation 
	[plot.graph.plotAreaFrame.plotArea addAnnotation:self.priceAnnotation]; 
}

@end
