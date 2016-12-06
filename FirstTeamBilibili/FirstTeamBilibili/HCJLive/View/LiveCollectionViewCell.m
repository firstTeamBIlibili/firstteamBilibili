//
//  LiveCollectionViewCell.m
//  Project3
//
//  Created by wyzc03 on 16/11/30.
//  Copyright © 2016年 wyzc03. All rights reserved.
//

#import "LiveCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface LiveCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *srcImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;

@end

@implementation LiveCollectionViewCell
- (void)awakeFromNib{
    [super awakeFromNib];
    self.area = NO;
}


////设置边框线
//- (void)drawRect:(CGRect)rect{
//    
//    
//    CGFloat width = rect.size.width;
//    CGFloat height = rect.size.height;
//    
//    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, width / 2) radius:width / 2 startAngle:0 endAngle:M_PI clockwise:NO];
//    
//    UIBezierPath * path2 = [UIBezierPath bezierPath];
//    
//    [path2 moveToPoint:CGPointMake(0, width / 2)];
//    [path2 addLineToPoint:CGPointMake(0, height)];
//    [path2 addLineToPoint:CGPointMake(width, height)];
//    [path2 addLineToPoint:CGPointMake(width, width / 2)];
//    
//    
//    [path appendPath:path2];
//    
//    CAShapeLayer * maskLayer = [CAShapeLayer layer];
//    
//    maskLayer.lineWidth = 1;
//    
//    maskLayer.path = path.CGPath;
//    
//    self.layer.mask = maskLayer;
//    
//    /*
//    UIBezierPath * path = [UIBezierPath bezierPathWithRect:rect];
//
//    path.lineWidth = 2;
//    
//    [[UIColor yellowColor] setStroke];
//    
//    [path stroke];
//    
//    UIBezierPath * path1 = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
//    CAShapeLayer * maskLayer = [CAShapeLayer layer];
//    
//    maskLayer.path = path1.CGPath;
//    
//    
//    self.layer.mask = maskLayer;
//     */
//    
//    
//    //NSLog(@"draw rect");
//}


- (void)setModel:(LiveModel *)model{
    _model = model;
    //设置大图片
    [self.srcImageView sd_setImageWithURL:[NSURL URLWithString:model.src]];
    //设置title//根据area设置title是否显示区域标题
    if (self.area) {
        NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:model.title];
        
        NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"#%@#",model.area]];
        
        [str1 addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, str1.length)];
        
        [str insertAttributedString:str1 atIndex:0];
        
        self.titleLabel.attributedText = str;
    }else{
        self.titleLabel.text = model.title;
    }
    
    self.nameLabel.text = model.name;
    self.onlineLabel.text = [NSString stringWithFormat:@"%ld",model.online];
}




@end
























