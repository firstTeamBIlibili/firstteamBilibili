//
//  YXHOfficialTableViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHOfficialTableViewController.h"

@interface YXHOfficialTableViewController ()

@end

@implementation YXHOfficialTableViewController

- (NSString *)url
{
    return @"http://app.bilibili.com/x/v2/region/show/child?actionKey=appkey&appkey=27eb53fc9058f8c3&build=4000&device=phone&mobi_app=iphone&platform=ios&rid=152&sign=3a0e2dbe03e29318da8f592a7112ce1f&ts=1480470632";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
