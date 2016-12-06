//
//  AnimationButton.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/2.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "AnimationButton.h"

@implementation AnimationButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 5;
    self.titleLabel.width = self.width;
    
    

}

@end
