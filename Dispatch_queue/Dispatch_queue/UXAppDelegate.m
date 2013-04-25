//
//  UXAppDelegate.m
//  Dispatch_queue
//
//  Created by wang keke on 13-3-11.
//  Copyright (c) 2013年 uxin. All rights reserved.
//

#import "UXAppDelegate.h"

@implementation UXAppDelegate

#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //    [self doUI_Related_task];
    //    [self doNon_UI_Related_Syntask];
    //    [self doNon_UI_Related_Syntask_withCFunction];
    //    [self doNon_UI_Related_Asyntask];
    //    [self doAnotherTask];
    //    [self InvokeDelay];
    //    [self OnceTime_Task];
    //    [self doGroupTasks];
    [self doCustomQueue];
        
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - 5.5 UI-related-task

typedef struct{
    char *title;
    char *message;
    char *cancelButtonTitle;
} AlertViewData;

void displayAlertView(void *paramContext){
    AlertViewData *alertData = (AlertViewData *)paramContext;
    NSString *title =
    [NSString stringWithUTF8String:alertData->title];
    NSString *message =
    [NSString stringWithUTF8String:alertData->message];
    NSString *cancelButtonTitle =
    [NSString stringWithUTF8String:alertData->cancelButtonTitle];
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:cancelButtonTitle
                      otherButtonTitles:nil,nil] show];
    free(alertData);
}


-(void)doUI_Related_task
{
    /*利用gcd执行ui相关的任务*/
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    AlertViewData *context = (AlertViewData *) malloc(sizeof(AlertViewData));
    if (context != NULL){
        context->title = "GCD"; context->message = "GCD is amazing."; context->cancelButtonTitle = "OK";
        dispatch_async_f(mainQueue,
                         (void *)context,
                         displayAlertView);
    }
}

#pragma mark - 5.6 doNon_UI_Related_Syntask

/*利用gcd执行同步的与ui无关的任务 */
-(void)doNon_UI_Related_Syntask
{
    void (^printFrom1To1000)(void) = ^{
        NSUInteger counter = 0;
        for (counter = 1;counter <= 1000; counter++)
        {
            NSLog(@"Counter = %lu - Thread = %@", (unsigned long)counter,[NSThread currentThread]);
        }
    };
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);//获取主并发队列
    dispatch_sync(concurrentQueue, printFrom1To1000);
    dispatch_sync(concurrentQueue, printFrom1To1000);
    
    /*使用dispatch_sync提交两个同步任务到同一个并发队列concurrentQueue中,那么这两个任务将顺序执行
     IOS可能会进行优化，将提交的block运行在提交所属的的线程中。
     */
}

void printFrom1To1000(void *paramContext){
    NSUInteger counter = 0;
    for (counter = 1;counter <= 1000; counter++){
        NSLog(@"Counter = %lu - Thread = %@", (unsigned long)counter,
              [NSThread currentThread]);
    }
}
/*用c的方式 执行 */
-(void)doNon_UI_Related_Syntask_withCFunction
{    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync_f(concurrentQueue, NULL,printFrom1To1000);
    dispatch_sync_f(concurrentQueue, NULL,printFrom1To1000);
}

#pragma mark - 5.7 Non-UI-Related-Asyntask

/*执行异步的UI无关的任务*/
-(void)doNon_UI_Related_Asyntask
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        __block UIImage *image = nil;
        
        /* Download the image here */
        dispatch_sync(concurrentQueue, ^{            
            /* iPad's image from Apple's website. Wrap it into two lines as the URL is too long to fit into one line */
            NSString *urlAsString = @"http://images.apple.com/mobileme/features"\
            "/images/ipad_findyouripad_20100518.jpg";
            NSURL *url = [NSURL URLWithString:urlAsString];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            NSError *downloadError = nil;
            NSData *imageData = [NSURLConnection
                                 sendSynchronousRequest:urlRequest returningResponse:nil error:&downloadError];
            if (downloadError == nil && imageData != nil){
                image = [UIImage imageWithData:imageData]; /* We have the image. We can use it now */
            }
            else if (downloadError != nil) NSLog(@"Error happened = %@", downloadError);
            else NSLog(@"No data could get downloaded from the URL.");                
        });

        /* Show the image to the user here on the main queue*/
        dispatch_sync(dispatch_get_main_queue(), ^{        
            if (image != nil){
                /* Create the image view here */
                UIImageView *imageView = [[UIImageView alloc]
                                          initWithFrame:self.window.bounds];
                /* Set the image */
                [imageView setImage:image];
                /* Make sure the image is not scaled incorrectly */
                [imageView setContentMode:UIViewContentModeScaleAspectFit];
                /* Add the image to this view controller's view */
                [self.window addSubview:imageView];
            } else {
                NSLog(@"Image isn't downloaded. Nothing to display."); }
        }); });
}

//另个一例子 执行异步的UI无关的任务

- (NSString *) fileLocation{
    /* Get the document folder(s) */
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    /* Did we find anything? */
    if ([folders count] == 0){
        return nil; }
    
    /* Get the first folder */
    NSString *documentsFolder = [folders objectAtIndex:0];
    /* Append the file name to the end of the documents path */
    return [documentsFolder stringByAppendingPathComponent:@"list.txt"];
}

