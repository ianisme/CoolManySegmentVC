//
//  CoolManySegmentBaseViewController.m
//  CoolManySegmentVC
//
//  Created by ian on 2017/8/14.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "CoolManySegmentBaseViewController.h"
#import "CoolManySegmentView.h"
#import "CoolManySegmentVCCell.h"
#import "CoolManySegmentVCLayout.h"

static NSString * const ReuseIdentifier = @"CoolManySegmentBaseCellReuseIdentifier";

@interface CoolManySegmentBaseViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionView *contentScrollView;

@property (nonatomic, weak) CoolManySegmentView *segmentView;

@property (nonatomic, assign) BOOL isInitial;

@property (nonatomic, assign) BOOL isOneDisplay;

@property (nonatomic, strong) NSMutableArray *contentControllers;

@end

@implementation CoolManySegmentBaseViewController


#pragma mark - life style

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.contentScrollView.frame = CGRectMake(0, 0,  self.view.bounds.size.width,  self.view.bounds.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isInitial == NO) {
        
        _isInitial = YES;
        
        [self.contentScrollView registerClass:[CoolManySegmentVCCell class] forCellWithReuseIdentifier:ReuseIdentifier];
        self.contentScrollView.backgroundColor = self.view.backgroundColor;
        
        NSUInteger count = self.contentControllers.count;
        self.contentScrollView.contentSize = CGSizeMake(count * self.contentScrollView.bounds.size.width, 0);
    }
}

//- (void)viewDidLayoutSubviews
//{
//    double delayInSeconds = 0.5;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [_contentScrollView reloadData];
//    });
//}


#pragma mark - interface method

- (void)configTitles:(NSArray *)titles controllers:(NSArray *)controllers
{
    self.contentControllers = [controllers mutableCopy];
    [self createSegmentViewItems:titles];
}

- (void)configSelectedVC:(NSUInteger)index
{
    [_segmentView refreshSegmentButton:index];
    [self segmentBarClick:index];
}

#pragma mark - private method

- (void)createSegmentViewItems:(NSArray *)items
{
    CoolManySegmentView *segmentView = [[CoolManySegmentView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32.0f) items:items itemSelectedIndex:0];
    [self.view addSubview:segmentView];
    
    __weak typeof(self) weakSelf = self;
    segmentView.segmentButtonClick = ^(NSUInteger index) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf segmentBarClick:index];
    };
    
    _segmentView = segmentView;
}

- (void)segmentBarClick:(NSUInteger)index
{
    CGFloat offsetX = index * self.contentScrollView.bounds.size.width;
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
}


#pragma mark - collection delegate and datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contentControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CoolManySegmentVCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
    UIViewController *vc = self.contentControllers[indexPath.row];
    cell.contentViewController = vc;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CoolManySegmentVCCell *dislayCell = (CoolManySegmentVCCell *)cell;
    [dislayCell addViewControllerToParentViewController:self];
    
    if (!_isOneDisplay) {
        _isOneDisplay = YES;
        [dislayCell.contentViewController viewWillAppear:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CoolManySegmentVCCell *dislayCell = (CoolManySegmentVCCell *)cell;
    [dislayCell removeViewControllerFromParentViewController];
}


#pragma mark - getter and setter

- (UIScrollView *)contentScrollView
{
    if (_contentScrollView == nil) {
        
        CoolManySegmentVCLayout *layout = [[CoolManySegmentVCLayout alloc] init];
        UICollectionView *contentScrollView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _contentScrollView = contentScrollView;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        _contentScrollView.delegate = self;
        _contentScrollView.dataSource = self;
        _contentScrollView.scrollEnabled = NO;
        [self.view addSubview:contentScrollView];
        
    }
    
    return _contentScrollView;
}

@end
