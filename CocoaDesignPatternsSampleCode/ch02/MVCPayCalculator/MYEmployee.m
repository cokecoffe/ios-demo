#import "MYEmployee.h"

@implementation MYEmployee 

+ (NSSet *)keyPathsForValuesAffectingPayAmount
{  // return names of attributes that affect payAmount
   return [NSSet setWithObjects:@"isExempt", 
           @"hourlyRate", @"hoursWorked", @"standardHours", nil];
}


- (NSNumber *)payAmount 
{   // return a calculated pay amount based on other attributes
   float     calculatedPayAmount;
   float     hourlyRate = 
      [[self valueForKey:@"hourlyRate"] floatValue];
   float     standardNumberOfHours = 
      [[self valueForKey:@"standardHours"] floatValue];
   
   [self willAccessValueForKey: @"payAmount"];
   if([[self valueForKey:@"isExempt"] boolValue])   
   {  // Pay the hourly rate times the standard number of hours
      // regardless of the actual number of hours worked      
      calculatedPayAmount = hourlyRate * standardNumberOfHours;   
   }
   else   
   {  // Pay the hourly rate times the actual number of hours worked
      float     numberOfHoursWorked = 
         [[self valueForKey:@"hoursWorked"] floatValue];
      
      calculatedPayAmount = hourlyRate * numberOfHoursWorked;
      
      if(numberOfHoursWorked > standardNumberOfHours)      
      {  // pay 50% extra for overtime
         float       overtimePayAmount = 0.5f * hourlyRate *
            (numberOfHoursWorked - standardNumberOfHours);
         
         calculatedPayAmount = calculatedPayAmount + 
         overtimePayAmount;      
      }
   }
   [self didAccessValueForKey: @"payAmount"];
   
   return [NSNumber numberWithFloat:calculatedPayAmount];
}

@end
