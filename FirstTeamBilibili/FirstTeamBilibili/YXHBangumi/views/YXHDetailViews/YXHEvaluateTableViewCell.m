//
//  YXHEvaluateTableViewCell.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/7.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHEvaluateTableViewCell.h"
#import "YXHDetailTag.h"

@interface YXHEvaluateTableViewCell()
@property(nonatomic,strong)UILabel * evaluateLabel;
@property(nonatomic,strong)UIView * tagView;
@property(nonatomic,strong)NSMutableArray * tagArr;

@end

@implementation YXHEvaluateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 20)];
        label.text = @"简介";
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        
        
    }
    return self;
}

- (void)setEvaluate:(NSString *)evaluate
{
    if (_evaluate == evaluate) return;
    if (_evaluateLabel)
    {
        _evaluateLabel.text = evaluate;
        return;
    }
    
    _evaluateLabel = [[UILabel alloc] init];
    //_evaluateLabel.backgroundColor = [UIColor redColor];
    _evaluateLabel.numberOfLines = 0;
    _evaluateLabel.font = [UIFont systemFontOfSize:13];
    _evaluateLabel.text = evaluate;
    _evaluateLabel.x = 10;
    _evaluateLabel.y = 30;
    _evaluateLabel.width = self.width - 20;
    //[_evaluateLabel sizeToFit];
    _evaluateLabel.height = 60;
    _evaluateLabel.textColor = [UIColor darkGrayColor];
    
    [self.contentView addSubview:_evaluateLabel];
}

- (void)setTags:(NSArray *)tags
{
    if (_tags == tags) return;
    
    _tags = tags;
    [_tagView removeFromSuperview];
    
    _tagView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_evaluateLabel.frame) + 10, self.width - 20, 30)];
    [self.contentView addSubview:_tagView];
    for (int i = 0; i < tags.count; i ++)
    {
        YXHDetailTag * tag = tags[i];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.width = 40;
        button.height = 20;
        button.x = (button.width + 10) * i;
        button.y = 0;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:tag.tag_name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.layer.cornerRadius = 10;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [button addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tagArr addObject:button];
        [_tagView addSubview:button];
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
- (NSMutableArray *)tagArr
{
    if (!_tagArr)
        _tagArr = [NSMutableArray array];
    return _tagArr;
}

- (void)tagClick:(UIButton *)button
{
    NSInteger index = [self.tagArr indexOfObject:button];
    YXHDetailTag * tag = self.tags[index];
    NSLog(@"%@",tag.tag_name);
}
@end
