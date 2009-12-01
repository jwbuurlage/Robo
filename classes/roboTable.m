//
//  roboTable.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 09-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "roboTable.h"
#import "NSColorAdditions.h"

@interface roboTable (Private)
- (void) performDrawDropHighlightBetweenUpperRow:(int)theUpperRowIndex andLowerRow:(int)theLowerRowIndex atOffset:(float)theOffset;
@end

@implementation roboTable

- (void)awakeFromNib
{
	// highlight colors
	mHighlightColorInFocusView = [[NSColor colorWithDeviceRed:.263 green:.424 blue:.639 alpha:1.0] retain];
	mHighlightColorOutOfFocusView = [[NSColor colorWithDeviceRed:.584 green:.659 blue:.753 alpha:1.0] retain];
}

- (void)dealloc
{
	// release the colors
	[mHighlightColorInFocusView release];
	[mHighlightColorOutOfFocusView release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark Selection Highlighting

- (id)_highlightColorForCell:(NSCell *)cell
{
	// we need to override this to return nil
	// or we'll see the default selection rectangle when the app is running 
	// in any OS before leopard
	
	// you can also return a color if you simply want to change the table's default selection color
    return nil;
}

- (void)highlightSelectionInClipRect:(NSRect)theClipRect
{
	
	// this method is asking us to draw the hightlights for 
	// all of the selected rows that are visible inside theClipRect
	
	// 1. get the range of row indexes that are currently visible
	// 2. get a list of selected rows
	// 3. iterate over the visible rows and if their index is selected
	// 4. draw our custom highlight in the rect of that row.
	
	NSRange			aVisibleRowIndexes = [self rowsInRect:theClipRect];
	NSIndexSet *	aSelectedRowIndexes = [self selectedRowIndexes];
	int				aRow = aVisibleRowIndexes.location;
	int				anEndRow = aRow + aVisibleRowIndexes.length;
	
	// if the view is focused, use highlight color, otherwise use the out-of-focus highlight color
	if (	self == [[self window] firstResponder]
		&&	[[self window] isMainWindow]
		&&	[[self window] isKeyWindow])
		[mHighlightColorInFocusView set];
	else
		[mHighlightColorOutOfFocusView set];
	
	// draw highlight for the visible, selected rows
    for (aRow; aRow < anEndRow; aRow++)
    {
		if([aSelectedRowIndexes containsIndex:aRow])
		{
			NSRect aRowRect = NSInsetRect([self rectOfRow:aRow], 2, 2);
			[[NSBezierPath bezierPathWithRoundedRect:aRowRect xRadius:8.0 yRadius:8.0] fill];
		}
	}
}


#pragma mark -
#pragma mark Drag And Drop
- (NSImage *)dragImageForRowsWithIndexes:(NSIndexSet *)theRowIndexes 
							tableColumns:(NSArray *)theTableColumns 
								   event:(NSEvent *)theEvent 
								  offset:(NSPointPointer)theOffset
{
	
	// super will return an NSImage with the cell drawn inside
	NSImage *		aDefaultImage = [super dragImageForRowsWithIndexes:theRowIndexes
													 tableColumns:theTableColumns 
															event:theEvent 
														   offset:theOffset];
	
	// get the size of the combined area of the selected rows
	NSSize	aSelectionSize = [aDefaultImage size];
	
	// make a rect at 0, 0 with our combined row size
	NSRect	aFillRect = NSMakeRect(0, 0, aSelectionSize.width, aSelectionSize.height);
	
	// make a rounded rect with the fill rect
	NSBezierPath *	aRoundedRectBezierPath = [NSBezierPath bezierPathWithRoundedRect:aFillRect xRadius:8.0 yRadius:8.0];
	
	// start a new NSImage
	NSImage *	aCustomImage = [[[NSImage alloc] initWithSize:aSelectionSize] autorelease];
	
	// lock focus on the image
	[aCustomImage lockFocus];
	
	// set the main selection color with half alpha value
	[[mHighlightColorInFocusView colorWithAlphaComponent:.5] set];
	
	// fill the rounded rect
	[aRoundedRectBezierPath fill];
	
	// composite the cell image onto our image
	[aDefaultImage dissolveToPoint:NSZeroPoint fraction:1.0];
	
	// unlock focus
	[aCustomImage unlockFocus];
	
	// return the new image
	return aCustomImage;
}

-(void)_drawDropHighlightOnRow:(int)theRowIndex
{
	// if you don't want a drop highlight between rows, leave this method blank
	
	// draw a rounded rect over the row.
	NSRect	aHighlightRect = NSInsetRect([self rectOfRow:theRowIndex], 2, 1);
	NSBezierPath *	aRoundedRectBezierPath = [NSBezierPath bezierPathWithRoundedRect:aHighlightRect xRadius:8.0 yRadius:8.0];
	[[NSColor blackColor]set];
	[aRoundedRectBezierPath setLineWidth:2.0];
	[aRoundedRectBezierPath stroke];
}

+(id)_dropHighlightBackgroundColor
{
	// Called in Leopard
	
	// don't want a background color for drop highlights
	return [NSColor clearColor];
}

- (void)_drawDropHighlightBetweenUpperRow:(int)theUpperRowIndex andLowerRow:(int)theLowerRowIndex onRow:(int)theRow atOffset:(float)theOffset
{
	// Called in Leopard
	[self performDrawDropHighlightBetweenUpperRow:theUpperRowIndex
									  andLowerRow:theLowerRowIndex
										 atOffset:theOffset];
}

- (void) _drawDropHighlightBetweenUpperRow:(int)theUpperRowIndex andLowerRow:(int)theLowerRowIndex atOffset:(float)theOffset
{
	// Called in Tiger
	[self performDrawDropHighlightBetweenUpperRow:theUpperRowIndex
									  andLowerRow:theLowerRowIndex
										 atOffset:theOffset];
}

- (void) performDrawDropHighlightBetweenUpperRow:(int)theUpperRowIndex andLowerRow:(int)theLowerRowIndex atOffset:(float)theOffset

{

}


@end
