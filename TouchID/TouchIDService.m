//
//  TouchIDService.m
//  SmartHome
//
//  Created by 卓哥的世界你不懂 on 14/11/26.
//  Copyright (c) 2014年 lex. All rights reserved.
//

#import "TouchIDService.h"
#import <LocalAuthentication/LocalAuthentication.h>
@implementation TouchIDService
+(instancetype)authenticateUserWithReasonString:(NSString *)reasonStr successful:(void (^)())successful authenticatePassword:(void (^)(NSString *password))password cancel:(void (^)())cancel
{
    TouchIDService *touchid = [[TouchIDService alloc]initWithReasonString:reasonStr successful:successful authenticatePassword:password cancel:cancel];
    return touchid;
}

-(instancetype)initWithReasonString:(NSString *)reasonStr successful:(void (^)())successful authenticatePassword:(void (^)(NSString *))password cancel:(void (^)())cancel
{
    if (self == [super init]) {
        self.reasonSting = reasonStr;
        self.replyBlock = successful;
        self.cancelBlock = cancel;
        self.passwordBlock = password;
        [self authenticate];
    }
    return self;
}

-(void)authenticate
{
    LAContext *context =[[LAContext alloc]init];
    NSError *error = nil;
    if (!self.reasonSting) {
        self.reasonSting = @"输入TouchID";
    }
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:self.reasonSting reply:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(self.replyBlock)
                    {
                        self.replyBlock();
                        
                    }
                });
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    switch (error.code) {
                        case LAErrorSystemCancel:
                            //程序退出
                            if (self.cancelBlock) {
                                self.cancelBlock();
                                
                            }
                            break;
                        case LAErrorUserCancel:
                            //用户退出
                            if (self.cancelBlock) {
                                self.cancelBlock();
                                
                            }
                            break;
                        case LAErrorUserFallback:
                            //用户选择输入密码
                            
                            [self showPasswordAlert];
                            break;
                        default:
                            [self showPasswordAlert];
                            
                            break;
                    }
                });
    
 
            }
        }];
    }else
    {
        [self showPasswordAlert];
    }
    
}

-(void)showPasswordAlert
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"密码验证" message:@"请输出密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.passwordBlock) {
        self.passwordBlock([alertView textFieldAtIndex:0].text);
        self.passwordBlock = nil;
    }
}
@end

