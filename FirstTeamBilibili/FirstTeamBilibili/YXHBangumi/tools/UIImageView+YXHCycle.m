//
//  UIImageView+YXHCycle.m
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/1.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "UIImageView+YXHCycle.h"
#import "UIImage+YXHCycle.h"

@implementation UIImageView (YXHCycle)

- (void)setCircleImageViewWithImageName:(NSString *)imageName
{
    self.image = [[UIImage imageNamed:imageName] circleImage];
}

- (void)setCircleImageViewWithUrl:(NSString *)url
{
    WeakSelf;
    UIImage * placeHolder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (self.image == nil)
        {
            return;
        }
        weakSelf.image = [image circleImage];
    }];
}

- (void)setRoundedImageViewWithUrl:(NSString *)url
{
    WeakSelf;
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (self.image == nil)
        {
            return;
        }
        weakSelf.layer.cornerRadius = 5;
        weakSelf.layer.masksToBounds = YES;
    }];
}
@end
