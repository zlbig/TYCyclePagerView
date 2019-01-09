//
//  CustomViewController.m
//  TYCyclePagerViewDemo
//
//  Created by bigzl on 2019/1/4.
//  Copyright © 2019 tany. All rights reserved.
//

#import "CustomViewController.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "TYCyclePagerViewCell.h"

@interface CustomViewController ()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addPagerView];
//    [self addPageControl];
    [self loadData];
    
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 250) / 2, 64, 250, 20)];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(30, 64, 250, 20)];
    view1.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view1];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, 284, CGRectGetWidth(self.view.frame) - 60, 10)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:0 target:self action:@selector(loadData)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc] init];
    pagerView.layer.borderWidth = 1;
//    pagerView.isInfiniteLoop = NO;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
    [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:pagerView];
    _pagerView = pagerView;
}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    pageControl.pageIndicatorSize = CGSizeMake(12, 6);
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
    //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, 84, CGRectGetWidth(self.view.frame), 200);
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 7; ++i) {
        if (i == 0) {
            [datas addObject:[UIColor redColor]];
            continue;
        }
        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    }
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
    //[_pagerView scrollToItemAtIndex:3 animate:YES];
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.backgroundColor = _datas[index];
    if (index % 2) {
        cell.bgImageView.image = [UIImage imageNamed:@"321"];
        cell.label.text = nil;
    } else {
        cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
        cell.bgImageView.image = nil;
    }
    cell.layer.cornerRadius = 10.0;
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc] init];
    layout.itemSize = CGSizeMake(250.0, 140.0);
    layout.itemSpacing = 12;
    layout.layoutType = TYCyclePagerTransformLayoutTwoBigSmall;
//    layout.minimumScale = (186.0 * 117.0) / (250.0 * 140.0);
//    layout.minimumScale = 186.0 / 250.0;
    layout.minimumScale = 117.0 / 140.0;    
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];    
}

- (void)pageControlValueChangeAction:(TYPageControl *)sender {
    NSLog(@"pageControlValueChangeAction: %ld",sender.currentPage);
}


@end
