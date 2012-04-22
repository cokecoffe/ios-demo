#import <Foundation/Foundation.h>
#import "MYShortString.h"


int main (int argc, const char * argv[]) {
   NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
   
   const NSUInteger       numberOfInstances = 1000;
   const NSUInteger       numberOfIterations = 10000;
   
   { // Time creating NSString instances in batches
      NSUInteger       i;
      
      NSLog(@"Start NSString Test: %d allocations.", numberOfInstances * 
            numberOfIterations);
      double     startTime = [NSDate timeIntervalSinceReferenceDate];
      
      for(i = 0; i < numberOfIterations; i++) {
         NSAutoreleasePool *localPool = [[NSAutoreleasePool alloc] init];
         NSMutableArray    *tempArray = [[NSMutableArray alloc] init];
         NSUInteger        j;
         char              buffer[40];
         
         for(j = 0; j < numberOfInstances; j++) {
            sprintf(buffer, "d", random());
            NSString		*string = [[[NSString alloc] 
                                    initWithCString:buffer] autorelease];
            [tempArray addObject:string];
         }
         
         [tempArray release];
         tempArray = nil;
         [localPool drain];
      }
      double     endTime = [NSDate timeIntervalSinceReferenceDate];
      
      NSLog(@"End NSString Test: %d allocations.", numberOfInstances * 
            numberOfIterations);
      NSLog(@"Elapsed time: %f seconds.", endTime - startTime);
   }
   
   { // Time creating MYShortString instances in batches
      NSUInteger       i;
      
      NSLog(@"Start MYShortString Test: %d allocations.", numberOfInstances * 
            numberOfIterations);
      double     startTime = [NSDate timeIntervalSinceReferenceDate];
      
      for(i = 0; i < numberOfIterations; i++) {
         NSAutoreleasePool *localPool = [[NSAutoreleasePool alloc] init];
         NSMutableArray    *tempArray = [[NSMutableArray alloc] init];
         NSUInteger        j;
         char              buffer[40];
         
         for(j = 0; j < numberOfInstances; j++) {
            sprintf(buffer, "d", random());
            NSString		*string = [[[MYShortString alloc] 
                                    initWithCString:buffer] autorelease];
            [tempArray addObject:string];
         }
         
         [tempArray release];
         tempArray = nil;
         [localPool drain];
      }
      double     endTime = [NSDate timeIntervalSinceReferenceDate];
      
      NSLog(@"End MYShortString Test: %d allocations.", numberOfInstances * 
            numberOfIterations);
      NSLog(@"Elapsed time: %f seconds.", endTime - startTime);
   }
   
   NSLog(@"available: %d out of %d", [MYShortString numberOfAvailableInstances],
         [MYShortString totalNumberOfInstances]);
   
   NSLog(@"available: %d out of %d", [MYShortString numberOfAvailableInstances],
         [MYShortString totalNumberOfInstances]);
   
   [MYShortString cleanup];
   
   NSLog(@"available: %d out of %d", [MYShortString numberOfAvailableInstances],
         [MYShortString totalNumberOfInstances]);
   
   [pool drain];
   return 0;
}
