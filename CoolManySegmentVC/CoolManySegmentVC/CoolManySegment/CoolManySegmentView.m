//
//  CoolManySegmentView.m
//  CoolManySegmentVC
//
//  Created by ian on 2017/8/14.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "CoolManySegmentView.h"

@interface CoolManySegmentView()

@property (nonatomic, strong) NSArray *items;

@property (nonatomic) NSUInteger itemSelectedIndex;

@property (nonatomic, strong) UIView *animateLineView;

@end

@implementation CoolManySegmentView


#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items itemSelectedIndex:(NSUInteger)itemSelectedIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        _items = items;
        _itemSelectedIndex = itemSelectedIndex;
        [self creatView];
    }
    return self;
}


#pragma mark - private method

- (void)creatView
{
    self.backgroundColor = [UIColor whiteColor];
    
    for (NSUInteger i = 0; i < _items.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        button.frame = CGRectMake(i * (self.bounds.size.width/_items.count), 0, self.bounds.size.width/_items.count, self.bounds.size.height);
        [button setTitle:_items[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        button.tag = 6666 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.frame = CGRectMake(0, self.bounds.size.height - 0.5f, self.bounds.size.width, 0.5f);
    
    NSString *titleStr = _items[_itemSelectedIndex];
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.f ]};
    CGRect infoRect = [titleStr boundingRectWithSize:CGSizeMake(self.bounds.size.width/_items.count, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    _animateLineView = [[UIView alloc] init];
    [self addSubview:_animateLineView];
    _animateLineView.frame = CGRectMake(_itemSelectedIndex * (self.bounds.size.width/_items.count) + (self.bounds.size.width/_items.count)/2.0f - infoRect.size.width/2.0f, self.bounds.size.height - 2.5, infoRect.size.width, 2.0f);
    _animateLineView.backgroundColor = [UIColor redColor];
    
    [self refreshSegmentButton:_itemSelectedIndex];
}

- (void)refreshSegmentButton:(NSUInteger)index
{
    NSString *titleStr = _items[index];
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.f ]};
    CGRect infoRect = [titleStr boundingRectWithSize:CGSizeMake(self.bounds.size.width/_items.count, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    [UIView animateWithDuration:0.3f animations:^{
        _animateLineView.frame = CGRectMake(index * (self.bounds.size.width/_items.count) + (self.bounds.size.width/_items.count)/2.0f - infoRect.size.width/2.0f, self.bounds.size.height - 2.5, infoRect.size.width, 2.0f);
    }];
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subView;
            if (button.tag - 6666 == index) {
                button.selected = YES;
            } else {
                button.selected = NO;
            }
        }
    }
}

#pragma mark - action method

- (void)buttonClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSUInteger index = btn.tag - 6666;

    [self refreshSegmentButton:index];
    
    if (self.segmentButtonClick) {
        self.segmentButtonClick(index);
    }
}

@end
