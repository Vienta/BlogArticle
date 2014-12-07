//
//  ViewController.h
//  AutoLayoutDemo
//
//  Created by Vienta on 14/12/7.
//  Copyright (c) 2014年 www.vienta.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *demoView;
@property (weak, nonatomic) IBOutlet UIView *libView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *demoViewWidthConstraint;

@end

