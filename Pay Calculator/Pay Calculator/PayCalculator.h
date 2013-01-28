//
//  PayCalculator.h
//  Pay Calculator
//
//  Created by 可可 王 on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayCalculator : NSObject
{
    IBOutlet NSTextField          *employeeNameField;
    IBOutlet NSFormCell           *hourlyRateField;
    IBOutlet NSFormCell           *hoursWorkedField;
    IBOutlet NSFormCell           *standardHoursInPeriodField;
    IBOutlet NSTextField          *payAmountField;
    IBOutlet NSButton             *employeeIsExemptButton;
}
- (IBAction)calculatePayAmount:(id)sender;

@end
