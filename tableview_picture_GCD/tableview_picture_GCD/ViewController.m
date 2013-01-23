//
//  ViewController.m
//  tableview_picture_GCD
//
//  Created by keke Wang on 12-11-8.
//  Copyright (c) 2012年 wangkeke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    
}
@property (retain,nonatomic) NSMutableArray *content;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.content = [NSMutableArray arrayWithCapacity:100];
    for (int i = 0; i<100; i++) {
        [self.content addObject:@"https://devimages.apple.com.edgekey.net/technologies/mountain-lion/images/mountain_lion_hero.jpg"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.content count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"CustomCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]autorelease];
    }
    cell.textLabel.text = [self.content objectAtIndex:indexPath.row];
    
    
    //image
    dispatch_queue_t network_queue;
    
    network_queue = dispatch_queue_create("com.myapp.network", nil);
    
    dispatch_async(network_queue, ^{
        UIImage *cellImage = [self loadMyImageFromNetwork:[self.content objectAtIndex:indexPath.row]];
        
        //缓存到本地
        
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 显示图片到界面
            cell.imageView.image = cellImage;
            [cell setNeedsLayout];
        });
        
    } );
    
    return cell;
}

#pragma mark - Images Methods
                   
-(UIImage*)loadMyImageFromNetwork:(NSString*)url
{
    NSData *dat = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *img = [UIImage imageWithData:dat];
    return img;
}



@end
