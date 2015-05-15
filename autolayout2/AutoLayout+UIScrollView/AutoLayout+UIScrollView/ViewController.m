//
//  ViewController.m
//  AutoLayout+UIScrollView
//
//  Created by Vienta on 15/5/14.
//  Copyright (c) 2015年 www.vienta.me. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentSizeWidth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.contentSizeWidth.constant = self.view.bounds.size.width * 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
