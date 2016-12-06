//
//  YXHBangumiDetailViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/6.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHBangumiDetailViewController.h"
#import "YXHDetailHeader.h"
#import "YXHDetailModel.h"

@interface YXHBangumiDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)AFHTTPSessionManager * manager;
@property(nonatomic,strong)YXHDetailHeader * header;

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)YXHDetailModel * model; //全部信息

@property(nonatomic,strong)NSMutableArray * episodes;  //选集
@property(nonatomic,strong)NSString * evaluate;  //简介
@property(nonatomic,strong)NSArray * tags;  //简介下的标签
@property(nonatomic,strong)NSMutableArray * commentArray;  //评论
@property(nonatomic,strong)NSMutableArray * recommendArray;  //番剧推荐
@end

static NSString * commentCell = @"commentCell";
@implementation YXHBangumiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self setupTableView];
    
    [self requestData];
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager)
        _manager = [AFHTTPSessionManager manager];
    return _manager;
}

- (YXHDetailHeader *)header
{
    if (!_header)
        _header = [YXHDetailHeader viewFromXib];
    _header.frame = CGRectMake(0, 0, self.view.width, 150);
    [_header.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    return _header;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestData
{
    WeakSelf;
    [self.manager GET:@"http://bangumi.bilibili.com/api/season_v5?actionKey=appkey&appkey=27eb53fc9058f8c3&build=4000&device=phone&mobi_app=iphone&platform=ios&season_id=2647&sign=ba269256c6e97874386c91da1868a4c4&ts=1480474878&type=bangumi" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject[@"result"]);
        YXHDetailModel * model = [[YXHDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject[@"result"]];
        weakSelf.model = model;
        [weakSelf.tableView reloadData];
        
        [weakSelf addTableViewHeader];
        //NSLog(@"%@",model.episodes);
        NSLog(@"%@",self.model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [[UIColor alloc] initWithWhite:0.9 alpha:1];
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:commentCell];
}

//添加表头
- (void)addTableViewHeader
{
    self.header.model = self.model;
    NSLog(@"%@",self.model);
    self.tableView.tableHeaderView = self.header;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) return _commentArray.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:commentCell forIndexPath:indexPath];
        return cell;
    }
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:commentCell forIndexPath:indexPath];
        return cell;
    }
}


@end
