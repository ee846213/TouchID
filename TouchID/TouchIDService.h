//
//  TouchIDService.h
//  SmartHome
//
//  Created by 卓哥的世界你不懂 on 14/11/26.
//  Copyright (c) 2014年 lex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^successfulBlock)();
typedef void (^passwordBlock)();
typedef void (^cancelBlock)();
@interface TouchIDService : NSObject<UIAlertViewDelegate>
@property (strong,nonatomic)successfulBlock replyBlock;
@property (strong,nonatomic)passwordBlock passwordBlock;
@property (strong,nonatomic)cancelBlock cancelBlock;
@property (strong,nonatomic)NSString *reasonSting;
+(instancetype)authenticateUserWithReasonString:(NSString *)reasonStr successful:(void (^)())successful authenticatePassword:(void (^)(NSString *password))password cancel:(void (^)())cancel;
-(void)showPasswordAlert;
@end
