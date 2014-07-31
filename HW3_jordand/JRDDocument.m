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

//NSString * const avatarArchiveKey  = @"avatarArchiveKey";
//NSString * const nameArchiveKey    = @"nameArchiveKey";
//NSString * const emailArchiveKey   = @"emailArchiveKey";
//NSString * const addressArchiveKey = @"addressArchiveKey";
//NSString * const notesArchiveKey   = @"notesArchiveKey";

NSString * const profileKey = @"profileKey";
NSString * const bingURL    = @"http://bing.com/maps/?v=2&where1=";
NSString * const googleURL  = @"http://maps.google.com/maps/?q=";
NSString * const emailURL   = @"mailto:";

#pragma mark - PRIVATE METHODS & VARIABLES

@interface JRDDocument ()
    @property (copy, nonatomic) JRDPersonProfile *profile;

    @property (weak) IBOutlet NSImageView *avatarInput;
    @property (weak) IBOutlet NSTextField *fullNameInput;
    @property (weak) IBOutlet NSTextField *emailInput;
    @property (weak) IBOutlet NSTextField *addressInput;

    @property (unsafe_unretained) IBOutlet NSTextView *notesInput;

    //@property (unsafe_unretained) IBOutlet JRDTextView *notesInput;

    - (IBAction)emailLink:(id)sender;
    - (IBAction)bingLink :(id)sender;
    - (IBAction)googleMap:(id)sender;
    - (IBAction)imgUpdate:(id)sender;
@end

@implementation JRDDocument

#pragma mark - Initializer

- (id)init {
    NSLog(@"DOCUMENT INITIALIZED");
    self = [super init];
    if (self) {
        _profile = [JRDPersonProfile new];

        // self.profile = [JRDPersonProfile new];
        // Using This Code Gave me this Error Below
        // DOCUMENT INITIALIZED
        // INITIALIZED PERSON PROFILE
        // -[JRDPersonProfile copyWithZone:]: unrecognized selector sent to instance 0x6180000532c0
        // -[JRDPersonProfile copyWithZone:]: unrecognized selector sent to instance 0x6180000532c0
    }
    return self;
}

#pragma mark - Window Management

- (NSString *)windowNibName { return @"JRDDocument"; }

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    self.docWindow.delegate     = self;
    self.fullNameInput.delegate = self;
    self.addressInput.delegate  = self;
    self.emailInput.delegate    = self;
    self.notesInput.delegate    = self;

    [self setupUI];
    [self.notesInput setFont: [NSFont fontWithName:@"Avenir Next Regular" size:14.0] ];

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

//    NSDictionary *values;
//    if(self.profile.avatar){
//        values = @{
//            nameArchiveKey    : self.profile.name,
//            emailArchiveKey   : self.profile.email,
//            addressArchiveKey : self.profile.address,
//            notesArchiveKey   : self.profile.notes,
//            avatarArchiveKey  : self.profile.avatar
//        };
//    }else{
//        values = @{
//            nameArchiveKey    : self.profile.name,
//            emailArchiveKey   : self.profile.email,
//            addressArchiveKey : self.profile.address,
//            notesArchiveKey   : self.profile.notes
//        };
//    }
//    return [NSKeyedArchiver archivedDataWithRootObject: values];
//
//    NSDictionary *values = @{
//                             nameArchiveKey    : _profile.name,
//                             emailArchiveKey   : _profile.email,
//                             addressArchiveKey : _profile.address,
//                             notesArchiveKey   : _profile.notes,
//                             avatarArchiveKey  : _profile.avatar
//                             };
    return [NSKeyedArchiver archivedDataWithRootObject: self.profile];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
//    NSDictionary *values = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//
//    self.profile.name    = values[ nameArchiveKey    ];
//    self.profile.email   = values[ emailArchiveKey   ];
//    self.profile.address = values[ addressArchiveKey ];
//    self.profile.notes   = values[ notesArchiveKey   ];
//    self.profile.avatar  = values[ avatarArchiveKey  ];
//
//    NSLog(@"READ PROFILE BELOW");

