//
//  CoolManySegmentVCLayout.m
//  CoolManySegmentVC
//
//  Created by ian on 2017/8/14.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "CoolManySegmentVCLayout.h"

@implementation CoolManySegmentVCLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    if (self.collectionView.bounds.size.height) {
        self.itemSize = self.collectionView.bounds.size;
    }
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}


@end
