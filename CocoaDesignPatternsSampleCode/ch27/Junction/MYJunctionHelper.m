#import "MYJunctionHelper.h"
#import "MYJunction.h"


@implementation MYJunctionHelper

- (void)awakeFromNib
{
	MYJunction *junction = [MYJunction sharedJunction];
	[myObject setTarget:junction];
	[junction addTarget:myObject];
}

@end
