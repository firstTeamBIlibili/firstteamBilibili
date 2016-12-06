//
//  MoseAndCatViewController.m
//  FirstTeamBilibili
//
//  Created by wyzc03 on 16/12/6.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "MoseAndCatViewController.h"
#import <WebKit/WebKit.h>
@interface MoseAndCatViewController ()

@end

@implementation MoseAndCatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    NSString * strUrl = [NSString stringWithFormat:@"http://live.bilibili.com/%ld",self.model.room_id];
    
    WKWebView * webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    [self.view addSubview:webView];
    
    NSURL * url = [NSURL URLWithString:strUrl];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
        
    
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
