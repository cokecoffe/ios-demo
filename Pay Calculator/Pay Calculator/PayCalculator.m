//
//  PayCalculator.m
//  Pay Calculator
//
//  Created by 可可 王 on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PayCalculator.h"

@implementation PayCalculator

- (IBAction)calculatePayAmount:(id)sender
{   
    if(NSOnState == [employeeIsExemptButton state])   
    {  // Pay the hourly rate times the standard number of hours
        // regardless of hours worked      
        [payAmountField setFloatValue:[hourlyRateField floatValue] *
         [standardHoursInPeriodField floatValue]];   
    }
    else   
    {  // Pay the hourly rate times the number of hour worked
        float       payAmount = [hourlyRateField floatValue] *
        [hoursWorkedField floatValue];
        
        if([hoursWorkedField floatValue] >
           [standardHoursInPeriodField floatValue])      
        {  // pay 50% extra for overtime
            float       overtimePayAmount = 0.5f *
            [hourlyRateField floatValue] *
            ([hoursWorkedField floatValue] -
             [standardHoursInPeriodField floatValue]);
            
            payAmount = payAmount + overtimePayAmount;      
        }
        
        [payAmountField setFloatValue:payAmount];
    }
}

@end
