//
//  DetialLiveViewController.m
//  Project3
//
//  Created by wyzc03 on 16/12/5.
//  Copyright © 2016年 wyzc03. All rights reserved.
//

#import "DetialLiveViewController.h"
#import "LiveModel.h"
#import "LiveCollectionViewCell.h"



#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

static NSString * const reuseId = @"f;alsfjklasdjfkl";


@interface DetialLiveViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView * collectionView;

@end

@implementation DetialLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self setUpLeftTabBarButtonItem];
    
    [self.view addSubview:self.collectionView];
}

//collectionView代理
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat width = (WIDTH - 3 * 20) / 2;
        CGFloat height = width * 1.1;
        
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 0);
        //设置区头尺寸
        flowLayout.headerReferenceSize = CGSizeMake(0, 30);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        //注册cell
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LiveCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseId];
        
        //整体页边距
        _collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
        
    }
    return _collectionView;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    
    cell.area = YES;
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = self.dataArr[indexPath.item];
    return cell;
}































- (void)setUpLeftTabBarButtonItem{
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    LiveModel * model = self.dataArr[0];

    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%@ %@",@"<",model.area] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
