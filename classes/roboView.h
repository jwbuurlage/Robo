//
//  roboView.h
//  Robo
//


#import <Cocoa/Cocoa.h>
#import "MyDocument.h"
#import "connection.h"
#import "port.h"
#import "displayPart.h"

@class port;
@class connection;
@class MyDocument;

@interface roboView : NSView {
	IBOutlet MyDocument* document;
	BOOL dragging;
	BOOL clickedPort;
	id objectDragged;
	NSPoint dragStartPoint;
	connection* dragConnection;
	
	BOOL acceptColor;
	
	NSPoint startPoint;
	NSPoint endPoint;
	BOOL drawLine;
	
	BOOL drawArrow;
	NSPoint arrowStartPoint;
	NSPoint arrowEndPoint;
	int deleteIndex;
	int fwdIndex;
	NSRect deleteBox;
	NSRect fwdBox;
	BOOL showBoxes;
}

-(void)drawRoundedRect:(NSRect)rect color:(NSColor*)color;
-(void)drawRect:(NSRect)rect color:(NSColor*)color;

- (void)updateViewFrame;
- (NSRect)canvasRect;
	
-(void)orderFront;

@end
