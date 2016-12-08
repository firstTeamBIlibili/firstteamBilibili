//
//  NewBangumiCollectionViewCell.m
//  bangumi
//
//  Created by 颜晓卉 on 2016/12/1.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHNewBangumiCollectionViewCell.h"
#import "UIImageView+YXHCycle.h"

@interface YXHNewBangumiCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *watching_countLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *newest_indexLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageVIewHeight;


@end

@implementation YXHNewBangumiCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(YXHNewBangumiModel *)model
{
    self.coverImageVIewHeight.constant = self.width * 1.2;
    
    [self.coverImageView setRoundedImageViewWithUrl:model.cover];
    self.watching_countLabel.text = [NSString stringWithFormat:@"%ld人在看",model.watching_count];
    self.titleLabel.text = model.title;
    
    
    if (model.is_finish == 1)
    {
        self.newest_indexLabel.hidden = YES;
    }else
    {
        self.newest_indexLabel.hidden = NO;
        self.newest_indexLabel.text = [NSString stringWithFormat:@"更新至第%@话",model.newest_ep_index];
    }
}

@end
