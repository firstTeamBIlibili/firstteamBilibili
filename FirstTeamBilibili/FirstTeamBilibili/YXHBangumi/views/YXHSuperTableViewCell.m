//
//  YXHSuperTableViewCell.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHSuperTableViewCell.h"
#import "UIImageView+YXHCycle.h"

@interface YXHSuperTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property(nonatomic,copy)NSString * playCount;
@end

@implementation YXHSuperTableViewCell

- (void)setModel:(YXHSuperModel *)model
{
    _model = model;
    [self.coverImageView setRoundedImageViewWithUrl:model.cover];
    self.titleLabel.text = model.title;
    self.nameLabel.text = [NSString stringWithFormat:@"UP主:%@",model.name];
    self.playCountLabel.text = self.playCount;
}

- (NSString *)playCount
{
    if (_model.play >= 10000)
    {
        return [NSString stringWithFormat:@"播放:%.1f万",_model.play / 10000.0];
    }else
    {
        return [NSString stringWithFormat:@"播放:%ld",_model.play];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
