//
//  JRDTextView.m
//  HW3_jordand
//
//  Created by Jordan Dobson on 7/30/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDTextView.h"

static NSAttributedString *placeHolderString;

@implementation JRDTextView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

// Some Implementation from: http://lists.apple.com/archives/cocoa-dev/2005/Apr/msg00546.html

+(void)initialize {
    static BOOL initialized = NO;
    if (!initialized) {
        NSColor *txtColor = [NSColor grayColor];
        NSFont *txtFont = [NSFont fontWithName: @"Avenir Next Regular" size:14.0];
        NSDictionary *txtDict = [NSDictionary dictionaryWithObjectsAndKeys:txtColor, NSForegroundColorAttributeName, txtFont, NSFontAttributeName,  nil];
//        NSDictionary *txtDict = [NSDictionary dictionaryWithObjectsAndKeys:txtColor, NSForegroundColorAttributeName,  nil];
        placeHolderString = [[NSAttributedString alloc] initWithString:@"  Notes" attributes:txtDict];
    }
}

//- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//}

- (void)drawRect:(NSRect)rect {
    [super drawRect:rect];

    if ([[self string] isEqualToString:@""] && self != [[self window] firstResponder]){
        [placeHolderString drawAtPoint:NSMakePoint(0,0)];
    }

//    if ([[self string] isEqualToString:@"  Notes"] && self != [[self window] firstResponder])
//        [placeHolderString drawAtPoint:NSMakePoint(0,0)];
}

- (BOOL)becomeFirstResponder {
    NSLog(@"hello");
    [self setNeedsDisplay:YES];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    NSLog(@"goodbye");
    [self setNeedsDisplay:YES];
    return [super resignFirstResponder];
}

@end



