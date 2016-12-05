//
//  BannerViewController.m
//  Project3
//
//  Created by wyzc03 on 16/12/5.
//  Copyright © 2016年 wyzc03. All rights reserved.
//

#import "BannerViewController.h"
#import <WebKit/WebKit.h>
@interface BannerViewController ()

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    WKWebView * web = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    NSURL * url = [NSURL URLWithString:_str];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    
    [self.view addSubview:web];
    
    
    
    
    // Do any additional setup after loading the view.
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
