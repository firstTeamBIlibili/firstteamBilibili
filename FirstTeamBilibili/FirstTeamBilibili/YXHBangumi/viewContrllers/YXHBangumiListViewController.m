//
//  YXHBangumiListViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHBangumiListViewController.h"
#import "YXHUnfinishedTableViewController.h"
#import "YXHFinishedTableViewController.h"
#import "YXHDomesticTableViewController.h"
#import "YXHOfficialTableViewController.h"

@interface YXHBangumiListViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIView * indicatorView; //导航栏下的切换视图
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)NSMutableArray * indicatorButtons; //切换按钮
@property(nonatomic,strong)UIButton * selectedIndicatorButton; //当前选中的切换按钮
@property(nonatomic,strong)UIView * indicatorLine; //切换按钮下的指示条

@end

@implementation YXHBangumiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupNavigation];
    
    [self addChildVCs];
    
    [self setupScrollView];
    
    [self setupIndicatorView];
}

//设置导航栏
- (void)setupNavigation
{
    //导航栏title
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:255/256.0 green:85/256.0 blue:148/256.0 alpha:1];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.title = @"番剧";
    
    //左侧返回按钮
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"common_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    //右侧排序按钮
    UIBarButtonItem * bar = [[UIBarButtonItem alloc] initWithTitle:@"默认" style:UIBarButtonItemStylePlain target:self action:nil];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    bar.enabled = NO;
    UIBarButtonItem * bar1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"common_downArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(sort)];
    bar1.imageInsets = UIEdgeInsetsMake(10, -20, 0, 15);
    self.navigationItem.rightBarButtonItems = @[bar1,bar];
    
}

- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)sort
{
    
}

- (NSMutableArray *)indicatorButtons
{
    if (!_indicatorButtons)
        _indicatorButtons = [NSMutableArray array];
    return _indicatorButtons;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildVCs
{
    YXHUnfinishedTableViewController * unfinished = [[YXHUnfinishedTableViewController alloc] init];
    [self addChildViewController:unfinished];
    
    YXHFinishedTableViewController * finished = [[YXHFinishedTableViewController alloc] init];
    [self addChildViewController:finished];
    
    YXHDomesticTableViewController * domestic = [[YXHDomesticTableViewController alloc] init];
    [self addChildViewController:domestic];
    
    YXHOfficialTableViewController * official = [[YXHOfficialTableViewController alloc] init];
    [self addChildViewController:official];
}

- (void)setupIndicatorView
{
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 35)];
    _indicatorView.backgroundColor = [[UIColor alloc] initWithRed:255/256.0 green:72/256.0 blue:148/256.0 alpha:0.79];
    [self.view addSubview:_indicatorView];
    
    NSArray * titleArray = @[@"连载动画",@"完结动画",@"国产动画",@"官方延伸"];
    CGFloat buttonW = _indicatorView.width / self.childViewControllers.count;
    CGFloat buttonH = _indicatorView.height;
    
    //切换按钮
    for (int i = 0; i < self.childViewControllers.count; i ++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button.titleLabel sizeToFit];
        [button addTarget:self action:@selector(indicatorClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.indicatorView addSubview:button];
        [self.indicatorButtons addObject:button];
    }
    
    //指示条
    _indicatorLine = [[UIView alloc] init];
    _indicatorLine.height = 1;
    _indicatorLine.y = self.indicatorView.height - 2;
    _indicatorLine.backgroundColor = [UIColor whiteColor];
    [self.indicatorView addSubview:_indicatorLine];
    
    self.selectedIndicatorButton = self.indicatorButtons[self.index];
    _indicatorLine.x = _selectedIndicatorButton.x;
    _indicatorLine.width = self.selectedIndicatorButton.width;
    
    [self indicatorClick:_selectedIndicatorButton];
}

- (void)indicatorClick:(UIButton *)button
{
    self.selectedIndicatorButton.selected = NO;
    button.selected = YES;
    self.selectedIndicatorButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorLine.x = button.x;
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    self.index = [self.indicatorButtons indexOfObject:button];
    offset.x = self.view.width * self.index;
    self.scrollView.contentOffset = offset;
    
    [self scrollViewDidEndScrollingAnimation:_scrollView];
}

- (void)setupScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 0, 0);
    _scrollView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //取出对应的子视图控制器
    UIViewController * willShowChildVC = self.childViewControllers[self.index];
    if (willShowChildVC.isViewLoaded) return;
    willShowChildVC.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:willShowChildVC.view];
}

//当减速完毕的时候调用（人为拖拽scrollView，手松开后scrollView慢慢减速完毕到静止）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    self.index = scrollView.contentOffset.x / self.view.width;
    [self indicatorClick:self.indicatorButtons[self.index]];
}

@end
