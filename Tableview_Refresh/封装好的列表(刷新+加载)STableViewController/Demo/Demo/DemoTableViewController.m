//
// DemoTableViewController.m
//
// @author Shiki
//


#import "DemoTableViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface DemoTableViewController ()
// Private helper methods
- (void) addItemsOnTop;
- (void) addItemsOnBottom;
- (NSString *) createRandomValue;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation DemoTableViewController

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewDidLoad
{
  [super viewDidLoad];
  
  self.title = @"STableViewController Demo";
  [self.tableView setBackgroundColor:[UIColor lightGrayColor]];
  
  // set the custom view for "pull to refresh". See DemoTableHeaderView.xib.
  NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
  DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
  self.headerView = headerView;
  
  // set the custom view for "load more". See DemoTableFooterView.xib.
  nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
  DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
  self.footerView = footerView;
  
  // add sample items
  items = [[NSMutableArray alloc] init];
  for (int i = 0; i < 10; i++)
    [items addObject:[self createRandomValue]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Pull to Refresh

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pinHeaderView
{
  [super pinHeaderView];
  
  // do custom handling for the header view
  DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
  [hv.activityIndicator startAnimating];
  hv.title.text = @"Loading...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) unpinHeaderView
{
  [super unpinHeaderView];
  
  // do custom handling for the header view
  [[(DemoTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Update the header text while the user is dragging
//
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
  DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
  if (willRefreshOnRelease)
    hv.title.text = @"Release to refresh...";
  else
    hv.title.text = @"Pull down to refresh...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// refresh the list. Do your async calls here.
//
- (BOOL) refresh
{
  if (![super refresh])
    return NO;
  
  // Do your async call here
  // This is just a dummy data loader:
  [self performSelector:@selector(addItemsOnTop) withObject:nil afterDelay:2.0];
  // See -addItemsOnTop for more info on how to finish loading
  return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Load More

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// The method -loadMore was called and will begin fetching data for the next page (more). 
// Do custom handling of -footerView if you need to.
//
- (void) willBeginLoadingMore
{
  DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
  [fv.activityIndicator startAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Do UI handling after the "load more" process was completed. In this example, -footerView will
// show a "No more items to load" text.
//
- (void) loadMoreCompleted
{
  [super loadMoreCompleted];

  DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
  [fv.activityIndicator stopAnimating];
  
  if (!self.canLoadMore) {
    // Do something if there are no more items to load
    
    // We can hide the footerView by: [self setFooterViewVisibility:NO];
    
    // Just show a textual info that there are no more items to load
    fv.infoLabel.hidden = NO;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) loadMore
{
  if (![super loadMore])
    return NO;
  
  // Do your async loading here
  [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:2.0];
  // See -addItemsOnBottom for more info on what to do after loading more items
  
  return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Dummy data methods 

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnTop
{
  for (int i = 0; i < 3; i++)
    [items insertObject:[self createRandomValue] atIndex:0];
  [self.tableView reloadData];
  
  // Call this to indicate that we have finished "refreshing".
  // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
  [self refreshCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnBottom
{
  for (int i = 0; i < 5; i++)
    [items addObject:[self createRandomValue]];  
  
  [self.tableView reloadData];
  
  if (items.count > 50)
    self.canLoadMore = NO; // signal that there won't be any more items to load
  else
    self.canLoadMore = YES;
  
  // Inform STableViewController that we have finished loading more items
  [self loadMoreCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) createRandomValue
{
  NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
  
  return [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]],
          [NSNumber numberWithInt:rand()]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Standard TableView delegates

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return items.count;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                   reuseIdentifier:CellIdentifier] autorelease];
  }
  
  cell.textLabel.text = [items objectAtIndex:indexPath.row];  
  return cell;
}

@end
