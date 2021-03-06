//
//  roboCell.m
//  Robo
//
//  Created by Jan-Willem Buurlage on 09-01-09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "roboCell.h"

@implementation roboCell
@synthesize subTitle, image;

- (void)drawInteriorWithFrame:(NSRect)theCellFrame inView:(NSView *)theControlView
{
	
	// Inset the cell frame to give everything a little horizontal padding
	NSRect		anInsetRect = NSInsetRect(theCellFrame,10,0);
	
	// Make the icon
	NSImage *	anIcon = image;
	
	// Flip the icon because the entire cell has a flipped coordinate system
	[anIcon setFlipped:YES];
	
	// get the size of the icon for layout
	NSSize		anIconSize = [anIcon size];
	
	// Make attributes for our strings
	NSMutableParagraphStyle * aParagraphStyle = [[[NSMutableParagraphStyle alloc] init] autorelease];
	[aParagraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
	
	// Title attributes: system font, 14pt, black, truncate tail
	NSMutableDictionary * aTitleAttributes = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:
											   [NSColor blackColor],NSForegroundColorAttributeName,
											   [NSFont systemFontOfSize:12.0],NSFontAttributeName,
											   aParagraphStyle, NSParagraphStyleAttributeName,
											   nil] autorelease];
	
	// Subtitle attributes: system font, 12pt, gray, truncate tail
	NSMutableDictionary * aSubtitleAttributes = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:
												  [NSColor grayColor],NSForegroundColorAttributeName,
												  [NSFont systemFontOfSize:10.0],NSFontAttributeName,
												  aParagraphStyle, NSParagraphStyleAttributeName,
												  nil] autorelease];
	
	// Make the strings and get their sizes
	// I'm hard coding these strings here.  In a real implementation of a table cell, you'll 
	// use the cell's "objectValue" to display real data.
	
	//	NSString *	aTitle = @"A Realy Realy Realy Really Long Title"; // try using this string as the title for testing the truncating tail attribute
	
	// Make a Title string
	NSString *	aTitle = [self objectValue];
	// get the size of the string for layout
	NSSize		aTitleSize = [aTitle sizeWithAttributes:aTitleAttributes];
	
	// Make a Subtitle string
	NSString* aSubtitle = subTitle;
	// get the size of the string for layout
	NSSize		aSubtitleSize = [aSubtitle sizeWithAttributes:aSubtitleAttributes];
	
	
	// Make the layout boxes for all of our elements - remember that we're in a flipped coordinate system when setting the y-values
	
	// Vertical padding between the lines of text
	float		aVerticalPadding = 5.0;
	
	// Horizontal padding between icon and text
	float		aHorizontalPadding = 10.0;
	
	// Icon box: center the icon vertically inside of the inset rect
	NSRect		anIconBox = NSMakeRect(anInsetRect.origin.x,
									   anInsetRect.origin.y + anInsetRect.size.height*.5 - anIconSize.height*.5,
									   anIconSize.width,
									   anIconSize.height);
	
	// Make a box for our text
	// Place it next to the icon with horizontal padding
	// Size it horizontally to fill out the rest of the inset rect
	// Center it vertically inside of the inset rect
	float		aCombinedHeight = aTitleSize.height + aSubtitleSize.height + aVerticalPadding;
	
	NSRect		aTextBox = NSMakeRect(anIconBox.origin.x + anIconBox.size.width + aHorizontalPadding,
									  anInsetRect.origin.y + anInsetRect.size.height*.5 - aCombinedHeight*.5,
									  anInsetRect.size.width - anIconSize.width - aHorizontalPadding,
									  aCombinedHeight);
	
	// Now split the text box in half and put the title box in the top half and subtitle box in bottom half
	NSRect		aTitleBox = NSMakeRect(aTextBox.origin.x, 
									   aTextBox.origin.y + aTextBox.size.height*.5 - aTitleSize.height,
									   aTextBox.size.width,
									   aTitleSize.height);
	
	NSRect		aSubtitleBox = NSMakeRect(aTextBox.origin.x,
										  aTextBox.origin.y + aTextBox.size.height*.5,
										  aTextBox.size.width,
										  aSubtitleSize.height);
	
	
	if(	[self isHighlighted])
	{
		// if the cell is highlighted, draw the text white
		[aTitleAttributes setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
		[aSubtitleAttributes setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	}
	else
	{
		// if the cell is not highlighted, draw the title black and the subtile gray
		[aTitleAttributes setValue:[NSColor blackColor] forKey:NSForegroundColorAttributeName];
		[aSubtitleAttributes setValue:[NSColor grayColor] forKey:NSForegroundColorAttributeName];
	}
	
	
	// Draw the icon
	[anIcon drawInRect:anIconBox fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	// Draw the text
	[aTitle drawInRect:aTitleBox withAttributes:aTitleAttributes];
	[aSubtitle drawInRect:aSubtitleBox withAttributes:aSubtitleAttributes];
}	


@end
