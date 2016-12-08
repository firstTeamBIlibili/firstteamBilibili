//
//  YXHTimeListCollectionViewCell.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/8.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHTimeListCollectionViewCell.h"
#import "UIImageView+YXHCycle.h"

@interface YXHTimeListCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *ontimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageHeight;

@end
@implementation YXHTimeListCollectionViewCell
- (void)setModel:(YXHTimeListModel *)model
{
    if (_model == model) return;
    
    _model = model;
    [self.coverImageView setRoundedImageViewWithUrl:model.cover];
    self.ontimeLabel.text = model.ontime;
    self.titleLabel.text = model.title;
    self.indexLabel.text = [NSString stringWithFormat:@"第 %@ 话",model.ep_index];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];

}

@end
