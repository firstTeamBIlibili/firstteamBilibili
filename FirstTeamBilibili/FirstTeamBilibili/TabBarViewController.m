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
#import "YXHBangumiCollectionViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBarItemAppearance];
    
    [self addChildViewController:[[HCJLiveViewController alloc] init]withTitle:@"直播" imageName:@"直播.jpg" selectedImageName:@"直播.jpg"];
    [self addChildViewController:[[YJGRecommendViewController alloc] init]withTitle:@"推荐" imageName:@"推荐.jpg" selectedImageName:@"推荐.jpg"];
    [self addChildViewController:[[YXHBangumiCollectionViewController alloc] init]withTitle:@"番剧" imageName:@"番剧.jpeg" selectedImageName:@"番剧.jpeg"];
    
}

- (void)addChildViewController:(UIViewController *)viewContrller withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:viewContrller];
    nav.tabBarItem.title = title;
    
    
    nav.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    [self addChildViewController:nav];
}



- (void)setupTabBarItemAppearance{
    
    UITabBarItem * item = [UITabBarItem appearance];
    
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
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
