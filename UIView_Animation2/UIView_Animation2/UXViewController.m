//
//  UXViewController.m
//  UIView_Animation2
//
//  Created by wang keke on 13-3-15.
//  Copyright (c) 2013年 uxin. All rights reserved.
//
//
//
//
//  1.点击按钮，箭头会移动到按钮上方
//  2.点击箭头，自旋转180度
//  3.点击zoom按钮，弹出一个列表视图
//

#import "UXViewController.h"
#import "UIView+Animation.h"
#import "AnimationCurvePicker.h"
#import "FakeHUD.h"

@interface UXViewController ()
{
    NSMutableArray *curvesList;
    int	selectedCurveIndex;
    UIView *pickerView;
}
@property (weak, nonatomic) IBOutlet UIButton *movingButton;

@end

static int curveValues[] = {
    UIViewAnimationOptionCurveEaseInOut,
    UIViewAnimationOptionCurveEaseIn,
    UIViewAnimationOptionCurveEaseOut,
    UIViewAnimationOptionCurveLinear
};


@implementation UXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    curvesList = [[NSMutableArray alloc] initWithObjects:@"EaseInOut",@"EaseIn",@"EaseOut",@"Linear", nil];
    selectedCurveIndex = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btMoveTo:(id)sender {
    UIButton* button= (UIButton*)sender;
    [_movingButton moveTo:
     CGPointMake(button.center.x - (_movingButton.frame.size.width/2),
                 button.frame.origin.y - (_movingButton.frame.size.height + 5.0))
                duration:1.0 option:0];	// above the tapped button
}

- (IBAction)btnDownUnder:(id)sender {
    UIButton* button= (UIButton*)sender;
	[button downUnder:1.0 option:0];
}

- (IBAction) btnZoom:(id)sender
{
    UIButton* button= (UIButton*)sender;
	pickerView = [AnimationCurvePicker newAnimationCurvePicker:self];
	// the animation will start in the middle of the button
	pickerView.center = button.center;
	[self.view addSubviewWithZoomInAnimation:pickerView duration:0.8 option:curveValues[selectedCurveIndex]];
}

- (IBAction)btnHud:(id)sender {
    FakeHUD *theSubView = [FakeHUD newFakeHUD];
	[self.view addSubviewWithFadeAnimation:theSubView duration:1.0 option:curveValues[selectedCurveIndex]];
}


#pragma mark - animation curves picker

// handling the picker, that is a simple tableview in this example
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [curvesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	cell.textLabel.text = [curvesList objectAtIndex:indexPath.row];
    
	if (indexPath.row == selectedCurveIndex)
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;
    
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Select the Animation Curve to be used";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	return @"Curves will not affect total duration but instant speed and acceleration";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	if (selectedCurveIndex != indexPath.row)
	{
		NSIndexPath *oldPath = [NSIndexPath indexPathForRow:selectedCurveIndex inSection:indexPath.section];
		cell = [tableView cellForRowAtIndexPath:oldPath];
		cell.accessoryType = UITableViewCellAccessoryNone;
        
		selectedCurveIndex = indexPath.row;
	}
    
	if (pickerView)
	{
		[pickerView removeWithZoomOutAnimation:1.0 option:curveValues[selectedCurveIndex]];
		pickerView = nil;
	}
}

@end
