//
//  LoginViewController.m
//  FirstTeamBilibili
//
//  Created by wyzc03 on 16/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "LoginViewController.h"
#import "Wilddog.h"
#define kWilddogUrl @"https://lovelysingledogbilibilidanmu.wilddogio.com/?_ga=1.166367742.1931681422.1481096485"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *leftImageV;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageV;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (nonatomic,strong) WDGSyncReference *wilddog;
//用来显示弹幕的View
@property (weak, nonatomic) IBOutlet UIView *wordsView;

@property (nonatomic,strong) NSMutableArray *snaps;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _passWordTextField.delegate = self;
    
    //初始化 WDGApp
    WDGOptions *option = [[WDGOptions alloc] initWithSyncURL:kWilddogUrl];
    [WDGApp configureWithOptions:option];
    //获取一个指向根节点的 WDGSyncReference 实例
    _wilddog = [[WDGSync sync] reference];
    
    _snaps = [[NSMutableArray alloc] init];
    
    [self.wilddog observeEventType:WDGDataEventTypeChildAdded withBlock:^(WDGDataSnapshot *snapshot) {
        
        [self sendLabel:snapshot];
        [self.snaps addObject:snapshot];
        
    }];
    
    
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)timer
{
    if (_snaps.count < 2) {
        return;
    }
    int index = arc4random()%(self.snaps.count-1);
    WDGDataSnapshot *snapshot = [self.snaps objectAtIndex:index];
    [self sendLabel:snapshot];
}

- (UILabel *)sendLabel:(WDGDataSnapshot *)snapshot
{
    float top = (arc4random()% (int)self.wordsView.frame.size.height)-100;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width, top, 100, 30)];
    label.textColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
    label.text = snapshot.value;
    [label sizeToFit];
    
    [UIView animateWithDuration:7 animations:^{
        label.frame = CGRectMake(-label.frame.size.width, top, label.frame.size.width, 30);
    }completion:^(BOOL finished){
        [label removeFromSuperview];
    }];
    [self.wordsView addSubview:label];
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    
    [[self.wilddog childByAutoId]setValue:_passWordTextField.text];
    
    [aTextField setText:@""];
    return NO;
}

#pragma mark - Keyboard handling


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    if ([_passWordTextField isFirstResponder]) {
        [_passWordTextField resignFirstResponder];
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _leftImageV.image = [UIImage imageNamed:@"闭眼.jpg"];
    _rightImageV.image = [UIImage imageNamed:@"闭眼.jpg"];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _leftImageV.image = [UIImage imageNamed:@"滑稽.jpg"];
    _rightImageV.image = [UIImage imageNamed:@"滑稽.jpg"];

}
- (IBAction)registAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)loginAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
