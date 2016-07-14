//
//  LoginVC.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/14.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "LoginVC.h"
#import "logTextField.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet logTextField *username;
@property (weak, nonatomic) IBOutlet logTextField *password;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)login:(id)sender {
    [[MusicAPI defaultManager] loginWithUsername:_username.text password:_password.text completeBlock:^(bool isSuccess, NSError *error) {
        if (isSuccess) {
            [self dismissViewControllerAnimated:true completion:nil];
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"糟糕" message:@"用户名或密码有问题！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self.navigationController.navigationController presentViewController:alert animated:true completion:nil];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
