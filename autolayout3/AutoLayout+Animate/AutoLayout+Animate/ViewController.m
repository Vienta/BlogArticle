//
//  ViewController.m
//  AutoLayout+Animate
//
//  Created by Vienta on 15/5/19.
//  Copyright (c) 2015年 www.vienta.me. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController
{
    UIView *masView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self masonryLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnTapped:(id)sender {
    self.leftConstraint.constant = 200;
    
    [UIView animateWithDuration:2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)masBtnTapped:(id)sender
{
    [masView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.offset(100);
        make.leading.equalTo(self.view).offset(100);
    }];

    [UIView animateWithDuration:3 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSLog(@"masView:%@", masView);//注意最终的frame的变化
    }];
}

- (void)masonryLayout
{
    masView = [UIView new];
    masView.backgroundColor = [UIColor redColor];
    [self.view addSubview:masView];
    [masView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.leading.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(200);
        make.width.offset(80);
        make.height.offset(80);
    }];
}

@end
