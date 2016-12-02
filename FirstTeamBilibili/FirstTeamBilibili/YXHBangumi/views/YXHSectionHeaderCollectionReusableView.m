//
//  YXHSectionHeaderCollectionReusableView.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/2.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHSectionHeaderCollectionReusableView.h"
#import "UIImageView+YXHCycle.h"

@interface YXHSectionHeaderCollectionReusableView()

@property(nonatomic,copy)NSString * url;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end

@implementation YXHSectionHeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHeaderImageName:(NSString *)headerImageName
{
    [self.headerImageView setCircleImageViewWithImageName:headerImageName];
}

- (void)setTitle:(NSString *)title
{
    [self.titleLabel setText:title];
}

- (void)setSectionIndex:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
    {
        self.moreButton.hidden = NO;
        self.url = @"http://bangumi.bilibili.com/api/timeline_v4?actionKey=appkey&appkey=27eb53fc9058f8c3&area_id=2%2C1%2C-1&build=4000&device=phone&mobi_app=iphone&platform=ios&see_mine=0&sign=abc768d13ede7289ff11d405c254426c&ts=1480485067";
    }
    else if (sectionIndex == 1)
    {
        self.moreButton.hidden = NO;
        self.url = @"http://bangumi.bilibili.com/api/season_group.json?build=4000&device=phone&mobi_app=iphone&platform=ios";
    }
    else
    {
        self.moreButton.hidden = YES;
    }
}
- (IBAction)More:(UIButton *)sender {
    NSLog(@"%@",self.url);
}

@end
