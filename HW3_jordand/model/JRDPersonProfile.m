//
//  JRDPersonProfile.m
//  HW3_jordand
//
//  Created by Jordan Dobson on 7/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDPersonProfile.h"

NSString * const profileKey  = @"profileKey";

//NSString * const avatarKey  = @"avatarKey";
//NSString * const nameKey    = @"nameKey";
//NSString * const emailKey   = @"emailKey";
//NSString * const addressKey = @"addressKey";
//NSString * const notesKey   = @"notesKey";

@implementation JRDPersonProfile

-(id) init {
    if(self = [super init]) {
        _avatar  = nil;
        _name    = @"";
        _email   = @"";
        _address = @"";
        _notes   = @"";
    }
    NSLog(@"INITIALIZED PERSON PROFILE");
    return self;
}

#pragma mark - Encode & Decode

-(void)encodeWithCoder:(NSCoder *)aCoder {
    NSLog(@"ENCODED");
    [aCoder encodeObject: self forKey: profileKey ];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"DECODED");
    self = [super init];
    JRDPersonProfile *profile = [aDecoder decodeObjectForKey:  profileKey ];
    _avatar  = profile.avatar;
    _name    = profile.name;
    _email   = profile.email;
    _address = profile.address;
    _notes   = profile.notes;
    return self;
}

#pragma mark - Override Description

-(NSString *)description {
    NSMutableString *string = [[NSMutableString alloc] initWithString: @"<JRDPersonProfile: "];
    [string appendFormat: @"%@ \n  EMAIL: %@ \n  ADDRESS: %@ \n  NOTES: %@ \n  AVATAR: %@ />", self.name, self.email, self.address, self.notes, self.avatar];
    return string;
}

@end
