//
//  YXHUnfinishedTableViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHUnfinishedTableViewController.h"

@interface YXHUnfinishedTableViewController ()

@end

@implementation YXHUnfinishedTableViewController

- (NSString *)url
{
    return @"http://app.bilibili.com/x/v2/region/show/child?actionKey=appkey&appkey=27eb53fc9058f8c3&build=4000&device=phone&mobi_app=iphone&platform=ios&rid=33&sign=a55184a8128f42bbe5f2daa577943ec0&ts=1480468186";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
