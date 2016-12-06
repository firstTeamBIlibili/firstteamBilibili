//
//  YJGRecommendViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/1.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "collectionModel.h"
#import "YJGRecommendViewController.h"
#import "CollectionViewCell.h"
#import "CollectionReusableView.h"
#import "TuiJianModel.h"
#import "SDCycleScrollView.h"
@interface YJGRecommendViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic)NSArray * array;
@property (strong,nonatomic)NSMutableArray *lunbotuarray;
@property (strong,nonatomic)UICollectionView *collectionView;

@property  (strong,nonatomic)NSMutableArray *hotrecommend;
@property (strong,nonatomic)NSMutableArray *zhengzaizhibo;
@property (strong,nonatomic)NSMutableArray *fanjurecommend;
@property (strong,nonatomic)NSMutableArray *donghuaqu;
@property (strong,nonatomic)NSMutableArray *musicqu;
@property (strong,nonatomic)NSMutableArray *wudaoqu;
@property (strong,nonatomic)NSMutableArray *youxiqu;
@property (strong,nonatomic)NSMutableArray *guichuqu;
@property (strong,nonatomic)NSMutableArray *shenghuoqu;
@property (strong,nonatomic)NSMutableArray *kejiqu;
@property (strong,nonatomic)NSMutableArray *shishangqu;
@property (strong,nonatomic)NSMutableArray *guanggaoqu;
@property (strong,nonatomic)NSMutableArray *yulequ;
@property (strong,nonatomic)NSMutableArray *dianshijuqu;
@property (strong,nonatomic)NSMutableArray *dianyingqu;
@property (strong,nonatomic)NSMutableArray *huodognzhognxin;
@property (strong,nonatomic)SDCycleScrollView *cycle;
@property (strong,nonatomic)NSTimer *timer;
@property (strong,nonatomic)UIPageControl *pagectrol;


@end
static NSString *idetifer=@"cell";
static NSString *headReuseID = @"head";

@implementation YJGRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setcollection];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    _lunbotuarray=[NSMutableArray array];
    _array=[NSMutableArray array];
    _hotrecommend=[NSMutableArray array];
    _zhengzaizhibo=[NSMutableArray array];
    _fanjurecommend=[NSMutableArray array];
    _donghuaqu=[NSMutableArray array];
    _musicqu=[NSMutableArray array];
    _wudaoqu=[NSMutableArray array];
    _youxiqu=[NSMutableArray array];
    _guichuqu=[NSMutableArray array];
    _shenghuoqu=[NSMutableArray array];
    _kejiqu=[NSMutableArray array];
    _shishangqu=[NSMutableArray array];
    _guanggaoqu=[NSMutableArray array];
    _yulequ=[NSMutableArray array];
    _dianyingqu=[NSMutableArray array];
    _dianshijuqu=[NSMutableArray array];
    _huodognzhognxin=[NSMutableArray array];
    
    self.array=@[_hotrecommend,_zhengzaizhibo,_fanjurecommend,_donghuaqu,_musicqu,_wudaoqu,_youxiqu,_guichuqu,_shenghuoqu,_huodognzhognxin,_kejiqu,_shishangqu,_guanggaoqu,_yulequ,_dianshijuqu,_dianyingqu];
    
    [self requestData];
    
    
    _cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -100, 414,100)imageURLStringsGroup:_lunbotuarray];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.collectionView addSubview:_cycle];
}
-(void)addTimer{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(imageo)  userInfo:nil repeats:YES];
}
-(void)imageo{
    int page=(int)self.pagectrol.currentPage;
    if( page == 2 ){
        page=0;
    }else{
        page ++;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReuseID forIndexPath:indexPath];
    head.backgroundColor=[UIColor whiteColor];
    
    NSArray *aty=@[@"11.png",@"12.png",@"13.png",@"14.png",@"15.png",@"16.png",@"17.png",@"18.png",@"19.png",@"20.png",@"21.png",@"22.png",@"23.jpg",@"24.jpg",@"25.jpg",@"26.jpg"];
    
    NSArray *arrew=@[@"热门焦点",@"正在直播",@"番剧推荐",@"动画区",@"音乐区",@"舞蹈区",@"游戏区",@"鬼畜区",@"生活区",@"活动中心",@"科技区",@"时尚区",@"广告区",@"娱乐区",@"电视剧去",@"电影区"];
    [head.button setTitle:arrew[indexPath.section] forState:UIControlStateNormal];
    head.image.image=[UIImage imageNamed:aty[indexPath.section]];
    return head;
}
-(void)requestData{
    
    //请求数据;
    NSString *str=[NSString stringWithFormat:@"http://app.bilibili.com/x/v2/show?actionKey=appkey&appkey=27eb53fc9058f8c3&build=4000&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios&sign=7229cc1b70282aca16a8c1a9ef6b7f4c&ts=1480406645&warm=0"];
    __weak typeof(self) weakSelf = self;
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //轮播图的数据请求;
        NSMutableArray *we=responseObject[@"data"][0][@"banner"][@"top"];
        
        for(NSDictionary * dice in we){
            TuiJianModel * ban=[[TuiJianModel alloc]init];
            [ban setValuesForKeysWithDictionary:dice
             ];
        [weakSelf.lunbotuarray addObject:ban];
        }
                _cycle.imageURLStringsGroup = [weakSelf.lunbotuarray valueForKey:@"image"];
        weakSelf.cycle.imageURLStringsGroup=[weakSelf.lunbotuarray valueForKeyPath:@"image"];
        
        NSMutableArray * array=responseObject[@"data"];
        for (int i=0; i<array.count; i++) {
            
            NSMutableArray * arr = _array[i];
            
            NSDictionary * dic=array[i];
            
            NSMutableArray * arre=dic[@"body"];
            for (int j=0; j< arre.count; j++) {
                NSDictionary * dict = arre[j];
                collectionModel * model = [[collectionModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                model.cover = dict[@"cover"];
                [arr addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(void)setcollection{
    
    CGFloat width=(self.view.frame.size.width-3*20)/2;
    CGFloat height=width*1.2;
    
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    //每个item的大小
    flow.itemSize=CGSizeMake(width,height);
    //最小行间距
    flow.minimumLineSpacing=15;
    //最小列间距
    flow.minimumInteritemSpacing=15;
    //距离上下左右的距离
    flow.sectionInset=UIEdgeInsetsMake(15, 15, 15, 15);
    _collectionView=[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flow];
    
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_collectionView];
    //设置区头尺寸
    flow.headerReferenceSize=CGSizeMake(0, 60);
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:idetifer];
    //注册区头
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReuseID];
    
    //下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    
    
    self.collectionView.contentInset = UIEdgeInsetsMake(64 + 100, 0, 0, 0);
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _array.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_array[section]count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"推荐");
}


-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:idetifer forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.models=_array[indexPath.section][indexPath.item];
    
    return cell;
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
