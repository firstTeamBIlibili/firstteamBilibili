//
//  HCJLiveViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/1.
//  Copyright © 2016年 WYZC. All rights reserved.
//
#import "AFNetworking.h"
#import "Banner.h"
#import "SDCycleScrollView.h"
#import "MJRefresh.h"
#import "LiveCollectionViewCell.h"
#import "HeadCollectionReusableView.h"
#import "BannerViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

static NSString * const cellReuseID = @"CELL";
static NSString * const headReuseID = @"HEAD";
#import "HCJLiveViewController.h"

@interface HCJLiveViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic,strong) UICollectionView * collectionView;
//存储数据的数组
@property (nonatomic,strong) NSArray * dataArr;
//存储live区数据的数组
@property (nonatomic,strong) NSMutableArray * liveArr;
//手机直播
@property (nonatomic,strong) NSMutableArray * phoneArr;
//唱见舞见
@property (nonatomic,strong) NSMutableArray * singAndDance;
//手游
@property (nonatomic,strong) NSMutableArray * phoneGame;
//单机游戏
@property (nonatomic,strong) NSMutableArray * singleGame;
//网络游戏
@property (nonatomic,strong) NSMutableArray * onlineGame;
//电子竞技
@property (nonatomic,strong) NSMutableArray * E_sports;
//御宅文化
@property (nonatomic,strong) NSMutableArray * otakuCulture;
//放映厅
@property (nonatomic,strong) NSMutableArray * movie;
//存储轮播图图片的数组
@property (nonatomic,strong) NSMutableArray * bannerArr;

@property (nonatomic,strong) SDCycleScrollView * cycleView;
@end

@implementation HCJLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgation];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    //[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //初始化数组
    self.bannerArr = [NSMutableArray array];
    self.liveArr = [NSMutableArray array];
    self.phoneArr = [NSMutableArray array];
    self.singAndDance = [NSMutableArray array];
    self.phoneGame = [NSMutableArray array];
    self.singleGame = [NSMutableArray array];
    self.onlineGame = [NSMutableArray array];
    self.E_sports = [NSMutableArray array];
    self.otakuCulture = [NSMutableArray array];
    self.movie = [NSMutableArray array];
    //将各组数据加入到dataArr中
    self.dataArr = @[_liveArr,_phoneArr,_singAndDance,_phoneGame,_singleGame,_onlineGame,_E_sports,_otakuCulture,_movie];
    //请求数据
    [self requestData];
    
    CGFloat cycleHeiht = HEIGHT / 5;
    _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(-20, -cycleHeiht - 10, WIDTH, cycleHeiht) imageURLStringsGroup:[self.bannerArr valueForKeyPath:@"img"]];
    _cycleView.delegate = self;
    [self.collectionView addSubview:_cycleView];
    
    //设置collectionView的偏移量
    self.collectionView.contentInset = UIEdgeInsetsMake(cycleHeiht + 64 + 10, 20, 0, 20);
    self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset;
    [self.view addSubview:self.collectionView];
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LiveCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellReuseID];
    //注册区头
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HeadCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReuseID];
    //下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    //隐藏刷新状态
    [self.collectionView.mj_header setHidden:YES];
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat width = (WIDTH - 3 * 20) / 2;
        CGFloat height = width * 1.1;
        
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
        //设置区头尺寸
        flowLayout.headerReferenceSize = CGSizeMake(0, 30);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return MIN([self.dataArr[section] count],4);
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    
    cell.area = YES;
    //    if (indexPath.section == 0) {
    //        cell.area = YES;
    //    }else{
    //        cell.area = NO;
    //    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = self.dataArr[indexPath.section][indexPath.item];
    return cell;
}
#pragma mark 区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HeadCollectionReusableView * head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReuseID forIndexPath:indexPath];
    
    head.backgroundColor = [self.collectionView backgroundColor];
    //图片名数组
    NSArray * arr = @[@"绘画专区",@"手机直播",@"唱见舞见",@"手游直播",@"单机联机",@"网络游戏",@"电子竞技",@"御宅文化",@"放映厅"];
    
    head.headImageView.image = [UIImage imageNamed:arr[indexPath.section]];
    head.areaLabel.text = arr[indexPath.section];
    head.modelArr = self.dataArr[indexPath.section];
    return head;
}


//请求数据
- (void)requestData{
    NSString * str = @"http://live.bilibili.com/AppNewIndex/common?scale=2&device=phone&platform=ios";
    
    [self.bannerArr removeAllObjects];
    [self.dataArr makeObjectsPerformSelector:@selector(removeAllObjects)];
    
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //取消所有任务 以免重复刷新 造成任务冲突
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //轮播图数据请求
        NSArray * arr = responseObject[@"data"][@"banner"];
        //没有请求到数据就返回
        if (arr.count == 0) {
            return ;
        }
        for (NSDictionary * dic in arr) {
            Banner * banner = [[Banner alloc]init];
            [banner setValuesForKeysWithDictionary:dic];
            [weakSelf.bannerArr addObject:banner];
        }
        //刷新轮播图
        weakSelf.cycleView.imageURLStringsGroup = [weakSelf.bannerArr valueForKeyPath:@"img"];
        //添加数据
        NSArray * array1 = responseObject[@"data"][@"partitions"];
        if (array1.count == 0) {
            return;
        }
        for (int i = 0; i < array1.count; i ++) {
            
            NSArray * array = array1[i][@"lives"];
            NSMutableArray * arr = weakSelf.dataArr[i];
            for (NSDictionary * dic in array) {
                LiveModel * model = [[LiveModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                model.name = dic[@"owner"][@"name"];
                model.src = dic[@"cover"][@"src"];
                [arr addObject:model];
            }
        }
        
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
    
    
}


//轮播图代理实现
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    Banner * banner = self.bannerArr[index];
    
    BannerViewController * banVC = [[BannerViewController alloc] init];
    
    banVC.str = banner.link;
    
    [self.navigationController pushViewController:banVC animated:YES];
}

- (void)setupNavgation
{
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:255/256.0 green:85/256.0 blue:148/256.0 alpha:0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.title = @"直播";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
