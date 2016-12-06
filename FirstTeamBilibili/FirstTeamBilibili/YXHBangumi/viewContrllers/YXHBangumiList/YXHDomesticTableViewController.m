//
//  YXHDomesticTableViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHDomesticTableViewController.h"

@interface YXHDomesticTableViewController ()

@end

@implementation YXHDomesticTableViewController

- (NSString *)url
{
    return @"http://app.bilibili.com/x/v2/region/show/child?actionKey=appkey&appkey=27eb53fc9058f8c3&build=4000&device=phone&mobi_app=iphone&platform=ios&rid=153&sign=fba44ba5d75f3387de7afadb0d4152c7&ts=1480469152";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
