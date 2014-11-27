//
//  ViewController.m
//  TouchID
//
//  Created by 卓哥的世界你不懂 on 14/11/27.
//  Copyright (c) 2014年 卓哥的世界你不懂. All rights reserved.
//

#import "ViewController.h"
#import "TouchIDService.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [TouchIDService authenticateUserWithReasonString:@"请触摸" successful:^{
     //验证成功
    } authenticatePassword:^(NSString *password) {
    //用户选择输入密码，在这个地方进行验证
    } cancel:^{
    //用户退出
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
