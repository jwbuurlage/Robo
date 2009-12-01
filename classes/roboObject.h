//
//  roboViewObject.h
//  Robo
//


#import <Cocoa/Cocoa.h>
#import "port.h"
#import "displayPart.h"

@interface roboObject : NSObject <NSCoding> {
	NSSize size;
	NSPoint posInView;
	NSMutableArray* ports;
	NSString* label;
	NSString* description;
	NSImage* image;
	BOOL isDisplay;
	BOOL isPulse;
	BOOL isIC;
	BOOL hasButton;
	NSRect knop; 
	NSColor* colorState;
	
	int state;
	//0: uit
	//1: ingedrukt/uit
	//2: aan
	//3: ingedrukt aan
}

@property (retain)NSImage* image;
@property NSPoint posInView;
@property NSSize size;
@property NSRect knop;
@property BOOL isDisplay;
@property BOOL isIC;
@property BOOL isPulse;
@property BOOL hasButton;
@property (retain)NSString* label;
@property (retain)NSString* description;
@property (retain)NSColor* colorState;


- (NSArray*)ports;
- (NSArray*)displayParts;


-(void)loadDisplayParts;

-(NSString*)name;

-(void)switchButton;

@end
