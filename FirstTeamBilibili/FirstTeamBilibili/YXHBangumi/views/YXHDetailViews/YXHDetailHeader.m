//
//  YXHDetailHeader.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/6.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHDetailHeader.h"
#import "UIImageView+YXHCycle.h"
#import <Accelerate/Accelerate.h> 

@interface YXHDetailHeader()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;


@end

@implementation YXHDetailHeader

- (void)setModel:(YXHDetailModel *)model
{
    //self.backgroundColor = [UIColor redColor];
    [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:model.cover] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        effectView.frame = CGRectMake(0, 0, WIDTH, 150);
        [self.backgroundImage addSubview:effectView];
    }];
    [self.coverImageView setRoundedImageViewWithUrl:model.cover];
    self.titleLabel.text = model.bangumi_title;
    
    if (model.play_count >= 10000)
    {
        self.playCountLabel.text = [NSString stringWithFormat:@"播放:%.1f万",model.play_count / 10000.0];
    }else
    {
        self.playCountLabel.text = [NSString stringWithFormat:@"播放:%ld",model.play_count];
    }
    
    if (model.favorites >= 10000)
    {
        self.favoritesLabel.text = [NSString stringWithFormat:@"追番:%.1f万",model.favorites / 10000.0];
    }else
    {
        self.favoritesLabel.text = [NSString stringWithFormat:@"追番:%ld",model.favorites];
    }
}

@end
