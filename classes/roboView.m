//
//  roboView.m
//  Robo
//


#import "roboView.h"


@implementation roboView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		deleteBox.size.width = 20;
		deleteBox.size.height = 20;
    }
    return self;
}

-(void)orderFront {
	[[self window] makeFirstResponder:self];
}

- (void)awakeFromNib
{
	[[self window] makeFirstResponder: self];
	[[self window] setAcceptsMouseMovedEvents: YES];
	[document updateAllPorts];
}

- (void)drawRect:(NSRect)rect {
	NSArray* connections = [document connections];
	NSArray* ICs = [document ICs];
	NSAttributedString* labelToDraw;
	NSBezierPath* path = [NSBezierPath bezierPath];
	[NSBezierPath setDefaultLineWidth:1.5];
	NSPoint inputPoint, outputPoint, drawPoint, control_1, control_2;

	NSFont* labelFont = [NSFont fontWithName:@"Helvetica" size:12.0];
	NSMutableDictionary* labelAttributes = [NSMutableDictionary dictionary];
	[labelAttributes setObject:labelFont forKey:NSFontAttributeName];
	[labelAttributes setObject:[[NSColor whiteColor] colorWithAlphaComponent:1] forKey:NSForegroundColorAttributeName];
	NSColor* ICColor = [[NSColor blackColor] colorWithAlphaComponent:0.9];
	
	NSFont* numberFont = [NSFont fontWithName:@"Helvetica Neue" size:10.0];
	NSMutableDictionary* numberAttributes = [NSMutableDictionary dictionary];
	[numberAttributes setObject:numberFont forKey:NSFontAttributeName];						
	[numberAttributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];	
	
	NSFont* smallFont = [NSFont fontWithName:@"Courier" size:9.0];
	NSMutableDictionary* smallAttributes = [NSMutableDictionary dictionary];
	[smallAttributes setObject:smallFont forKey:NSFontAttributeName];
	[smallAttributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];		
	
	if(drawLine) {
		NSBezierPath* drawPath = [NSBezierPath bezierPath];
		[drawPath moveToPoint:startPoint];
		[drawPath lineToPoint:endPoint];
		[[NSColor greenColor] set];
		float array[] = { 5.0, 2.0, 10.0, 3.0 };
		[drawPath setLineDash:array count:2 phase:0.0]; 
		[drawPath stroke];
	}
	
    for(connection* connectionInLoop in connections) {
		path = [NSBezierPath bezierPath];
		//get ports positions		
		outputPoint.x = [[[connectionInLoop output] ofObject] posInView].x + [[connectionInLoop output] relPos].x + 10;
		outputPoint.y = [[[connectionInLoop output] ofObject] posInView].y + [[connectionInLoop output] relPos].y + 10;
		inputPoint.x = [[[connectionInLoop input] ofObject] posInView].x + [[connectionInLoop input] relPos].x + 10;
		inputPoint.y = [[[connectionInLoop input] ofObject] posInView].y + [[connectionInLoop input] relPos].y + 10;
		
		control_1 = outputPoint;
		control_2 = inputPoint;
		//voor de kromme draad, relatieve positie krijgen t.o.v. port
		if([[connectionInLoop output] relPos].x == [[[connectionInLoop output] ofObject] size].width - 10) {
			control_1.x += 30; 
			outputPoint.x += 10; }
		else if([[connectionInLoop output] relPos].x == -10) {
			control_1.x -= 30; 
			outputPoint.x -= 10; }
		else if([[connectionInLoop output] relPos].y == -10) {
			control_1.y -= 30; 
			outputPoint.y -= 10; }
		else if([[connectionInLoop output] relPos].y == [[[connectionInLoop output] ofObject] size].height - 10) {
			control_1.y += 30; 
			outputPoint.y += 10; }

		
		//voor de input ook
		if([[connectionInLoop input] relPos].x == [[[connectionInLoop input] ofObject] size].width - 10) {
			control_2.x += 60;
			inputPoint.x += 10; }
		else if([[connectionInLoop input] relPos].x == -10) {
			control_2.x -= 60;
			inputPoint.x -= 10; }
		else if([[connectionInLoop input] relPos].y == -10) {
			control_2.y -= 60;
			inputPoint.y -= 10; }
		else if([[connectionInLoop input] relPos].y == [[[connectionInLoop input] ofObject] size].height - 10) {
			control_2.y += 60;
			inputPoint.y += 10; }
		
		[path moveToPoint:outputPoint];
		[path curveToPoint:inputPoint 
			 controlPoint1:control_1
			 controlPoint2:control_2];
		
		if([[connectionInLoop output] high]) { [[[NSColor redColor] colorWithAlphaComponent:0.5] set]; }
		else { [[[NSColor blackColor] colorWithAlphaComponent:0.5] set]; }
		[path stroke];
	}

    for(id ICInLoop in ICs) {
		
		NSRect roundedRect;
		roundedRect.size = [ICInLoop size];
		roundedRect.origin = [ICInLoop posInView];
		[self drawRoundedRect:roundedRect
						color:ICColor];
		
		if([ICInLoop hasButton]) {
			NSRect knop = [ICInLoop knop];
			knop.origin.x = [ICInLoop posInView].x + knop.origin.x;
			knop.origin.y = [ICInLoop posInView].y + knop.origin.y; 
			[self drawRoundedRect:knop color:[[ICInLoop colorState] colorWithAlphaComponent:0.8]];
			
			NSFont* labelFont2 = [NSFont fontWithName:@"Helvetica" size:9.0];
			NSMutableDictionary* labelAttributes2 = [NSMutableDictionary dictionary];
			[labelAttributes2 setObject:labelFont2 forKey:NSFontAttributeName];

			[labelAttributes2 setObject:[[NSColor whiteColor] colorWithAlphaComponent:1] forKey:NSForegroundColorAttributeName];
		
			labelToDraw = [[NSAttributedString alloc] initWithString:[ICInLoop label]
														  attributes:labelAttributes2];  
			
			[labelFont2 dealloc];
			[labelAttributes dealloc];
			
		}		
		else {
			labelToDraw = [[NSAttributedString alloc] initWithString:[ICInLoop label]
													  attributes:labelAttributes];  
		}
		drawPoint = [ICInLoop posInView];
		drawPoint.x += (0.5 * roundedRect.size.width) - (0.5 * [labelToDraw size].width);
		drawPoint.y += (0.5 * roundedRect.size.height) - (0.5 * [labelToDraw size].height);

		if([ICInLoop isDisplay]) {
			drawPoint.y += 100;
		} 
		[labelToDraw drawAtPoint:drawPoint]; 
		[labelToDraw dealloc];

		//als DISPLAY dan tekenen we de displayparts
		//"squares" cutoffs > 10px bij 10px
		//height: 50px;
		
			if([ICInLoop isDisplay]) {
				
			for(displayPart* part in [ICInLoop displayParts]) {
				NSBezierPath* path = [NSBezierPath bezierPath];
				NSPoint startPos = [ICInLoop posInView];
				startPos.x += [part relPos].x;
				startPos.y += [part relPos].y;
				
				switch([part position]) {
					case 1:
						[path moveToPoint:startPos];
						[path lineToPoint:NSMakePoint(startPos.x + 10, startPos.y + 10)];
						[path lineToPoint:NSMakePoint(startPos.x + 10, startPos.y + 45)];
						[path lineToPoint:NSMakePoint(startPos.x, startPos.y + 50)];
						[path closePath];
						break;
					case 2:
						[path moveToPoint:NSMakePoint(startPos.x + 10, startPos.y)];
						[path lineToPoint:NSMakePoint(startPos.x + 10, startPos.y + 50)];
						[path lineToPoint:NSMakePoint(startPos.x, startPos.y + 45)];
						[path lineToPoint:NSMakePoint(startPos.x, startPos.y + 10)];
						[path closePath];
						break;
					case 3:
						[path moveToPoint:startPos];
						[path lineToPoint:NSMakePoint(startPos.x + 50, startPos.y)];
						[path lineToPoint:NSMakePoint(startPos.x + 40, startPos.y + 10)];
						[path lineToPoint:NSMakePoint(startPos.x + 10, startPos.y + 10)];
						[path closePath];
						break;
					case 4:
						[path moveToPoint:NSMakePoint(startPos.x, startPos.y + 10)];
						[path lineToPoint:NSMakePoint(startPos.x + 50, startPos.y + 10)];
						[path lineToPoint:NSMakePoint(startPos.x + 40, startPos.y)];
						[path lineToPoint:NSMakePoint(startPos.x + 10, startPos.y)];
						[path closePath];
						break;
					case 5:
						[path moveToPoint:NSMakePoint(startPos.x, startPos.y)];
						[path lineToPoint:NSMakePoint(startPos.x + 10, startPos.y - 5)];
						[path lineToPoint:NSMakePoint(startPos.x + 40, startPos.y - 5)];
						[path lineToPoint:NSMakePoint(startPos.x + 50, startPos.y)];
						[path lineToPoint:NSMakePoint(startPos.x + 40, startPos.y + 5)];
						[path lineToPoint:NSMakePoint(startPos.x + 10, startPos.y + 5)];
						[path closePath];
						break;
					case 6:
						[path moveToPoint:startPos];
						[path lineToPoint:NSMakePoint(startPos.x + 10, startPos.y + 5)];
						[path lineToPoint:NSMakePoint(startPos.x + 10, startPos.y + 40)];
						[path lineToPoint:NSMakePoint(startPos.x, startPos.y + 50)];
						[path closePath];
						break;
					case 7:
						[path moveToPoint:NSMakePoint(startPos.x + 10, startPos.y)];
						[path lineToPoint:NSMakePoint(startPos.x + 10, startPos.y + 50)];
						[path lineToPoint:NSMakePoint(startPos.x, startPos.y + 40)];
						[path lineToPoint:NSMakePoint(startPos.x, startPos.y + 5)];
						[path closePath];
						break;
					case 8: 
						path = [NSBezierPath bezierPathWithRect:NSMakeRect(startPos.x + 12, startPos.y, 10, 10)];
						break;
					case 9:
						path = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(startPos.x, startPos.y, 30, 30)];
						break;
				}
				
				if([part high]) {
					[[ICInLoop colorState] set];
				}
				else {
					[[[NSColor grayColor] colorWithAlphaComponent:0.2] set];
				}
				[path fill];
			}
		}
		
		//draw ports
		NSColor* backDrop;
		
		for(port* portInLoop in [ICInLoop ports]) {
			if([portInLoop high]) {
				backDrop = [[NSColor redColor] colorWithAlphaComponent:0.8];
			}
			else {
				backDrop = [NSColor colorWithCalibratedRed:0.2 green:0.2 blue:0.2 alpha:0.8];
			}
			
			NSRect rect;
			rect.size.width = 20;
			rect.size.height = 20;
			rect.origin.x = [ICInLoop posInView].x + [portInLoop relPos].x;
			rect.origin.y = [ICInLoop posInView].y + [portInLoop relPos].y;
			
			[self drawRect:rect
					 color:backDrop];
				
			labelToDraw = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat: @"%d", [portInLoop number]]
														  attributes:numberAttributes];
			
			drawPoint = rect.origin;
			drawPoint.x += (0.5 * rect.size.width) - (0.5 * [labelToDraw size].width);
			drawPoint.y += (0.5 * rect.size.height) - (0.5 * [labelToDraw size].height);
			[labelToDraw drawAtPoint:drawPoint];
			[labelToDraw dealloc];

			labelToDraw = [[NSAttributedString alloc] initWithString:[portInLoop label]
														  attributes:smallAttributes];
						
			drawPoint = rect.origin;
			
			if([[portInLoop ofObject] isDisplay] == FALSE) {
				drawPoint.x += (0.5 * rect.size.width) - (0.5 * [labelToDraw size].width);
				if([portInLoop number] > (0.5 * [[ICInLoop ports] count])) { drawPoint.y += 24; }
				else { drawPoint.y -= 14; }
			}
			else {
				drawPoint.y += (0.5 * rect.size.height) - (0.5 * [labelToDraw size].height);
				if([portInLoop number] > (0.5 * [[ICInLoop ports] count])) { drawPoint.x -= 14; }
				else { drawPoint.x += 24; }	
			}
			[labelToDraw drawAtPoint:drawPoint];
			[labelToDraw dealloc];
		}
	}
	if(drawArrow) {
		NSBezierPath* arrow = [NSBezierPath bezierPath];
		[arrow moveToPoint:arrowStartPoint];
		[arrow lineToPoint:arrowEndPoint];
		[arrow setLineWidth:6];
		[[NSColor greenColor] set];
		[arrow stroke];
		
		//moet een arrow worden en ff slim gemaakt.
		NSRect ovalRect = NSMakeRect(arrowEndPoint.x - 10, arrowEndPoint.y - 10, 20, 20);
		NSBezierPath* circle = [NSBezierPath bezierPathWithOvalInRect:ovalRect];
		[circle setLineWidth:4];
		[circle appendBezierPath:arrow];
		[[NSColor blueColor] set];
		//[circle fill];
	}
	if(showBoxes && !drawLine) {
		fwdBox = deleteBox;
		fwdBox.origin.x += 25;
		
		NSBezierPath* circlePath = [NSBezierPath bezierPathWithOvalInRect:deleteBox];
		NSBezierPath* circlePath_fwd = [NSBezierPath bezierPathWithOvalInRect:fwdBox];

		[[[NSColor redColor] colorWithAlphaComponent:0.8] set];
		[circlePath fill];
		[[NSColor redColor] set];
		[circlePath setLineWidth:1];
		[circlePath stroke];

		
		NSBezierPath* stripe = [NSBezierPath bezierPath];
		[stripe moveToPoint:NSMakePoint(deleteBox.origin.x + 5, deleteBox.origin.y + 10)];
		[stripe lineToPoint:NSMakePoint(deleteBox.origin.x + 15, deleteBox.origin.y + 10)];
		[[[NSColor whiteColor] colorWithAlphaComponent:0.95] set];
		[stripe setLineWidth:4];
		[stripe stroke];

		if([[[document ICs] objectAtIndex:deleteIndex] isDisplay]) {
			[[[NSColor cyanColor] colorWithAlphaComponent:0.8] set];
			[circlePath_fwd fill];
			
			[[[NSColor cyanColor] colorWithAlphaComponent:0.8] set];
			[circlePath_fwd setLineWidth:1];
			[circlePath_fwd stroke];
			
			NSBezierPath* ruit = [NSBezierPath bezierPath];
			[ruit moveToPoint:NSMakePoint(fwdBox.origin.x + 3, fwdBox.origin.y + 10)];
			[ruit lineToPoint:NSMakePoint(fwdBox.origin.x + 10, fwdBox.origin.y + 3)];
			[ruit lineToPoint:NSMakePoint(fwdBox.origin.x + 17, fwdBox.origin.y + 10)];
			[ruit lineToPoint:NSMakePoint(fwdBox.origin.x + 10, fwdBox.origin.y + 17)];
			[ruit closePath];
			[[[NSColor whiteColor] colorWithAlphaComponent:0.95] set];
			[ruit fill];
		}
		else if([[[document ICs] objectAtIndex:deleteIndex] isIC]){	
			[[[NSColor greenColor] colorWithAlphaComponent:0.8] set];
			[circlePath_fwd fill];
			
			[[[NSColor greenColor] colorWithAlphaComponent:0.8] set];
			[circlePath_fwd setLineWidth:1];
			[circlePath_fwd stroke];
			
			NSBezierPath* arrow = [NSBezierPath bezierPath];
			[arrow moveToPoint:NSMakePoint(fwdBox.origin.x + 7, fwdBox.origin.y + 15)];
			[arrow lineToPoint:NSMakePoint(fwdBox.origin.x + 7, fwdBox.origin.y + 10)];
			[arrow lineToPoint:NSMakePoint(fwdBox.origin.x + 4, fwdBox.origin.y + 10)];
			[arrow lineToPoint:NSMakePoint(fwdBox.origin.x + 10, fwdBox.origin.y + 3)];
			[arrow lineToPoint:NSMakePoint(fwdBox.origin.x + 16, fwdBox.origin.y + 10)];
			[arrow lineToPoint:NSMakePoint(fwdBox.origin.x + 13, fwdBox.origin.y + 10)];
			[arrow lineToPoint:NSMakePoint(fwdBox.origin.x + 13, fwdBox.origin.y + 15)];
			[arrow closePath];
			[[[NSColor whiteColor] colorWithAlphaComponent:0.95] set];
			[arrow fill];
		}
		/*
		NSBezierPath* cross = [NSBezierPath bezierPath];
		[cross moveToPoint:NSMakePoint(deleteBox.origin.x + 2.93, deleteBox.origin.y + 2.93)];
		[cross lineToPoint:NSMakePoint(deleteBox.origin.x + 20 - 2.93, deleteBox.origin.y + 20 - 2.93)];
		[cross moveToPoint:NSMakePoint(deleteBox.origin.x + 20 - 2.93, deleteBox.origin.y + 2.93)];
		[cross lineToPoint:NSMakePoint(deleteBox.origin.x + 2.93, deleteBox.origin.y + 20 - 2.93)];
		[[[NSColor whiteColor] colorWithAlphaComponent:0.8] set];
		[cross setLineWidth:3];
		[cross stroke]; */
	}
	

	
}

