//
//  ViewController.m
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

#import "ViewController.h"
#import "RecordDao.h"
#import "Record.h"

@implementation ViewController

@synthesize myTableView, recordDao;

- (id)init {
	if (self = [super init]) {
		recordDao = [[RecordDao alloc] init];
		
//		 [recordDao insertWithTitle:@"first" Body:@"helloWorld"];
//		 [recordDao insertWithTitle:@"second" Body:@"yeah"];
        
		// [recordDao updateAtIndex:1 Title:@"UPDATE TEST" Body:@"UPDATE BODY"];
		// [recordDao deleteAtIndex:1];
        // [recordDao deleteAtIndex:2];
		
//		for (int i=1; i<=[recordArray count]; i++) {
//			Record *note = [recordArray objectAtIndex:i-1];
//			[recordDao updateAtIndex:i Title:@"title" Body:note.body];
//		}	
	}
		
	return self;
}



-(void)addItem
{
    [recordDao insertWithTitle:@"Hello" Body:@"World"];
   
    [(UITableView*)self.view reloadData];
}

-(void)delItem
{
    Record *tr = (Record *)[[recordDao resultSet] lastObject];
    [recordDao deleteAtIndex:[tr getIndex]];

    [(UITableView*)self.view reloadData];
}


- (void)viewDidLoad {
	[super viewDidLoad];
	myTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	myTableView.delegate = self;
	myTableView.dataSource = self;
	self.view = myTableView;
    
    UIButton *addBT = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addBT addTarget:self action:@selector(addItem) forControlEvents:UIControlEventTouchUpInside];
    [addBT setFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
    [self.view addSubview:addBT];
    
    UIButton *delBT = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [delBT addTarget:self action:@selector(delItem) forControlEvents:UIControlEventTouchUpInside];
    [delBT setFrame:CGRectMake(290.0, 0.0, 30.0, 30.0)];
    [self.view addSubview:delBT];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[recordDao resultSet] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
	}
	
	Record *tr = (Record *)[[recordDao resultSet] objectAtIndex:indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"id:%i  title:%@  body:%@", [tr getIndex], tr.title, tr.body];
	return cell;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)dealloc {
	[myTableView release];
	[recordDao release];
	[super dealloc];
}

@end