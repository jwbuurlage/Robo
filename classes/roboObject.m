//
//  roboViewObject.m
//  Robo
//


#import "roboObject.h"


@implementation roboObject

@synthesize posInView, image, size, label, description, isDisplay, isPulse, hasButton, knop, colorState, isIC;

-(id)init {
	self = [super init];
	if(self) {
		ports = [[NSMutableArray alloc] init];
		image = [NSImage imageNamed:@"poort"];
		colorState = [NSColor redColor];
	}
	return self;
}
- (NSArray*)ports {
	NSArray* portReturn = [NSArray arrayWithArray:ports];
	return portReturn;
}

-(void)loadDisplayParts {
	
}

- (NSArray*)displayParts {
	NSArray* array = [[NSArray alloc] init];
	return array;
}

#pragma mark enable saving and loading
-(void)encodeWithCoder:(NSCoder *)coder {		//save to file
	[coder encodeSize:size forKey:@"O_size"];
	[coder encodeInt:state forKey:@"O_state"];
	[coder encodePoint:posInView forKey:@"O_posInView"];
	[coder encodeObject:colorState forKey:@"O_colorState"];
	[coder encodeObject:ports forKey:@"O_ports"];	
	[coder encodeObject:label forKey:@"O_label"];
	[coder encodeObject:description forKey:@"O_description"];
	[coder encodeObject:image forKey:@"O_image"];
	[coder encodeBool:isDisplay forKey:@"O_display"];
	[coder encodeBool:hasButton forKey:@"o_hasButton"];
	[coder encodeBool:isIC forKey:@"O_isIC"];
	[coder encodeBool:isPulse forKey:@"O_pulse"];
	[coder encodeSize:knop.size forKey:@"O_knop_size"];
	[coder encodePoint:knop.origin forKey:@"O_knop_origin"];
}
-(id)initWithCoder:(NSCoder *)coder {			//unarchive from file
	self = [super init];
	if(self) {
		ports = [[coder decodeObjectForKey:@"O_ports"] retain];
		label = [[coder decodeObjectForKey:@"O_label"] retain];	
		description = [[coder decodeObjectForKey:@"O_description"] retain];	
		image = [[coder decodeObjectForKey:@"O_image"] retain];	
		isDisplay = [coder decodeBoolForKey:@"O_display"];	
		isPulse = [coder decodeBoolForKey:@"O_pulse"];	
		colorState = [[coder decodeObjectForKey:@"O_colorState"] retain];
		size = [coder decodeSizeForKey:@"O_size"];	
		posInView = [coder decodePointForKey:@"O_posInView"];
		hasButton = [coder decodeBoolForKey:@"O_hasButton"];
		isIC = [coder decodeBoolForKey:@"O_isIC"];
		knop.size = [coder decodeSizeForKey:@"O_knop_size"];
		knop.origin = [coder decodePointForKey:@"O_knop_origin"];
		state = [coder decodeIntForKey:@"O_state"];
		
		if([self isDisplay]) {
		[self loadDisplayParts]; }
	}
	return self;
}

-(void)dealloc {
	[super dealloc];
}

-(NSString*)name {
	return label;
}

-(void)switchButton { }

@end
