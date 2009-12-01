//
//  IC.m
//  Robo
//


#import "IC.h"


@implementation IC

-(id)init {
	self = [super init];
	if(self) {
		image = [NSImage imageNamed:@"ic"];
		isIC = TRUE;
	}
	return self;
}

@end
