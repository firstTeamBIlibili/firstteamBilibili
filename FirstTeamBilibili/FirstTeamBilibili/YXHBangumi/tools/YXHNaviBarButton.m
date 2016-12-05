//
//  YXHNaviBarButton.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "YXHNaviBarButton.h"

@implementation YXHNaviBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = 0;
    self.titleLabel.y = 0;
    self.titleLabel.height = self.height;
    self.titleLabel.width = self.width * 2 / 3;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    self.imageView.y = 0;
    self.imageView.height = self.height;
    self.imageView.width = self.width - self.titleLabel.width;
    
    //[self.titleLabel sizeToFit];
}

@end
