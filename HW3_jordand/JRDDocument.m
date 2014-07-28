//
//  JRDDocument.m
//  HW3_jordand
//
//  Created by Jordan Dobson on 7/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDDocument.h"
#import "JRDPersonProfile.h"

#pragma mark - Constant Variables

NSString * const avatarArchiveKey  = @"avatarArchiveKey";
NSString * const nameArchiveKey    = @"nameArchiveKey";
NSString * const emailArchiveKey   = @"emailArchiveKey";
NSString * const addressArchiveKey = @"addressArchiveKey";
NSString * const notesArchiveKey   = @"notesArchiveKey";

NSString * const bingURL   = @"http://bing.com/maps/?v=2&where1=";
NSString * const googleURL = @"http://maps.google.com/maps/?q=";
NSString * const emailURL  = @"mailto:";

#pragma mark - PRIVATE METHODS & VARIABLES

@interface JRDDocument ()
@property (copy, nonatomic) JRDPersonProfile *profile;

@property (weak) IBOutlet NSImageView *avatarInput;
@property (weak) IBOutlet NSTextField *fullNameInput;
@property (weak) IBOutlet NSTextField *emailInput;
@property (weak) IBOutlet NSTextField *addressInput;

@property (unsafe_unretained) IBOutlet NSTextView *notesInput;

- (IBAction)emailLink:(id)sender;
- (IBAction)bingLink :(id)sender;
- (IBAction)googleMap:(id)sender;
@end

@implementation JRDDocument

#pragma mark - Initializer

- (id)init {
    NSLog(@"DOCUMENT INITIALIZED");
    self = [super init];
    if (self) {
        _profile = [JRDPersonProfile new];
    }
    return self;
}

#pragma mark - Window Management

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"JRDDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {

    [super windowControllerDidLoadNib:aController];

    self.docWindow.delegate     = self;

    self.fullNameInput.delegate = self;
    self.addressInput.delegate  = self;
    self.emailInput.delegate    = self;
    self.notesInput.delegate    = self;
//    self.avatarInput.delegate = self;
    [self setupUI];
    NSLog(@"NIB WAS LOADED");
}

-(void)windowWillClose:(NSNotification *)notification {
    NSLog(@"WINDOW WILL CLOSE");
    //self.theComment = [self.theTextView.string copy];
}

-(void)windowDidBecomeMain:(NSNotification *)aNotification {
    [self setupUI];
}

#pragma mark - Saving And Loading

+ (BOOL)autosavesInPlace { return YES; }

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {



    NSDictionary *values = @{
      nameArchiveKey    : self.profile.name,
      emailArchiveKey   : self.profile.email,
      addressArchiveKey : self.profile.address,
      notesArchiveKey   : self.profile.notes
    };

//    NSDictionary *values = @{
//                             nameArchiveKey    : _profile.name,
//                             emailArchiveKey   : _profile.email,
//                             addressArchiveKey : _profile.address,
//                             notesArchiveKey   : _profile.notes,
//                             avatarArchiveKey  : _profile.avatar
//                             };


    return [NSKeyedArchiver archivedDataWithRootObject: values];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {

    NSDictionary *values = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    _profile.name    = values[ nameArchiveKey    ];
    _profile.email   = values[ emailArchiveKey   ];
    _profile.address = values[ addressArchiveKey ];
    _profile.notes   = values[ notesArchiveKey   ];
    _profile.avatar  = values[ avatarArchiveKey  ];

    NSLog(@"READ PROFILE BELOW");
    NSLog(@"%@", self.profile);

    return YES;
}

-(BOOL)prepareSavePanel:(NSSavePanel *)savePanel {
    NSString *docName = [self scrub: _profile.name];
    if(docName.length > 0) {
        [savePanel setNameFieldStringValue: docName];
    }
    [savePanel setExtensionHidden:NO];
    return YES;
}

#pragma mark - UI Management

-(void)setupUI {
    _fullNameInput.stringValue = self.profile.name;
    _emailInput.stringValue    = self.profile.email;
    _addressInput.stringValue  = self.profile.address;

    if(![_profile.notes isEqualToString: @""]) {
        _notesInput.string = self.profile.notes;
    }

    if(_profile.avatar != nil){
        _avatarInput.image = self.profile.avatar;
    }
}

#pragma mark - Update Person Model Methods

-(void)updatePersonModelFromTextChange:(NSTextField *)field {
    if (field == self.fullNameInput){
        _profile.name = [self.fullNameInput.stringValue copy];
    }else if (field == self.emailInput){
        _profile.email = [self.emailInput.stringValue copy];
    }else if (field == self.addressInput){
        _profile.address = [self.addressInput.stringValue copy];
    }
}

-(void)updatePersonModelFromNotesChange { _profile.notes = [self.notesInput.string copy]; }

-(void)updatePersonModelFromImageChange {
//_profile.avatar = [self.notesInput.string copy];
    NSLog(@"IMAGE UPDATED PERSON MODEL");
}

#pragma mark - Button Actions

- (IBAction)emailLink:(id)sender { [self openLinkAtURL: emailURL  withContent: self.profile.email  ]; }
- (IBAction)bingLink: (id)sender { [self openLinkAtURL: bingURL   withContent: self.profile.address]; }
- (IBAction)googleMap:(id)sender { [self openLinkAtURL: googleURL withContent: self.profile.address]; }

#pragma mark - External Link Method

-(void)openLinkAtURL:(NSString *)urlPrefix withContent:(NSString *)content{
    if (content.length > 0){
        NSString *loc = [urlPrefix stringByAppendingString: [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURL *url = [NSURL URLWithString: [loc stringByReplacingOccurrencesOfString: @"%0A" withString: @",%20"]];
        [[NSWorkspace sharedWorkspace] openURL: url];
    }
}

#pragma mark - Field Delegates

-(void)image:(NSImage *)image didLoadRepresentation:(NSImageRep *)rep withStatus:(NSImageLoadStatus)status{
    // This is For Image
    NSLog(@"Image Changed");
}

-(void)controlTextDidChange:(NSNotification *)aNotification {
    [self updatePersonModelFromTextChange: [aNotification object]];
}

-(void)textDidChange:(NSNotification *)aNotification {
    [self updatePersonModelFromNotesChange];
}

-(BOOL)control:(NSControl *)control textView:(NSTextField *)fieldEditor doCommandBySelector:(SEL)commandSelector{
    BOOL retval = NO;
    if (commandSelector == @selector(insertNewline:)) {
        if (control == self.addressInput){
            [fieldEditor insertNewlineIgnoringFieldEditor: self];
            retval = YES;
        }
    }
    return retval;
    // This will detect what the selector is
    //NSLog(@"Selector = %@", NSStringFromSelector(commandSelector));
}

#pragma mark - HELPER METHODS

-(NSString*)scrub:(NSString*)string {
    // I'm not sure if this is appropriate for this model
    // Removes whitespace at the beginning and end of a string
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
@end
