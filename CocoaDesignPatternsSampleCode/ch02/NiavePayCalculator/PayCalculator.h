#import <Cocoa/Cocoa.h>

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
