//
//  LoginViewController.m
//  FirstTeamBilibili
//
//  Created by wyzc03 on 16/12/5.
//  Copyright © 2016年 WYZC. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *leftImageV;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageV;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _passWordTextField.delegate = self;
    
    
    
    // Do any additional setup after loading the view from its nib.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
