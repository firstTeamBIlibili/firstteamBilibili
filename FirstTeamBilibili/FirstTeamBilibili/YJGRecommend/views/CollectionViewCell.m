//
//  CollectionViewCell.m
//  recommend
//
//  Created by yuanjiangang on 2016/11/30.
//  Copyright © 2016年 WYZC. All rights reserved.
//
#import "CollectionViewCell.h"
@implementation CollectionViewCell

-(void)setModels:(collectionModel *)models{
    
    _models=models;

    self.lablele.text=[NSString stringWithFormat:@"%@",models.title];
    
    
//    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:models.title];
//    [str addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}range:NSMakeRange(0, str.length)];
    
    
    self.lable.textColor=[UIColor whiteColor];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:models.cover]];
     self.leftlable.text=[NSString stringWithFormat:@"%ld",(long)models.play];
     self.rightLable.text=[NSString stringWithFormat:@"%ld",(long)models.danmaku];
}@end
