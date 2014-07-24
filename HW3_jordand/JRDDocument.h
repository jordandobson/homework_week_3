//
//  JRDDocument.h
//  HW3_jordand
//
//  Created by Jordan Dobson on 7/23/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JRDPersonProfile.h"

@interface JRDDocument : NSDocument <NSWindowDelegate>

@property (copy, nonatomic) JRDPersonProfile *profile;



@end
