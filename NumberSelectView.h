//
//  NumberSelectView.h
//  Example
//
//  Created by llwang on 13-11-18.
//  Copyright (c) 2013年 Toursprung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NumberSelectViewActionStyle) {
    NumberSelectViewActionCut,
    NumberSelectViewActionAdd
};

@class NumberSelectView;

@protocol NumberSelectViewDelegate <NSObject>

-(void)numberSelectView:(NumberSelectView*)numberSelectView actionStyle:(NumberSelectViewActionStyle)style currentNumber:(NSInteger)currentNumber;

@end

@interface NumberSelectView : UIView

@property (nonatomic, assign) NSInteger minNumber;
@property (nonatomic, assign) NSInteger currentNumber;
@property (nonatomic, assign) NSInteger maxNumber;

@property (nonatomic, assign) id<NumberSelectViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame defaultNumber:(NSInteger)defaultNumber minNumber:(NSInteger)minNumber;

@end
