//
//  YXHTimeListViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/8.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHTimeListViewController.h"
#import "YXHTimeListModel.h"
#import "YXHTimeListCollectionViewCell.h"
#import "YXHTimeListSectionHeaderCollectionReusableView.h"
#import "YXHPlayViewController.h"

@interface YXHTimeListViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,strong)AFHTTPSessionManager * manager;
@property(nonatomic,strong)UICollectionView * collectionView;

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * secondLastArray;
@property(nonatomic,strong)NSMutableArray * firstLastArray;
@property(nonatomic,strong)NSMutableArray * todayArray;
@property(nonatomic,strong)NSMutableArray * firstArray;
@property(nonatomic,strong)NSMutableArray * secondArray;
@property(nonatomic,strong)NSMutableArray * thirdArray;
@property(nonatomic,strong)NSMutableArray * fourthArray;
@property(nonatomic,strong)NSMutableArray * fifthArray;
@property(nonatomic,strong)NSMutableArray * sixthArray;


@end

static NSString * timeListCell = @"timeListCell";
@implementation YXHTimeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _secondLastArray = [NSMutableArray array];
    _firstLastArray = [NSMutableArray array];
    _todayArray = [NSMutableArray array];;
    _firstArray = [NSMutableArray array];;
    _secondArray = [NSMutableArray array];
    _thirdArray = [NSMutableArray array];
    _fourthArray = [NSMutableArray array];
    _fifthArray = [NSMutableArray array];
    _sixthArray = [NSMutableArray array];
    
    _dataArray = [NSMutableArray arrayWithObjects:_secondLastArray,_firstLastArray,_todayArray,_firstArray,_secondArray,_thirdArray,_fourthArray,_fifthArray,_sixthArray, nil];
    
    [self setupNavigation];
    
    [self setupCollectionView];
    
    
    [self requestData];
}


#pragma mark setup navigation
- (void)setupNavigation
{
    self.title = @"番剧时间表";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"common_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark setup collection
- (void)setupCollectionView
{
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 8;
    flow.minimumInteritemSpacing = 8;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];
    [self.view addSubview:_collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"YXHTimeListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:timeListCell];
    
    //注册区头
    [self.collectionView registerNib:[UINib nibWithNibName:@"YXHTimeListSectionHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}
#pragma mark network
- (AFHTTPSessionManager *)manager
{
    if (!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)requestData
{
    NSString * url = @"http://bangumi.bilibili.com/api/timeline_v4?actionKey=appkey&appkey=27eb53fc9058f8c3&area_id=2%2C1%2C-1&build=4000&device=phone&mobi_app=iphone&platform=ios&see_mine=0&sign=1e3f5593aa6e97fa945078eddc2ef6e3&ts=1480471745";
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject[@"result"]);
        NSArray * array = [YXHTimeListModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        for (YXHTimeListModel * model in array)
        {
            switch (model.cmpDay)
            {
                case -2:
                    [_secondLastArray addObject:model];
                    break;
                case -1:
                    [_firstLastArray addObject:model];
                    break;
                case 0:
                    [_todayArray addObject:model];
                    break;
                case 1:
                    [_firstArray addObject:model];
                    break;
                case 2:
                    [_secondArray addObject:model];
                    break;
                case 3:
                    [_thirdArray addObject:model];
                    break;
                case 4:
                    [_fourthArray addObject:model];
                    break;
                case 5:
                    [_fifthArray addObject:model];
                    break;
                case 6:
                    [_sixthArray addObject:model];
                    break;
                    
                default:
                    break;
            }
        }
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark collection data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YXHTimeListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:timeListCell forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.section][indexPath.item];
    
    return cell;
}

//区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        YXHTimeListModel * model = [_dataArray[indexPath.section] firstObject];
        NSInteger weekIndex = model.weekIndex;
        YXHTimeListSectionHeaderCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.headerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bangumi_timeline_%ld",weekIndex]];
        header.weekday.text = model.weekday;
        header.date.text = model.pubDate;
        return header;
    }
    
    
    return [[UICollectionReusableView alloc] init];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YXHTimeListModel * model = _dataArray[indexPath.section][indexPath.item];
    YXHPlayViewController * playVC = [[YXHPlayViewController alloc] init];
    playVC.play_id = model.ep_id;
    [self presentViewController:playVC animated:YES completion:nil];
}

#pragma mark collection flowLayout delegate
//设置item尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.width - 4 * 10) / 3, 190);
    
}
//设置区头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.width, 40);
    
}

@end
