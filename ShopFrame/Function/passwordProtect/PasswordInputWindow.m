//
//  PasswordInputWindow.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/7.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "PasswordInputWindow.h"

@implementation PasswordInputWindow
{
    UITextField *_textField;
}


+ (PasswordInputWindow *)shareInstance
{
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    });
    return shareInstance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 200, 20)];
        label.text = @"请输入密码";
        [self addSubview:label];
        
        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 200, 20)];
        textFiled.backgroundColor = [UIColor whiteColor];
        textFiled.secureTextEntry = YES;
        [self addSubview:textFiled];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 110, 200, 44)];
        [button setBackgroundColor:[UIColor blueColor]];
        button.titleLabel.textColor = [UIColor blackColor];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(completeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.backgroundColor = [UIColor yellowColor];
        _textField = textFiled;
        
        
    }
    return self;
}

- (void)show
{
    [self makeKeyWindow];
    _textField.text = @"";
    self.hidden = NO;
}

- (void)completeButtonPressed:(id)sender
{
    if ([_textField.text isEqualToString:@"1234"]) {
        [_textField resignFirstResponder];
        self.hidden = YES;
    } else {
        [self showErrorAlertView];
    }
    
}
- (void)showErrorAlertView
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"nil" message:@"密码错误" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertView addAction:cancelAction];
    [alertView addAction:yesAction];
}
@end
