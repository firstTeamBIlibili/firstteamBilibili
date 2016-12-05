//
//  YXHFinishedTableViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHFinishedTableViewController.h"

@interface YXHFinishedTableViewController ()

@end

@implementation YXHFinishedTableViewController

- (NSString *)url
{
    return @"http://app.bilibili.com/x/v2/region/show/child?actionKey=appkey&appkey=27eb53fc9058f8c3&build=4000&device=phone&mobi_app=iphone&platform=ios&rid=32&sign=f1bc385b764cb7b6248a567cec739144&ts=1480468993";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
