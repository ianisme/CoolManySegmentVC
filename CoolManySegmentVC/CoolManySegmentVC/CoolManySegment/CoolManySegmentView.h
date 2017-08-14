//
//  CoolManySegmentView.h
//  CoolManySegmentVC
//
//  Created by ian on 2017/8/14.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoolManySegmentView : UIView

@property (nonatomic, copy) void(^segmentButtonClick)(NSUInteger index);

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items itemSelectedIndex:(NSUInteger)itemSelectedIndex;

- (void)refreshSegmentButton:(NSUInteger)index;

@end
