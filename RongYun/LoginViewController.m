//
//  LoginViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/10/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubviews];
}

- (void)configSubviews
{
    [super configSubviews];
    [self.view sendSubviewToBack:self.errorView];
    [self.view bringSubviewToFront:self.m_scrollView];
    self.title = @"用户登录";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"general_icon_back.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"general_icon_back_highlight.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    [self.accountField createLeftImageView:@"login_ima_iphone"];
    [self.passwordField createLeftImageView:@"login_ima_pws"];
}
#pragma mark - Action

- (void)backClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tapErrorAction:(UITapGestureRecognizer *)gesture
{
    [self.view sendSubviewToBack:self.errorView];
    [self.view bringSubviewToFront:self.m_scrollView];
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
