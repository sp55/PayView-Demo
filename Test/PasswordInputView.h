//
//  PasswordInputView.h
//  Test
//
//  Created by admin on 16/1/28.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordInputView : UIView
+ (instancetype)inputView;

@property (nonatomic,assign) NSInteger places;

// 输入完成回调block
@property (nonatomic,copy) void(^InputViewDidCompletion)(NSString *text);

- (void)beginInput;
- (void)endInput;


@end
