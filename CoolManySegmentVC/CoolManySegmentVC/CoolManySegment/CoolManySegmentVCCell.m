//
//  CoolManySegmentVCCell.m
//  CoolManySegmentVC
//
//  Created by ian on 2017/8/14.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "CoolManySegmentVCCell.h"

@interface CoolManySegmentVCCell()

@end

@implementation CoolManySegmentVCCell

- (void)addViewControllerToParentViewController:(UIViewController *)parentViewController
{
    [parentViewController addChildViewController:self.contentViewController];
    [self.contentViewController didMoveToParentViewController:parentViewController];
    [self.contentView addSubview:self.contentViewController.view];
}

- (void)removeViewControllerFromParentViewController
{
    [self.contentViewController.view removeFromSuperview];
    [self.contentViewController willMoveToParentViewController:nil];
    [self.contentViewController removeFromParentViewController];
}

@end