- (BOOL) hasFileAlreadyBeenCreated{
    BOOL result = NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:[self fileLocation]])
    {
        result = YES;
    }
    return result;
}

-(void) doAnotherTask
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   
    /* If we have not already saved an array of 10,000 random numbers to the disk before,
     generate these numbers now and then save them to the disk in an array */
    dispatch_async(concurrentQueue, ^{
        NSUInteger numberOfValuesRequired = 10000;
        if ([self hasFileAlreadyBeenCreated] == NO)
        {
            dispatch_sync(concurrentQueue, ^{
                
                NSMutableArray *arrayOfRandomNumbers = [[NSMutableArray alloc] initWithCapacity:numberOfValuesRequired];
                NSUInteger counter = 0;
                for (counter = 0;counter < numberOfValuesRequired;counter++)
                {
                    unsigned int randomNumber = arc4random() % ((unsigned int)RAND_MAX + 1);
                    [arrayOfRandomNumbers addObject:[NSNumber numberWithUnsignedInt:randomNumber]];
                }
                /* Now let's write the array to disk */
                [arrayOfRandomNumbers writeToFile:[self fileLocation]atomically:YES];
            });
        }
        
        
        __block NSMutableArray *randomNumbers = nil;
        /* Read the numbers from disk and sort them in an ascending fashion */
        dispatch_sync(concurrentQueue, ^{
            /* If the file has now been created, we have to read it */
            if ([self hasFileAlreadyBeenCreated]){
                randomNumbers = [[NSMutableArray alloc] initWithContentsOfFile:[self fileLocation]];
                /* Now sort the numbers */
                [randomNumbers sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    NSNumber *number1 = (NSNumber *)obj1;
                    NSNumber *number2 = (NSNumber *)obj2;
                    return [number1 compare:number2];
                }];
            }
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([randomNumbers count] > 0)
            {
                /* Refresh the UI here using the numbers in the randomNumbers array */
                for (NSNumber *no in randomNumbers) {
                    NSLog(@"%@",no);
                }
            }
        });
        
    });
}

#pragma mark - 5.8 InvokeDelay

-(void)InvokeDelay
{
    double delayInSeconds = 2.0;
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        /* Perform your operations here */
        NSLog(@"this put out after 2.0 seconds.");
    });
}

#pragma mark - 5.9 Performing a Task at Most Once

static dispatch_once_t onceToken;

-(void)OnceTime_Task
{
    void (^executedOnlyOnce)(void) = ^{
        static NSUInteger numberOfEntries = 0;
        numberOfEntries++;
        NSLog(@"Executed %lu time(s)", (unsigned long)numberOfEntries);
    };
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_once(&onceToken, ^{
        dispatch_async(concurrentQueue,executedOnlyOnce);
    });
    
    dispatch_once(&onceToken, ^{
        dispatch_async(concurrentQueue,executedOnlyOnce);        
    });
    
    /*我们可以利用此技术来创建单例
    - (id) sharedInstance{
        static MySingleton *SharedInstance = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SharedInstance = [MySingleton new];
        });
        return SharedInstance;
    }
    */
}

#pragma mark - Group Tasks

-(void)doGroupTasks
{
    dispatch_group_t taskGroup = dispatch_group_create();
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    /* Reload the table view on the main queue */
    dispatch_group_async(taskGroup, mainQueue, ^{
        //        [self reloadTableView];
        NSLog(@"1st task");
    });
    
    /* Reload the scroll view on the main queue */
    dispatch_group_async(taskGroup, mainQueue, ^{
        //        [self reloadScrollView];
        NSLog(@"2nd task");
    });
    
    /* Reload the image view on the main queue */
    dispatch_group_async(taskGroup, mainQueue, ^{
        //        [self reloadImageView];
        NSLog(@"3rd task");        
    });
    
    /* At the end when we are done, dispatch the following block */
    dispatch_group_notify(taskGroup, mainQueue, ^{
        /* Do some processing here */
        [[[UIAlertView alloc] initWithTitle:@"Finished"
                                    message:@"All tasks are finished"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    });
    /* We are done with the group */
    //dispatch_release(taskGroup);
}

#pragma mark - Custom Seria Queue
-(void)doCustomQueue
{
    /*将异步的任务提交到串行队列，任务将在子线程运行，并且按照提交顺序执行*/
    dispatch_queue_t firstSerialQueue = dispatch_queue_create("com.pixolity.GCD.serialQueue1", 0);
    
    dispatch_async(firstSerialQueue, ^{
        NSUInteger counter = 0;
        for (counter = 0; counter < 5; counter++){
            NSLog(@"First iteration, counter = %lu", (unsigned long)counter);
        }
    });
    
    dispatch_async(firstSerialQueue, ^{
        NSUInteger counter = 0;
        for (counter = 0; counter < 5;counter++){
            NSLog(@"Second iteration, counter = %lu", (unsigned long)counter);
        } });
    
    dispatch_async(firstSerialQueue, ^{
        NSUInteger counter = 0;
        for (counter = 0;counter < 5;counter++){
            NSLog(@"Third iteration, counter = %lu", (unsigned long)counter);
        } });
}
@end
