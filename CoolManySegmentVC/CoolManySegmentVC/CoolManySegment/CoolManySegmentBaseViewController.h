//
//  CoolManySegmentBaseViewController.h
//  CoolManySegmentVC
//
//  Created by ian on 2017/8/14.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoolManySegmentBaseViewController : UIViewController

- (void)configTitles:(NSArray *)titles controllers:(NSArray *)controllers;

- (void)configSelectedVC:(NSUInteger)index;

@end
