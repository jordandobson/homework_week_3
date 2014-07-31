//
//  JRDTextView.h
//  HW3_jordand
//
//  Created by Jordan Dobson on 7/30/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class JRDTextView;

@protocol JRDTextViewDelegate <NSTextViewDelegate>
-(void)controlDidBecomeFirstResponder;
@end

@interface JRDTextView : NSTextView
@property (weak) id<JRDTextViewDelegate> delegate;
@end
