//
//  MyDocument.m
//  Robo
//


#import "MyDocument.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
		//init van de arrays
		ConnectionsArray = [[NSMutableArray alloc] init];
		ICSArray = [[NSMutableArray alloc] init];
		
		voltage* newVoltage = [[voltage alloc] initAtPosition:NSMakePoint(20,20)];
		[ICSArray addObject:newVoltage];	
		
		/* SN7490* newSN7490 = [[SN7490 alloc] initAtPosition:NSMakePoint(270, 300)];
		[ICSArray addObject:newSN7490];	
		
		D_5082_7651* display = [[D_5082_7651 alloc] initAtPosition:NSMakePoint(120, 250)];
		[ICSArray addObject:display];
		
		pulsenGenerator* newPulse = [[pulsenGenerator alloc] initAtPosition:NSMakePoint(20,250) document:self];
		[ICSArray addObject:newPulse];
		
		invertor* newInvertor = [[invertor alloc] initAtPosition:NSMakePoint(20,60)];
		[ICSArray addObject:newInvertor];
		
		SN7400* newSN7400 = [[SN7400 alloc] initAtPosition:NSMakePoint(20, 120)];
		[ICSArray addObject:newSN7400];
		
		SN74247* newSN74247 = [[SN74247 alloc] initAtPosition:NSMakePoint(290, 120)];
		[ICSArray addObject:newSN74247];
		
		OR* newOR = [[OR alloc] initAtPosition:NSMakePoint(120, 20)];
		[ICSArray addObject:newOR];
		
		EN* newEN = [[EN alloc] initAtPosition:NSMakePoint(240, 20)];
		[ICSArray addObject:newEN];
		
		NEN* newNEN = [[NEN alloc] initAtPosition:NSMakePoint(360, 20)];
		[ICSArray addObject:newNEN];
		
		XOR* newXOR = [[XOR alloc] initAtPosition:NSMakePoint(480, 20)];
		[ICSArray addObject:newXOR]; */
		
		
		//connection* newConnection = [[connection alloc] init];
		//[connection setInput: ];
		//[connection setOutput: ];
		
        // If an error occurs here, send a [self release] message and return nil.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	
	NSMutableArray* arrayToSave = [[NSMutableArray alloc] init];
	[arrayToSave addObject:ICSArray];
	[arrayToSave addObject:ConnectionsArray];
	
	return [NSKeyedArchiver archivedDataWithRootObject:arrayToSave];
	
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	
	NSMutableArray *tempArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    ICSArray = [tempArray objectAtIndex:0];
	ConnectionsArray = [tempArray objectAtIndex:1];
    return YES;
	
}

- (NSArray*)ICs {
	NSArray* ICs = [NSArray arrayWithArray:ICSArray];
	return ICs;
}

- (NSArray*)connections {
	NSArray* connections = [NSArray arrayWithArray:ConnectionsArray];
	return connections;
}

-(void)updateAllPorts {
	//alle connecties updaten
	BOOL changes = FALSE;
	
	for(connection* connectionInLoop in ConnectionsArray) {
		if([[connectionInLoop output] high]) {
			if(![[connectionInLoop input] high]) {
			[[connectionInLoop input] setHigh:TRUE]; 
				[[[connectionInLoop input] ofObject] updateAllPorts];
				changes = TRUE;
			}
		}
		else {
			if([[connectionInLoop input] high]) {
			[[connectionInLoop input] setHigh:FALSE]; 
				changes = TRUE;
			}
		}
	}
	
	for(id ICInLoop in ICSArray) {
		[ICInLoop updateAllPorts];
	}
	
	if(changes) {
		[self updateAllPorts];	
	}
	[view setNeedsDisplay:TRUE]; 
}

-(void)addObjectToConnections:(id)theObject {
	[ConnectionsArray addObject:theObject];
}

-(void)addObjectToICArray:(id)theObject {
	[ICSArray addObject:theObject];
}

-(void)removeConnection:(connection*)theObject {
	[[theObject input] setHigh:NO];
	[ConnectionsArray removeObject:theObject];
}

-(void)removeIC:(id)theObject {
	[ICSArray removeObject:theObject];
	NSArray* connCopy = [NSArray arrayWithArray:ConnectionsArray];
	for(connection* conn in connCopy) {
		if([[[conn input] ofObject] isEqual:theObject] || [[[conn output] ofObject] isEqual:theObject]) {
			[self removeConnection:conn];
		}
	}
}

-(void)setActiveView {
	[view orderFront];
}

-(void)connectIC:(id)firstIC to:(id)secondIC {
	//heeft betere implementatie nodig.
	if(![firstIC isEqual:secondIC]) {
	BOOL exists;
	for(port* output in [firstIC ports]) {
		if(![output input]) {
			for(port* input in [secondIC ports]) {
				exists = FALSE;
				if([[output label] isEqual:[input label]] && ![[output label] isEqual:@""]) {
					for(connection* connTest in ConnectionsArray) {
						if([[connTest input] isEqual:input] && [[connTest output] isEqual:output]) {
							exists = TRUE;
						}
					}
					if(!exists) {
					connection* conn = [[connection alloc] initWithOutput:output];
					[conn closeWithInput:input];
					[ConnectionsArray addObject:conn];
					}
				}
			}
		}
	}
	}
}


@end
