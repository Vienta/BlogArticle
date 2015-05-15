//
//  ViewController.m
//  AutoLayoutDemo
//
//  Created by Vienta on 14/12/7.
//  Copyright (c) 2014年 www.vienta.me. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.demoViewWidthConstraint.constant = 300;
    
    //构造一个orangeColor的view
    UIView *codeView = [[UIView alloc] init];
    [self.view addSubview:codeView];
    codeView.backgroundColor = [UIColor orangeColor];
    
    codeView.translatesAutoresizingMaskIntoConstraints = NO;//防止与autosize冲突，一定要写，否则不能正常进行
    
    /*
    //距离superView的顶部30像素 codeView的attributeTop约束等于superView的arttributeTop30像素
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:codeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:codeView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:30];
    //距离superView的左边30
    NSLayoutConstraint *leadConstraint = [NSLayoutConstraint constraintWithItem:codeView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:codeView.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
    //距离superView的右边50像素
    NSLayoutConstraint *trailConstraint = [NSLayoutConstraint constraintWithItem:codeView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:codeView.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-50];
    //自身高度为40
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:codeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    [self.view addConstraint:topConstraint];
    [self.view addConstraint:leadConstraint];
    [self.view addConstraint:trailConstraint];
    [self.view addConstraint:heightConstraint];
    */

    //绑定需要约束的view 这里只有一个
    NSDictionary *bindingDict = NSDictionaryOfVariableBindings(codeView);
    
    //水平方向
    NSString *HorizitalVFL = @"H:|-30-[codeView]-50-|";
    NSArray *HorizitalArr = [NSLayoutConstraint constraintsWithVisualFormat:HorizitalVFL options:0 metrics:nil views:bindingDict];
    [self.view addConstraints:HorizitalArr];
    
    //垂直方向
    NSString *VerticalVFL = @"V:|-30-[codeView(==40)]";
    NSArray *VerticalArr = [NSLayoutConstraint constraintsWithVisualFormat:VerticalVFL options:0 metrics:nil views:bindingDict];
    [self.view addConstraints:VerticalArr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
