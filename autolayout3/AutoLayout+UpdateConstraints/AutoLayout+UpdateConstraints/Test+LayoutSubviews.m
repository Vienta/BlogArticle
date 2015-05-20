//
//  Test+LayoutSubviews.m
//  AutoLayout+UpdateConstraints
//
//  Created by Vienta on 15/5/18.
//  Copyright (c) 2015年 www.vienta.me. All rights reserved.
//

#import "Test+LayoutSubviews.h"

@implementation Test_LayoutSubviews

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.subView = [[UIView alloc] init];
        [self addSubview:self.subView];
        self.subView.backgroundColor = [UIColor blueColor];
        
        self.subView.translatesAutoresizingMaskIntoConstraints = NO;
        //距离superView的顶部30像素 codeView的attributeTop约束等于superView的arttributeTop30像素
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_subView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:30];
        //距离superView的左边30
        NSLayoutConstraint *leadConstraint = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_subView.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
        //距离superView的右边50像素
        NSLayoutConstraint *trailConstraint = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_subView.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-50];
        //自身高度为100
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_subView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
        [self addConstraint:topConstraint];
        self.topConstraint = topConstraint;
        [self addConstraint:leadConstraint];
        self.leadConstraint = leadConstraint;
        [self addConstraint:trailConstraint];
        self.trailConstraint = trailConstraint;
        [self addConstraint:heightConstraint];
        self.bottomConstraint = heightConstraint;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"self:%@ method:%s", [self class], __PRETTY_FUNCTION__);
}

- (void)layoutIfNeeded
{
    [super layoutIfNeeded];
    NSLog(@"self:%@ method:%s", [self class], __PRETTY_FUNCTION__);
}

@end
