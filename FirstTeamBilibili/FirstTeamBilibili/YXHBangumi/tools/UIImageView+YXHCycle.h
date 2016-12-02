//
//  UIImageView+YXHCycle.h
//  FirstTeamBilibili
//
//  Created by 颜晓卉 on 2016/12/1.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YXHCycle)
- (void)setCircleImageViewWithImageName:(NSString *)imageName;
- (void)setCircleImageViewWithUrl:(NSString *)url;
- (void)setRoundedImageViewWithUrl:(NSString *)url;
@end
