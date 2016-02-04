//
//  PayView.h
//  Test
//
//  Created by admin on 16/1/28.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PayViewCompletion)(NSString *password);

@interface PayView : UIView

// 密码输入框位数（默认6位）
@property (nonatomic,assign) NSInteger places;

@property (nonatomic,copy) void (^exitBtnClicked)();

- (instancetype)initWithMoney:(CGFloat)money cardMessage:(NSString *)cardMessage completion:(PayViewCompletion)completion;

- (void)show;
- (void)hidden;

@end
