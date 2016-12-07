//
//  YXHCollectionHeaderView.m
//  bangumi
//
//  Created by 颜晓卉 on 2016/12/1.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHCollectionHeaderView.h"
#import "AnimationButton.h"
#import "YXHBangumiListViewController.h"
#import "LoginViewController.h"
#import "YXHBangumiCollectionViewController.h"

@interface YXHCollectionHeaderView()

@property(nonatomic,strong)SDCycleScrollView * scrollView;

@property(nonatomic,strong)NSMutableArray * animationButtons;

@property(nonatomic,strong)YXHBangumiCollectionViewController * superVC;
@end

@implementation YXHCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame])
    {
        [self addViews];
    }
    return self;
}

- (NSMutableArray *)animationButtons
{
    if (!_animationButtons)
        _animationButtons = [NSMutableArray array];
    return _animationButtons;
}

- (void)addViews
{
    NSArray * imageArray = @[@"home_region_icon_33",@"home_region_icon_32",@"home_region_icon_153",@"home_region_icon_152"];
    NSArray * titleArray = @[@"连载动画",@"完结动画",@"国产动画",@"官方延伸"];
    for (int i = 0; i < 4; i ++)
    {
        AnimationButton * button = [AnimationButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        button.width = (self.width - 2 * 10) / 4;
        button.height = 60;
        button.x = button.width * i + 10;
        button.y = 110;
        [button addTarget:self action:@selector(changeToAnimationList:) forControlEvents:UIControlEventTouchUpInside];
        [self.animationButtons addObject:button];
        [self addSubview:button];
    }
    
    NSArray * imageArr = @[@"home_bangumi_tableHead_followIcon",@"home_bangumi_tableHead_week3",@"home_bangumi_tableHead_indexIcon"];
    NSArray * titleArr = @[@"追番",@"放送表",@"索引"];
    SEL action[3] = {@selector(changeTofollowBangumi:),@selector(changeToTimeList:),@selector(changeToBangumiIndex:)};
    NSArray * colorArray = @[[[UIColor alloc] initWithRed:255/255.0 green:179/255.0 blue:0 alpha:1],[[UIColor alloc] initWithRed:255/255.0 green:85/255.0 blue:101/255.0 alpha:1],[[UIColor alloc] initWithRed:70/255.0 green:189/255.0 blue:255/255.0 alpha:1]];
    CGFloat buttonW = (self.width - 4 * 10) / 3;
    for (int i = 0; i < 3; i ++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.x = 10 * (i + 1) + buttonW * i;
        button.y = 180;
        button.width = buttonW;
        button.height = 50;
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:colorArray[i]];
        [button addTarget:self action:action[i] forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 8;
        button.layer.masksToBounds = YES;
        [self addSubview:button];
    }
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    if (imageArray.count == 0) return;
    
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, 100) imageNamesGroup:imageArray];
    [self addSubview:self.scrollView];
    
    [self setNeedsLayout];
}


- (void)changeToAnimationList:(UIButton *)sender {
    NSInteger index = [self.animationButtons indexOfObject:sender];
    //NSLog(@"%ld",index);
    
    YXHBangumiListViewController * listVC = [[YXHBangumiListViewController alloc] init];
    listVC.index = index;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:listVC];
    
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)changeTofollowBangumi:(UIButton *)sender {
    
//    for (UIView* next = [self superview]; next; next = next.superview)
//    {
//        UIResponder* nextResponder = [next nextResponder];
//        
//        if ([nextResponder isKindOfClass:[YXHBangumiCollectionViewController class]])
//        {
//            self.superVC = (YXHBangumiCollectionViewController *)nextResponder;//MyViewController就是你要找的那个vc
//            break;
//        }
//    }
    
    [self.superVC.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
    
}
- (void)changeToTimeList:(UIButton *)sender {
    NSLog(@"放送表");
}
- (void)changeToBangumiIndex:(UIButton *)sender {
    NSLog(@"索引");
}

- (YXHBangumiCollectionViewController *)superVC
{
    if (!_superVC)
    {
        for (UIView* next = [self superview]; next; next = next.superview)
        {
            UIResponder* nextResponder = [next nextResponder];
            
            if ([nextResponder isKindOfClass:[YXHBangumiCollectionViewController class]])
            {
                _superVC = (YXHBangumiCollectionViewController *)nextResponder;//MyViewController就是你要找的那个vc
                break;
            }
        }
    }
    
    return _superVC;
}
@end
