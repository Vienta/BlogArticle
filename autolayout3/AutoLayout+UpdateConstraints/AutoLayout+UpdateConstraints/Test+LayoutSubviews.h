//
//  Test+LayoutSubviews.h
//  AutoLayout+UpdateConstraints
//
//  Created by Vienta on 15/5/18.
//  Copyright (c) 2015年 www.vienta.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Test_LayoutSubviews : UIView

@property (nonatomic, strong) UIView *subView;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *leadConstraint;
@property (nonatomic, strong) NSLayoutConstraint *trailConstraint;
@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;

@end
