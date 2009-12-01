#import "NSColorAdditions.h"

@implementation NSColor (CustomAlternatingRowBackgroundColors)
+ (NSArray *)controlAlternatingRowBackgroundColors 
{
	NSColor * anEvenRowColor = [NSColor colorWithDeviceWhite:.95 alpha:1.0];
	NSColor * anOddRowColor = [NSColor colorWithDeviceWhite:.85 alpha:1.0];
	return [NSArray arrayWithObjects:anEvenRowColor, anOddRowColor, nil];
}

@end
