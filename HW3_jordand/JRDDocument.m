//
//  JRDDocument.m
//  HW3_jordand
//
//  Created by Jordan Dobson on 7/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDDocument.h"
#import "JRDPersonProfile.h"

#pragma mark - PRIVATE METHODS & VARIABLES

@interface JRDPersonProfile ()
@property (weak) IBOutlet NSTextField *fullNameInput;
@property (weak) IBOutlet NSImageView *avatarInput;
@property (weak) IBOutlet NSTextField *emailInput;
@property (weak) IBOutlet NSTextField *addressInput;
@property (unsafe_unretained) IBOutlet NSTextView *notesInput;
- (IBAction)emailLink:(id)sender;
- (IBAction)bingLink :(id)sender;
- (IBAction)googleMap:(id)sender;
@end

@implementation JRDDocument

#pragma mark - Initializer

- (id)init
{
    NSLog(@"DOCUMENT INITIALIZED");
    self = [super init];
    if (self) {
        _profile = [JRDPersonProfile new];
        NSLog(@"%@", _profile);
    }
    return self;
}

#pragma mark - Window Management

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"JRDDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    NSLog(@"NIB WAS LOADED");
}

#pragma mark - Saving And Loading

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{

    NSLog(@"DATA WAS READ");
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

#pragma mark - Button Actions

- (IBAction)emailLink:(id)sender { }
- (IBAction)bingLink:(id)sender  { }
- (IBAction)googleMap:(id)sender { }
@end
