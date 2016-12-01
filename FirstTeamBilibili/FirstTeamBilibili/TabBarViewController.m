//
//  TabBarViewController.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/1.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "TabBarViewController.h"
#import "HCJLiveViewController.h"
#import "YJGRecommendViewController.h"
#import "YXHBangumiViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[[HCJLiveViewController alloc] init]withTitle:@"直播" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    [self addChildViewController:[[HCJLiveViewController alloc] init]withTitle:@"推荐" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    [self addChildViewController:[[HCJLiveViewController alloc] init]withTitle:@"番剧" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    
}

- (void)addChildViewController:(UIViewController *)viewContrller withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:viewContrller];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