-(void)drawRoundedRect:(NSRect)rect color:(NSColor*)color {
	NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:8.0 yRadius:8.0];
	[path setLineWidth:2.0];
	[[NSColor grayColor] set];
	[path stroke];
	[color set];
	[path fill];
	
	rect.origin.y += 0.6 * rect.size.height;
	rect.size.height = rect.size.height / (1 / 0.6);
	path = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:8.0 yRadius:8.0];
	[[[NSColor whiteColor] colorWithAlphaComponent:0.015] set];
	[path fill];
}

-(void)drawRect:(NSRect)rect color:(NSColor*)color {
	NSBezierPath* path = [NSBezierPath bezierPathWithRect:rect];
	[path setLineWidth:1.0];
	[[NSColor grayColor] set];
	[path stroke];
	[color set];
	[path fill];
}


- (void)mouseDown:(NSEvent *)event {
	//drawArrow moet niet worden als er in het niks wordt geklikt
	NSPoint locationInView = [self convertPoint:[event locationInWindow] fromView:nil];
	BOOL clickedBox = FALSE;
	
	if(showBoxes) {
		if(NSPointInRect(locationInView, deleteBox)) {
			[document removeIC:[[document ICs] objectAtIndex:deleteIndex]];
			showBoxes = FALSE;
		}
		else if([[[document ICs] objectAtIndex:deleteIndex] isDisplay] || [[[document ICs] objectAtIndex:deleteIndex] isIC] ){	 
			if(NSPointInRect(locationInView, fwdBox)) {
					if([[[document ICs] objectAtIndex:deleteIndex] isDisplay]) {
							fwdIndex = deleteIndex;
							acceptColor = YES;
							[[NSColorPanel sharedColorPanel] setColor:[[[document ICs] objectAtIndex:deleteIndex] colorState]];
							[[NSColorPanel sharedColorPanel] orderFront:self];
							clickedBox = TRUE; 
						}
					else {
						arrowStartPoint = NSMakePoint(fwdBox.origin.x + 10, fwdBox.origin.y + 10);
						arrowEndPoint = locationInView;
						drawArrow = TRUE;
						fwdIndex = deleteIndex;
						clickedBox = TRUE; 
					}
			}
		}
	}
	
	for(id ICInLoop in [document ICs]) {
		for(port* portInLoop in [ICInLoop ports]) {
			//relatieve positie, dan ronde box
			NSPoint origin;
			origin.x = [ICInLoop posInView].x + [portInLoop relPos].x;
			origin.y = [ICInLoop posInView].y + [portInLoop relPos].y;
			NSRect boundRect = NSMakeRect(origin.x, origin.y, 20, 20);
			if(NSPointInRect(locationInView, boundRect)) {
				if(clickedPort == TRUE) {
					clickedPort = FALSE;
					if([portInLoop input]) {
						for(connection* conn in [document connections]) {
							if([[conn input] isEqual:portInLoop]) {
								if([[conn input] specialInput] == FALSE)  {
								[document removeConnection:conn]; }
							}
						}
						[dragConnection closeWithInput:portInLoop];
						drawLine = FALSE;
						[document addObjectToConnections:dragConnection];
					}
					else {
						drawLine = FALSE;
					}
				}
				else {
					if([portInLoop input] == FALSE){
						connection* newConnection = [[connection alloc] initWithOutput:portInLoop];
						dragConnection = newConnection;
						clickedPort = TRUE;
						drawLine = TRUE;
						NSPoint theStartPoint = boundRect.origin;
						theStartPoint.x += (0.5 * boundRect.size.width);
						theStartPoint.y += (0.5 * boundRect.size.height);
						startPoint = theStartPoint;
						endPoint = theStartPoint;
						break;
					}
				}
			}
		}
		if(!clickedPort && !clickedBox) {
			NSPoint origin = [ICInLoop posInView];
			NSSize size = [ICInLoop size];
			
			NSRect boundRect = NSMakeRect(origin.x, origin.y, size.width, size.height);
			
			if(NSPointInRect(locationInView, boundRect)) {
				if(!drawArrow) {
					if([ICInLoop hasButton]) {
						NSRect button = [ICInLoop knop];
						button.origin.x = [ICInLoop posInView].x + button.origin.x;
						button.origin.y = [ICInLoop posInView].y + button.origin.y; 
						if(NSPointInRect(locationInView, button)) {
							[ICInLoop switchButton];
							[ICInLoop updateAllPorts];
							[document updateAllPorts];
						}
					}
					dragStartPoint.x = locationInView.x - boundRect.origin.x;
					dragStartPoint.y = locationInView.y - boundRect.origin.y;
					dragging = TRUE;
					showBoxes = FALSE;
					objectDragged = ICInLoop;
				}
				else {
					[document connectIC:[[document ICs] objectAtIndex:fwdIndex] to:[[document ICs] objectAtIndex:deleteIndex]];
				}
			}
		}
	}
	
	if(!clickedBox) {
		drawArrow = FALSE;	
	}
	
	[document updateAllPorts];
	[self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event {
	NSPoint locationInView = [self convertPoint:[event locationInWindow] fromView:nil];
	if(dragging == TRUE) {
		locationInView.x -= dragStartPoint.x;
		locationInView.y -= dragStartPoint.y;
		
		[objectDragged setPosInView:locationInView];
		[self updateViewFrame];
		[self setNeedsDisplay:YES];
	}
}

- (void)mouseUp:(NSEvent *)event {
	dragging = FALSE;
	NSPoint locationInView = [self convertPoint:[event locationInWindow] fromView:nil];
	
	BOOL inRect = FALSE;
	//kijken of muis dichtbij een ic is
	for(id ICInLoop in [document ICs]) {
		NSRect boundBox;
		boundBox.origin = [ICInLoop posInView];
		boundBox.size = [ICInLoop size];
		
		if(NSPointInRect(locationInView, boundBox)) {
			if([ICInLoop hasButton]) {
				NSRect button = [ICInLoop knop];
				button.origin.x = [ICInLoop posInView].x + button.origin.x;
				button.origin.y = [ICInLoop posInView].y + button.origin.y; 
				if(NSPointInRect(locationInView, button)) {
					[ICInLoop switchButton];
					[ICInLoop updateAllPorts];
					[document updateAllPorts];
				}
			}
			
			inRect = TRUE;
			deleteBox.origin.x = boundBox.origin.x - 5;
			deleteBox.origin.y = boundBox.origin.y - 5;
			deleteIndex = [[document ICs] indexOfObject:ICInLoop];
		}
	}
	if(inRect == TRUE) {
		showBoxes = TRUE;
	}
	else {
		showBoxes = FALSE;
	}

	if(showBoxes) {
	[self setNeedsDisplay:YES]; }
}

- (void)mouseMoved:(NSEvent *)event {
	NSPoint locationInView = [self convertPoint:[event locationInWindow] fromView:nil];
	if(clickedPort == TRUE) {
		endPoint = locationInView; 
	}
	else { 
		if(drawArrow) { 
			arrowEndPoint = locationInView;
		}
		
		BOOL inRect = FALSE;
		//kijken of muis dichtbij een ic is
		for(id ICInLoop in [document ICs]) {
			NSRect boundBox;
			boundBox.origin = [ICInLoop posInView];
			boundBox.size = [ICInLoop size];
			
			if(NSPointInRect(locationInView, boundBox)) {
				if(drawArrow) {
					arrowEndPoint = NSMakePoint(boundBox.origin.x + (0.5 * boundBox.size.width), boundBox.origin.y+ (0.5 * boundBox.size.height));
					deleteIndex = [[document ICs] indexOfObject:ICInLoop];
				}
				else {
				inRect = TRUE;
				deleteBox.origin.x = boundBox.origin.x - 5;
				deleteBox.origin.y = boundBox.origin.y - 5;
				deleteIndex = [[document ICs] indexOfObject:ICInLoop];
				}
			}
		}
		if(inRect == TRUE) { showBoxes = TRUE; }
		else { if(!drawArrow) { showBoxes = FALSE; } }
	}
	[self setNeedsDisplay:YES];
}

- (NSRect)canvasRect {
	float minX, minY, maxX, maxY = 0;
	
	for(id object in [document ICs]) {
		if([object posInView].x < minX) {
			minX = [object posInView].x;
		}
		if([object posInView].x + [object size].width > maxX) {
			maxX = [object posInView].x + [object size].width; 
		}
		if([object posInView].y < minY) {
			minY = [object posInView].y;
		}
		if([object posInView].y + [object size].height > maxY) {
			maxY = [object posInView].y + [object size].height;
		}
	}
	
	NSRect mapRect = NSMakeRect([self frame].origin.x, [self frame].origin.y, ABS(maxX - minX), ABS(maxY - minY));
	return mapRect;
}

- (void)updateViewFrame {
	NSRect mapRect = [self canvasRect];
	NSRect tempFrame = [self frame];
	
	if([self frame].origin.y < mapRect.origin.y - 50) {
		tempFrame.origin.y = mapRect.origin.y - 50;
	}
	if([self frame].origin.x < mapRect.origin.x - 50) {
		tempFrame.origin.x = mapRect.origin.x - 50;
	}
	if([self frame].size.width < mapRect.size.width + 50) {
		tempFrame.size.width = mapRect.size.width + 50;
	}
	if([self frame].size.height < mapRect.size.height + 50) {
		tempFrame.size.height = mapRect.size.height + 50;
	}
	
	[self setFrame: tempFrame];	
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

-(BOOL)isFlipped {
	return YES;
}

- (void)changeColor:(id)sender {
	if(acceptColor) {
		[[[document ICs] objectAtIndex:fwdIndex] setColorState:[[NSColorPanel sharedColorPanel] color]];
		[self setNeedsDisplay:YES];
	}
}

@end
