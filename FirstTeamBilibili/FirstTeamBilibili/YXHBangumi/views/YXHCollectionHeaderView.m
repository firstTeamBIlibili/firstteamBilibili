//
//  YXHCollectionHeaderView.m
//  bangumi
//
//  Created by 颜晓卉 on 2016/12/1.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHCollectionHeaderView.h"

@interface YXHCollectionHeaderView()

@property(nonatomic,strong)SDCycleScrollView * scrollView;
@property(nonatomic,strong)UIView * middleView;
@property(nonatomic,strong)UIView * bottomView;

@end

@implementation YXHCollectionHeaderView


- (void)setImageArray:(NSArray *)imageArray
{
    if (imageArray != nil)
    {
        self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, 100) imageNamesGroup:imageArray];
        [self addSubview:self.scrollView];
        //self.height = 100;
    }
}

@end
