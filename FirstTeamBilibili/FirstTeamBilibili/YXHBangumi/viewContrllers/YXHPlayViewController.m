//
//  YXHPlayViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/8.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHPlayViewController.h"

@interface YXHPlayViewController ()

@end

@implementation YXHPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * url = [NSString stringWithFormat:@"http://bangumi.bilibili.com/anime/v/%@",self.play_id];
    UIWebView * web = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view insertSubview:web atIndex:0];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [web loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
