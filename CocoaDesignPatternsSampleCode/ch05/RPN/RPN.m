#import <Foundation/Foundation.h>
#import <stdio.h>
#import "MYStack.h"
#import "MYCommand.h"

static NSMutableDictionary *operators = nil;

#define MYMAXSTRING 8192
	
int main (int argc, const char *argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	MYStack *stack = [[MYStack alloc] init];
	BOOL parsing = YES;
	char cString[MYMAXSTRING];

	// create a substitution dictionary:  every time a key is found, it
	// will be treated as if the user typed the associated object instead
	operators = [[NSMutableDictionary alloc] init];
	[operators setObject:@"add" forKey:@"+"];
	[operators setObject:@"subtract" forKey:@"-"];
	[operators setObject:@"multiply" forKey:@"*"];
	[operators setObject:@"divide" forKey:@"/"];
	// our parsing loop, we parse one line at a time from stdin
	while (parsing) {
		NSString *subString;
		// read a line from stdin and break it into substrings separated by whitespace
		fgets(cString, MYMAXSTRING, stdin);
		NSString *inputLine = [NSString stringWithCString:cString encoding:NSASCIIStringEncoding];	
		NSArray *splitLine = [inputLine componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		// step through the substrings, dealing with them one at a time
		for (subString in splitLine) {
			NSString *operator;
			NSString *commandName;
			Class commandClass;
			// if substring is empty, skip it
			if (NSOrderedSame == [subString compare:@""]) {
				continue;
			}
			// if substring matches an operator, change it into the associated command name
			for (operator in operators) {
				if (NSOrderedSame == [operator compare:subString]) {
					subString = [operators objectForKey:operator];
					break;
					//NSLog(@"found operator \"%@\", replacing with \"%@\".", operator, subString);
				}
			}
			// look for a command to match the string
			commandName = [NSString stringWithFormat:@"MY%@Command", [subString capitalizedString]];
			commandClass = NSClassFromString(commandName);
			//NSLog(@"Looking for class \"%@\" result = 0x%08x.", commandName, (unsigned int)commandClass);
			if (commandClass) { // if there's a command name that matches, then perform the command
				MYCommandReturn result = [commandClass executeWithStack:stack];
				//NSLog(@"Command:  \"%@\"", subString);
				switch (result) { // handle the return codes appropriately
					case MYHaltExecution:
						parsing = NO;
						break;
					case MYError:
						NSLog(@"Error executing command \"%@\".", subString);
						break;
					case MYSuccess:
					default:
						break;
				}
			} else { // if there was no command to execute, then push the string onto the stack
				[stack push:subString];
				//NSLog(@"Pushing:  \"%@\"", subString);
			}
		}
	}
	
	[stack release];
	[operators release];
   [pool drain];
   return 0;
}
