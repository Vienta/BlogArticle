//
//  ViewController.m
//  AutoLayout+UpdateConstraints
//
//  Created by Vienta on 15/5/18.
//  Copyright (c) 2015年 www.vienta.me. All rights reserved.
//

#import "ViewController.h"
#import "Test+LayoutSubviews.h"

@interface ViewController ()
{
    Test_LayoutSubviews *testLayoutSubView;
}

@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *leadConstraint;
@property (nonatomic, strong) NSLayoutConstraint *trailConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(addTestLayoutSubView) withObject:nil afterDelay:4];
    

    
}

- (void)addTestLayoutSubView
{
    testLayoutSubView = [[Test_LayoutSubviews alloc] init];
    testLayoutSubView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:testLayoutSubView];
    
    testLayoutSubView.translatesAutoresizingMaskIntoConstraints = NO;

    //距离superView的顶部30像素 codeView的attributeTop约束等于superView的arttributeTop30像素
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:testLayoutSubView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:testLayoutSubView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:30];
    //距离superView的左边30
    NSLayoutConstraint *leadConstraint = [NSLayoutConstraint constraintWithItem:testLayoutSubView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:testLayoutSubView.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
    //距离superView的右边50像素
    NSLayoutConstraint *trailConstraint = [NSLayoutConstraint constraintWithItem:testLayoutSubView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:testLayoutSubView.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-50];
    //自身高度为100
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:testLayoutSubView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100];
    [self.view addConstraint:topConstraint];
    self.topConstraint = topConstraint;
    [self.view addConstraint:leadConstraint];
    self.leadConstraint = leadConstraint;
    [self.view addConstraint:trailConstraint];
    self.trailConstraint = trailConstraint;
    [self.view addConstraint:heightConstraint];
    self.heightConstraint = heightConstraint;
    
    [self performSelector:@selector(testSetNeedsUpdateConstraints) withObject:nil afterDelay:3];
//    [NSTimer scheduledTimerWithTimeInterval:4 target:testLayoutSubView selector:@selector(setNeedsLayout) userInfo:nil repeats:YES];
}

- (void)testSetNeedsUpdateConstraints
{
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
//    testLayoutSubView.bottomConstraint.constant = 50;
//    testLayoutSubView.leadConstraint.constant = 5;
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)updateLayoutIfNeeded:(Test_LayoutSubviews *)testLayoutSubView
{
    [testLayoutSubView setNeedsLayout];
//    [testLayoutSubView layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
