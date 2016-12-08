//
//  YXHCommentTableViewCell.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/7.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHCommentTableViewCell.h"
#import "UIImageView+YXHCycle.h"

@interface YXHCommentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *levelImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *countButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation YXHCommentTableViewCell

- (void)setModel:(YXHCommentModel *)model
{
    [self.avatarImageView setCircleImageViewWithUrl:model.member.avatar];
    self.levelImageVIew.image = [UIImage imageNamed:[NSString stringWithFormat:@"misc_level_whiteLv%@",model.member.level_info[@"current_level"]]];
    
    self.nameLabel.text = model.member.uname;
    self.floorLabel.text = [NSString stringWithFormat:@"#%ld",model.floor];
    self.timeLabel.text = model.ctime;
    [self.countButton setTitle:[NSString stringWithFormat:@"%ld",model.count] forState:UIControlStateNormal];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",model.like] forState:UIControlStateNormal];
    self.contentLabel.text = model.content[@"message"];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)more:(id)sender {
}

@end