//    if(!!self.profile){
//    return YES;
//    }
//    *outError = [NSError errorWithDomain:@"Bad Data" code: 666 userInfo:nil];
//    return NO;

    NSLog(@"PROFILE DATA READ");
    JRDPersonProfile * profile = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _profile = profile;
    return YES;

    // self.profile = profile;
    // Using This Code Gave me this Error Below
    // DOCUMENT INITIALIZED
    // INITIALIZED PERSON PROFILE
    // -[JRDPersonProfile copyWithZone:]: unrecognized selector sent to instance 0x6180000532c0
    // -[JRDPersonProfile copyWithZone:]: unrecognized selector sent to instance 0x6180000532c0
}

-(BOOL)prepareSavePanel:(NSSavePanel *)savePanel {
    NSString *docName = [self scrub: self.profile.name];
    if(docName.length > 0) {
        [savePanel setNameFieldStringValue: docName];
    }
    [savePanel setExtensionHidden:NO];
    return YES;
}

#pragma mark - UI Management

-(void)setupUI {
    self.fullNameInput.stringValue = self.profile.name;
    self.emailInput.stringValue    = self.profile.email;
    self.addressInput.stringValue  = self.profile.address;
    if(![self.profile.notes isEqualToString: @""]) {
        self.notesInput.string = self.profile.notes;
    }
    if(self.profile.avatar){
        self.avatarInput.image = self.profile.avatar;
    }
}

#pragma mark - Update Person Model Methods

// I could probably just update all of these. I wasn't sure if I needed more or not.

-(void)updatePersonModelFromTextChange:(NSTextField *)field {
    if (field == self.fullNameInput){
        self.profile.name = [self.fullNameInput.stringValue copy];
    }else if (field == self.emailInput){
        self.profile.email = [self.emailInput.stringValue copy];
    }else if (field == self.addressInput){
        self.profile.address = [self.addressInput.stringValue copy];
    }
    NSLog(@"A TEXT FIELD UPDATED PERSON MODEL");
}

-(void)updatePersonModelFromNotesChange {
    self.profile.notes = [self.notesInput.string copy];
    NSLog(@"NOTES UPDATED PERSON MODEL");
}

-(void)updatePersonModelFromImageChange {
    if(self.avatarInput.image){
        self.profile.avatar = self.avatarInput.image;
        NSLog(@"IMAGE UPDATED PERSON MODEL");
    }
}

#pragma mark - Button & Image Actions

- (IBAction)emailLink:(id)sender { [self openLinkAtURL: emailURL  withContent: self.profile.email  ]; }
- (IBAction)bingLink: (id)sender { [self openLinkAtURL: bingURL   withContent: self.profile.address]; }
- (IBAction)googleMap:(id)sender { [self openLinkAtURL: googleURL withContent: self.profile.address]; }
- (IBAction)imgUpdate:(id)sender { [self updatePersonModelFromImageChange]; }

#pragma mark - External Link Method

-(void)openLinkAtURL:(NSString *)urlPrefix withContent:(NSString *)content{
    if (content.length > 0){
        NSString *loc = [urlPrefix stringByAppendingString: [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURL *url = [NSURL URLWithString: [loc stringByReplacingOccurrencesOfString: @"%0A" withString: @"%20"]];
        [[NSWorkspace sharedWorkspace] openURL: url];
    }
}

#pragma mark - Text Field Delegates

-(void)controlTextDidChange:(NSNotification *)aNotification {
    [self updatePersonModelFromTextChange: [aNotification object]];
    NSLog(@"Text Changed");
}

-(void)textDidChange:(NSNotification *)aNotification {
    [self updatePersonModelFromNotesChange];
    NSLog(@"Notes Changed");
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

//- (void)textDidEndEditing:(NSNotification *)aNotification{
//    NSLog(@"DID END EDITING");
//}

//-(void)controlDidBecomeFirstResponder {
//    if([self.notesInput.string isEqualToString: @" Notes"]){
//        self.notesInput.string = @"";
//    }
//    NSLog(@"NOTES FOCUSED");
//}

//-(void)controlDidResignFirstResponder {
//    NSLog(@"NOTES UNFOCUSED");
//}

//-(void)textDidEndEditing:(NSNotification *)notification{
//    [self updatePersonModelFromNotesChange];
//    if([self.notesInput.string isEqualToString: @""]){
//        self.notesInput.string = @" Notes";
//    }
//    NSLog(@"Notes End Editing");
//}

#pragma mark - HELPER METHODS

-(NSString*)scrub:(NSString*)string {
    // Removes whitespace at the beginning and end of a string
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
