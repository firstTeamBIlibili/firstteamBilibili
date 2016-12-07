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
#import "YXHDetailepisode.h"
#import "YXHEpisodeTableViewCell.h"
#import "YXHDetailTag.h"
#import "YXHEvaluateTableViewCell.h"
#import "YXHCommentModel.h"
#import "YXHCommentTableViewCell.h"

@interface YXHBangumiDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

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
static NSString * episodeCell = @"episodeCell";
static NSString * evaluateCell = @"evaluateCell";
static NSString * commentCell = @"commentCell";
@implementation YXHBangumiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self setNavigation];
    
    [self setupTableView];
    
    [self requestData];
}

- (void)setNavigation
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"common_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
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
    self.navigationController.navigationBar.hidden = NO;
}

- (void)requestData
{
    WeakSelf;
    [self.manager GET:@"http://bangumi.bilibili.com/api/season_v5?actionKey=appkey&appkey=27eb53fc9058f8c3&build=4000&device=phone&mobi_app=iphone&platform=ios&season_id=2647&sign=ba269256c6e97874386c91da1868a4c4&ts=1480474878&type=bangumi" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject[@"result"]);
        YXHDetailModel * model = [[YXHDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject[@"result"]];
        weakSelf.model = model;
        [weakSelf addTableViewHeader];  //添加表头
        self.title = model.bangumi_title;  //设置标题
        //选集数据
        weakSelf.episodes = [YXHDetailepisode mj_objectArrayWithKeyValuesArray:model.episodes];
        
        //标签和简介数据
        weakSelf.evaluate = model.evaluate;
        weakSelf.tags = [YXHDetailTag mj_objectArrayWithKeyValuesArray:model.tags];
        
        [weakSelf.tableView reloadData];
        
        //番剧数据请求成功后再请求评论数据,参数oid是番剧中的av_id
        YXHDetailepisode * episode = self.episodes.firstObject;
        NSString * commentUrl = [NSString stringWithFormat:@"http://api.bilibili.com/x/v2/reply?_device=iphone&_hwid=5fdaf2988e676bb9&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=4000&build=4000&oid=%@&platform=ios&pn=1&ps=20&sign=93a0e793ece42ee011aa7cf39255e424&sort=2&type=1",episode.av_id];
        [weakSelf.manager GET:commentUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray * dataArray = responseObject[@"data"][@"replies"];
            weakSelf.commentArray = [YXHCommentModel mj_objectArrayWithKeyValuesArray:dataArray];
            //NSLog(@"%@",weakSelf.commentArray);
            [weakSelf.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.navigationController.navigationBar.hidden = NO;
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
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[YXHEpisodeTableViewCell class] forCellReuseIdentifier:episodeCell]; //注册选集cell
    [_tableView registerClass:[YXHEvaluateTableViewCell class] forCellReuseIdentifier:evaluateCell]; //注册简介cell
    
    [_tableView registerNib:[UINib nibWithNibName:@"YXHCommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentCell]; //注册评论cell
}

//添加表头
- (void)addTableViewHeader
{
    self.header.model = self.model;
    self.tableView.tableHeaderView = self.header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        YXHCommentModel * model = self.commentArray[indexPath.row];
        return model.cellHeight;
    }
    else
    {
        return 130;
    }
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
    
    if (indexPath.section == 0)
    {
        YXHEpisodeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:episodeCell forIndexPath:indexPath];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [[UIColor alloc] initWithWhite:0.9 alpha:1];
        cell.episodes = self.episodes;
        return cell;
    }
    
    if (indexPath.section == 1)
    {
        YXHEvaluateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:evaluateCell forIndexPath:indexPath];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [[UIColor alloc] initWithWhite:0.9 alpha:1];
        cell.evaluate = self.evaluate;
        cell.tags = self.tags;
        return cell;
    }
    
    if (indexPath.section == 2)
    {
        YXHCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:commentCell forIndexPath:indexPath];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [[UIColor alloc] initWithWhite:0.9 alpha:1];
        cell.model = self.commentArray[indexPath.row];
        return cell;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:commentCell forIndexPath:indexPath];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) return 40;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2)
    {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 40, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"评论";
        [view addSubview:label];
        return view;
    }
    return [[UIView alloc] init];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y == -20)
    {
        self.navigationController.navigationBar.hidden = YES;
    }else
    {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationController.navigationBar.alpha = (scrollView.contentOffset.y + 20) / 64;
    }
}



@end
