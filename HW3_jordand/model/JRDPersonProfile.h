//
//  JRDPersonProfile.h
//  HW3_jordand
//
//  Created by Jordan Dobson on 7/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRDPersonProfile : NSObject <NSCoding>
    @property (copy, nonatomic) NSString *name;
    @property (copy, nonatomic) NSString *email;
    @property (copy, nonatomic) NSString *address;
    @property (copy, nonatomic) NSImage  *avatar;
    @property (copy, nonatomic) NSString *notes;
@end
