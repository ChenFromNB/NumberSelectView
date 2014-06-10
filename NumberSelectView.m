//
//  NumberSelectView.m
//  Example
//
//  Created by llwang on 13-11-18.
//  Copyright (c) 2013年 Toursprung. All rights reserved.
//

#import "NumberSelectView.h"

@interface NumberSelectView()

@property (nonatomic, strong) UILabel* numberLabel;
@property (nonatomic, strong) UIButton* cutButton;
@property (nonatomic, strong) UIButton* addButton;

@end

@implementation NumberSelectView


-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup:self.frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame defaultNumber:(NSInteger)defaultNumber minNumber:(NSInteger)minNumber
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentNumber = defaultNumber;
        _minNumber = minNumber;
        [self setup:frame];
        _numberLabel.text = [NSString stringWithFormat:@"%d",_currentNumber];
    }
    return self;
}

-(void)setup:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    
    _cutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cutButton.frame = CGRectMake(0, 0, frame.size.width/2 - 15, frame.size.height);
    _cutButton.layer.cornerRadius = 5;
    _cutButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [_cutButton setTitle:@"-" forState:UIControlStateNormal];
    [_cutButton setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor] cornerRadius:5] forState:UIControlStateNormal];
    [_cutButton addTarget:self action:@selector(cutNumber:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cutButton];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2 - 15, 0, 30, frame.size.height)];
    _numberLabel.backgroundColor = [UIColor clearColor];

    _numberLabel.font = [UIFont systemFontOfSize:14];
    _numberLabel.textColor = [UIColor darkGrayColor];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.text = @"0";
    [self addSubview:_numberLabel];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(frame.size.width/2 + 15, 0, frame.size.width/2 - 15, frame.size.height);
    _addButton.layer.cornerRadius = 5;
    _addButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [_addButton setTitle:@"+" forState:UIControlStateNormal];
    [_addButton setBackgroundImage:[UIImage imageWithColor:COLOR_THEME cornerRadius:5] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addNumber:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
}

-(void)setMinNumber:(NSInteger)minNumber
{
    _minNumber = minNumber;
    [_cutButton setEnabled:_currentNumber>_minNumber];
}

-(void)setMaxNumber:(NSInteger)maxNumber
{
    _maxNumber = maxNumber;
    [_cutButton setEnabled:_currentNumber < _maxNumber];
}

-(void)setCurrentNumber:(NSInteger)currentNumber
{
    _currentNumber = currentNumber;
    [_cutButton setEnabled:_currentNumber>_minNumber];
    _numberLabel.text = [NSString stringWithFormat:@"%d",_currentNumber];
}

- (void)addNumber:(id)sender
{
    _currentNumber++;
    _numberLabel.text = [NSString stringWithFormat:@"%d",_currentNumber];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(numberSelectView:actionStyle:currentNumber:)]) {
        [_delegate numberSelectView:self actionStyle:NumberSelectViewActionAdd currentNumber:_currentNumber];
    }
    _cutButton.enabled = _currentNumber > _minNumber;
    _addButton.enabled = _currentNumber > _maxNumber;
}

- (void)cutNumber:(id)sender
{
    _currentNumber--;
    _numberLabel.text = [NSString stringWithFormat:@"%d",_currentNumber];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(numberSelectView:actionStyle:currentNumber:)]) {
        [_delegate numberSelectView:self actionStyle:NumberSelectViewActionCut currentNumber:_currentNumber];
    }
    _cutButton.enabled = _currentNumber > _minNumber;
    _addButton.enabled = _currentNumber > _maxNumber;

}

@end
