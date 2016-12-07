//
//  YXHSuperTableViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHSuperTableViewController.h"
#import "YXHSuperTableViewCell.h"
#import "YXHSuperModel.h"
#import "YXHSuperSectionHeaderView.h"

@interface YXHSuperTableViewController ()
@property(nonatomic,strong)AFHTTPSessionManager * manager;

@property(nonatomic,strong)NSMutableArray * recommendArray; //热门推荐
@property(nonatomic,strong)NSMutableArray * newestArray;  //最新视频

@end
static NSString * reuseId = @"superCell";
@implementation YXHSuperTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self requestData];
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)setupTableView
{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YXHSuperTableViewCell" bundle:nil] forCellReuseIdentifier:reuseId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark network
- (void)requestData
{
    WeakSelf;
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject);
        weakSelf.recommendArray = [YXHSuperModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"recommend"]];
        weakSelf.newestArray = [YXHSuperModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"new"]];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {
        return self.recommendArray.count;
    }else
    {
        return self.newestArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXHSuperTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    if (indexPath.section == 0)
        cell.model = self.recommendArray[indexPath.row];
    else
        cell.model = self.newestArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * imageArr = @[@"hd_home_recommend",@"hd_home_new_region"];
    NSArray * titleArr = @[@"热门推荐",@"最新视频"];
    YXHSuperSectionHeaderView * header = [YXHSuperSectionHeaderView viewFromXib];
    header.headerImageView.image = [UIImage imageNamed:imageArr[section]];
    header.titleLabel.text = titleArr[section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

@end
