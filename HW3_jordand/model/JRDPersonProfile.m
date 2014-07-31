//
//  JRDPersonProfile.m
//  HW3_jordand
//
//  Created by Jordan Dobson on 7/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDPersonProfile.h"

NSString * const avatarKey  = @"avatarKey";
NSString * const nameKey    = @"nameKey";
NSString * const emailKey   = @"emailKey";
NSString * const addressKey = @"addressKey";
NSString * const notesKey   = @"notesKey";

@implementation JRDPersonProfile

-(id) init {
    self = [super init];
    if(self) {
        _name    = @"";
        _email   = @"";
        _address = @"";
        _notes   = @"";
    }
    return self;
}

#pragma mark - Encode & Decode

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject: self.name    forKey: nameKey    ];
    [aCoder encodeObject: self.avatar  forKey: avatarKey  ];
    [aCoder encodeObject: self.email   forKey: emailKey   ];
    [aCoder encodeObject: self.address forKey: addressKey ];
    [aCoder encodeObject: self.notes   forKey: notesKey   ];
    NSLog(@"ENCODED");
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        _avatar  = [aDecoder decodeObjectForKey:  avatarKey  ];
        _name    = [aDecoder decodeObjectForKey:  nameKey    ];
        _email   = [aDecoder decodeObjectForKey:  emailKey   ];
        _address = [aDecoder decodeObjectForKey:  addressKey ];
        _notes   = [aDecoder decodeObjectForKey:  notesKey   ];
        NSLog(@"DECODED");
    }
    return self;
}

#pragma mark - Override Description

-(NSString *)description {
    NSMutableString *string = [[NSMutableString alloc] initWithString: @"<JRDPersonProfile: "];
    [string appendFormat: @"NAME: %@ \n  EMAIL: %@ \n  ADDRESS: %@ \n  NOTES: %@ \n  AVATAR: %@ />", self.name, self.email, self.address, self.notes, self.avatar];
    return string;
}

@end
