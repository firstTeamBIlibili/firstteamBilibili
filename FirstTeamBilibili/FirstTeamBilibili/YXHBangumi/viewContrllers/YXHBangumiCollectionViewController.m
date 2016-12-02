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
#import "YXHRecommendCollectionViewCell.h"
#import "YXHSectionHeaderCollectionReusableView.h"

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

static NSString * const bangumiCell = @"bangumiCell";
static NSString * const recommendCell = @"recommendCell";

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
    
    [self refresh];
    
}

#pragma mark setup navigation
- (void)setupNavgation
{
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:255/256.0 green:85/256.0 blue:148/256.0 alpha:0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.title = @"番剧";
}

#pragma mark setup collectionView
- (void)setupCollectionView
{
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"YXHNewBangumiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:bangumiCell];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YXHRecommendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:recommendCell];
    //注册区头
    [self.collectionView registerNib:[UINib nibWithNibName:@"YXHSectionHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //注册区尾
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //表头
    _headerView = [[YXHCollectionHeaderView alloc] initWithFrame:CGRectMake(0, -240, self.view.width, 240)];
    //_headerView.frame = CGRectMake(0, -240, self.view.width, 240);
    [self.collectionView addSubview:_headerView];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(240, 0, 0, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(100, 0, 0, 0);
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    
}

#pragma mark network
- (void)requestData
{
    self.serializingArray = nil;
    self.previousArray = nil;
    self.recommendArray = nil;
    [self.headerArray removeAllObjects];
    [self.footerArray removeAllObjects];
    
    WeakSelf;
    
    [self.manager GET:@"http://bangumi.bilibili.com/api/app_index_page_v4?build=4000&device=phone&mobi_app=iphone&platform=ios" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = responseObject[@"result"];
        
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
        //NSLog(@"%@",self.headerArray);
        
        [weakSelf.collectionView reloadData];
        
        [weakSelf.collectionView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    [self.manager GET:@"http://bangumi.bilibili.com/api/bangumi_recommend?actionKey=appkey&appkey=27eb53fc9058f8c3&build=4000&cursor=0&device=phone&mobi_app=iphone&pagesize=10&platform=ios&sign=cd37d74cbbd8b4661e7012848a717566&ts=1480649864" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject[@"result"]);
        weakSelf.recommendArray = [YXHRecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadMoreData
{
    WeakSelf;
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    YXHRecommendModel * model = self.recommendArray.lastObject;
    NSString * url = [NSString stringWithFormat:@"http://bangumi.bilibili.com/api/bangumi_recommend?actionKey=appkey&appkey=27eb53fc9058f8c3&build=4000&cursor=%@&device=phone&mobi_app=iphone&pagesize=10&platform=ios&sign=867481fdda009b7c620391bc2e686550&ts=1480649986",model.cursor];
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.recommendArray addObjectsFromArray:[YXHRecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]]];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_footer endRefreshing];
        weakSelf.collectionView.mj_footer.hidden = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)refresh
{
    WeakSelf;
    //[self requestData];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;  //自动改变透明度
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
        
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
//3个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

//每个区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == 0)
    {
        return self.serializingArray.count;  //新番连载
    }
    else if (section == 1)
    {
        return self.previousArray.count; //7月新番
    }
    else
    {
        return self.recommendArray.count; //番剧推荐
    }
}
//自定义的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YXHNewBangumiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bangumiCell forIndexPath:indexPath];
    //cell.model = nil;
    
    if (indexPath.section == 0)
    {
        cell.model = self.serializingArray[indexPath.item];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        cell.model = self.previousArray[indexPath.item];
        return cell;
    }
    else
    {
        YXHRecommendCollectionViewCell * cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:recommendCell forIndexPath:indexPath];
        cell1.model = self.recommendArray[indexPath.item];
        return cell1;
    }
    
    
   // return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSArray * headerImageArray = @[@"bangumi_unfinished.png",@"season_summer_icon",@"home_bangumi_tableHead_bangumiRecommend"];
    NSArray * titleArray = @[@"新番连载",@"7月新番",@"番剧推荐"];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        YXHSectionHeaderCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.headerImageName = headerImageArray[indexPath.section];
        header.title = titleArray[indexPath.section];
        
        header.sectionIndex = indexPath.section;
        
        return header;
    }
    
    if (indexPath.section == 0 && [kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        SDCycleScrollView * scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 100) imageNamesGroup:self.footerArray];
        [footer addSubview:scrollView];
        return footer;
    }
    
    return [[UICollectionReusableView alloc] init];
}


#pragma mark collection flowLayout delegate
//设置item尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2)
    {
        YXHRecommendModel * model = self.recommendArray[indexPath.item];
        
        return CGSizeMake(self.view.width - 2 * 10, [model itemHeight]);
    }
    else if (indexPath.section == 1)
    {
        return CGSizeMake((self.view.width - 4 * 10) / 3, 190);
    }
    else
    {
        return CGSizeMake((self.view.width - 4 * 10) / 3, 210);
    }
    
}
//设置区头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.width, 50);
    
}

//设置区尾尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.footerArray.count == 0) return CGSizeZero;
    
    if (section == 0)  return CGSizeMake(self.view.width, 100);
    
    return CGSizeZero;
}

//跳转到下一页
- (void)MoreNewBangumi
{
    NSLog(@"123");
}

- (void)MoreTimeListBangumi
{
    NSLog(@"456");
}

@end
