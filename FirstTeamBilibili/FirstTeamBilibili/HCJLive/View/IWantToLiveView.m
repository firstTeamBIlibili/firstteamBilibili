//
//  IWantToLiveView.m
//  FirstTeamBilibili
//
//  Created by wyzc03 on 16/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "IWantToLiveView.h"
#import "LoginViewController.h"
#import "HCJLiveViewController.h"
@interface IWantToLiveView ()

@end

@implementation IWantToLiveView
- (IBAction)buttonAction:(UIButton *)sender {
    
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    
    HCJLiveViewController * liveVC = (HCJLiveViewController *)self.superview.nextResponder;
    [liveVC.navigationController pushViewController:loginVC animated:YES];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
