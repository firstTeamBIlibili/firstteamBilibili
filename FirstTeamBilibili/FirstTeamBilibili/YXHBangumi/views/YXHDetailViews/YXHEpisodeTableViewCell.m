//
//  YXHEpisodeTableViewCell.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/7.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHEpisodeTableViewCell.h"
#import "YXHDetailepisode.h"

@interface YXHEpisodeTableViewCell()

@property(nonatomic,assign)NSInteger previousSelectedIndex;
@property(nonatomic,strong)NSMutableArray * buttons;

@end
@implementation YXHEpisodeTableViewCell

- (void)setEpisodes:(NSArray *)episodes
{
    if (_episodes == episodes) return;
    
    _episodes = episodes;
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    [self.buttons removeAllObjects];
    
    //选集标签
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 30, 20)];
    label.text = @"选集";
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    
    
    //最新更新标签
    YXHDetailepisode * episode = episodes.firstObject;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:[NSString stringWithFormat:@"更新至 %@",episode.index] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button sizeToFit];
    CGFloat buttonW = button.frame.size.width;
    button.y = 40;
    button.x = self.width - buttonW - 10;
    [self.contentView addSubview:button];
    
    
    CGFloat scrollW = episodes.count * (120 + 10) - 10;
    UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 70, self.width - 10 * 2, 50)];
    [self.contentView addSubview:scroll];
    scroll.contentSize = CGSizeMake(scrollW, 50);
    scroll.bounces = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    
    //添加选集按钮
    for (NSInteger i = episodes.count - 1; i >= 0; i --)
    {
        YXHDetailepisode * episode = episodes[episodes.count - i - 1];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(i * (120 + 10), 0, 120, 50);
        button.titleLabel.numberOfLines = 3;
        [button setTitle:[NSString stringWithFormat:@"%@\n%@",episode.index,episode.index_title] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [button addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        [scroll addSubview:button];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (NSArray *)buttons
{
    if (!_buttons)
        _buttons = [NSMutableArray array];
    return _buttons;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)play:(UIButton *)button
{
    self.previousSelectedIndex = [self.buttons indexOfObject:button];
    YXHDetailepisode * episode = self.episodes[self.previousSelectedIndex];
    
    NSString * url = [NSString stringWithFormat:@"http://bangumi.bilibili.com/anime/v/%@",episode.av_id];
    NSLog(@"%@",url);
    
}

@end
