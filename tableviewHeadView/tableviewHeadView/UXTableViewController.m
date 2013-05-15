//
//  UXTableViewController.m
//  tableviewHeadView
//
//  Created by keke Wang on 13-5-9.
//  Copyright (c) 2013年 uxin. All rights reserved.
//

#import "UXTableViewController.h"

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

@interface UXTableViewController ()
{
    CGPoint pointNow;
    BOOL isHeadHidden;
    CGFloat historyY;
}

@property (nonatomic, assign) NSInteger lastContentOffset;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UXTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    isHeadHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)aa:(id)sender {
    
    CGRect h_frame = self.headView.frame;
    CGRect table_frame = self.tableView.frame;
    
    h_frame.origin.y = - h_frame.size.height;
    table_frame.origin.y = h_frame.origin.y + h_frame.size.height;
    table_frame.size.height += h_frame.size.height;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.headView.frame = h_frame;
                         self.tableView.frame = table_frame;
                     }
                     completion:^(BOOL finished) {
                         isHeadHidden = YES;
                     }];
}

- (IBAction)dd:(id)sender {
    
    CGRect h_frame = self.headView.frame;
    CGRect table_frame = self.tableView.frame;
    h_frame.origin.y = 0;
    table_frame.origin.y = h_frame.origin.y+h_frame.size.height;
    table_frame.size.height -= h_frame.size.height;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.headView.frame = h_frame;
                         self.tableView.frame = table_frame;
                     }
                     completion:^(BOOL finished) {
                         isHeadHidden = NO;
                     }];

}

#if 1
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (historyY+self.headView.frame.size.height < targetContentOffset->y) {
        //
        [self aa:nil];
    }else if(historyY-self.headView.frame.size.height > targetContentOffset->y){
        [self dd:nil];
    }
    historyY = targetContentOffset->y;
}
#endif

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pointNow = scrollView.contentOffset;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"11";
    
    return cell;
}

@end
