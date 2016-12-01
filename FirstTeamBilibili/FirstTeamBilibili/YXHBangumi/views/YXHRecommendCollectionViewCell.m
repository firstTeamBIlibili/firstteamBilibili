//
//  YXHRecommendCollectionViewCell.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/1.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHRecommendCollectionViewCell.h"
#import "UIImageView+YXHCycle.h"

@interface YXHRecommendCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;



@end

@implementation YXHRecommendCollectionViewCell

- (void)setModel:(YXHRecommendModel *)model
{
    [self.coverImageView setRoundedImageViewWithUrl:model.cover];
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
