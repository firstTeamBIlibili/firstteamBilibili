//
//  BangumiCollectionViewController.m
//  bangumi
//
//  Created by 颜晓卉 on 2016/11/30.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHBangumiCollectionViewController.h"
#import "YXHRecommendModel.h"
#import "YXHNewBangumiModel.h"
#import "YXHCollectionHeaderView.h"
#import "YXHNewBangumiCollectionViewCell.h"

@interface YXHBangumiCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionViewFlowLayout * flow;
@property(nonatomic,strong)AFHTTPSessionManager * manager;
@property(nonatomic,strong)NSArray * previousArray;  //7月新番
@property(nonatomic,strong)NSArray * serializingArray;  //新番连载
@property(nonatomic,strong)NSMutableArray * recommendArray;  //番剧推荐

@property(nonatomic,strong)NSMutableArray * headerArray; //表头轮播图
@property(nonatomic,strong)NSMutableArray * footerArray; //区尾图片

@property(nonatomic,strong)YXHCollectionHeaderView * headerView;  //表头
@end

@implementation YXHBangumiCollectionViewController

static NSString * const reuseIdentifier = @"bangumiCell";

- (instancetype)init
{
    if (self = [super init])
    {
        self = [self initWithCollectionViewLayout:self.flow];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavgation];
    
    [self setupCollectionView];
    
    [self requestData];
    
}

- (void)setupNavgation
{
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:255/256.0 green:85/256.0 blue:148/256.0 alpha:0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.title = @"番剧";
}

- (void)setupCollectionView
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"YXHNewBangumiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    _headerView = [[YXHCollectionHeaderView alloc] init];
    _headerView.frame = CGRectMake(0, -100, self.view.width, 100);
    [self.collectionView addSubview:_headerView];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(100, 0, 0, 0);
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    
}

#pragma mark network
- (void)requestData
{
    WeakSelf;
    
    [self.manager GET:@"http://bangumi.bilibili.com/api/app_index_page_v4?build=4000&device=phone&mobi_app=iphone&platform=ios" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = responseObject[@"result"];
        NSLog(@"%@",dic);
        
        weakSelf.previousArray = [YXHNewBangumiModel mj_objectArrayWithKeyValuesArray:dic[@"previous"][@"list"]];
        weakSelf.serializingArray = [YXHNewBangumiModel mj_objectArrayWithKeyValuesArray:dic[@"serializing"]];
        
        for (NSDictionary * dic1 in dic[@"ad"][@"head"])
        {
            [weakSelf.headerArray addObject:dic1[@"img"]];
        }
        for (NSDictionary * dic1 in dic[@"ad"][@"body"]) {
            [weakSelf.footerArray addObject:dic1[@"img"]];
        }
        weakSelf.headerView.imageArray = self.headerArray;
        [weakSelf.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    [self.manager GET:@"http://bangumi.bilibili.com/api/bangumi_recommend?actionKey=appkey&appkey=27eb53fc9058f8c3&build=4000&cursor=1478858400544&device=phone&mobi_app=iphone&pagesize=10&platform=ios&sign=f86302e3bf11c66ed93d4d3b007c8b3b&ts=1480467131" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.recommendArray = [YXHRecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [weakSelf.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark lazy load
- (UICollectionViewFlowLayout *)flow
{
    if (!_flow)
    {
        _flow = [[UICollectionViewFlowLayout alloc] init];
        _flow.minimumLineSpacing = 8;
        _flow.minimumInteritemSpacing = 8;
        _flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return _flow;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)headerArray
{
    if (!_headerArray)
    {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}

- (NSMutableArray *)footerArray
{
    if (!_footerArray)
    {
        _footerArray = [NSMutableArray array];
    }
    return _footerArray;
}

#pragma mark collectionView dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == 0)
    {
        return self.serializingArray.count;
    }
    else if (section == 1)
    {
        return self.previousArray.count;
    }
    else
    {
        return self.recommendArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YXHNewBangumiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = nil;
    
    if (indexPath.section == 0)
    {
        cell.model = self.serializingArray[indexPath.item];
    }
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader])
        {
            
            UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            header.backgroundColor = [UIColor orangeColor];
            return header;
            
        }
        else
        {
            UICollectionReusableView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
            SDCycleScrollView * scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 100) imageNamesGroup:self.footerArray];
            [footer addSubview:scrollView];
            return footer;
        }
        
        
    }
    return [[UICollectionReusableView alloc] init];
}


#pragma mark collection flowLayout delegate
//设置item尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2)
    {
        return CGSizeMake(self.view.width - 2 * 10, 150);
    }
    else
    {
        return CGSizeMake((self.view.width - 4 * 10) / 3, 200);
    }
}
//设置区头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return CGSizeMake(self.view.width, 50);
    }
    return CGSizeZero;
}

//设置区尾尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return CGSizeMake(self.view.width, 100);
    }
    return CGSizeZero;
}

@end
