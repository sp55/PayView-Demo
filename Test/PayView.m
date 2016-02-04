//
//  PayView.m
//  Test
//
//  Created by admin on 16/1/28.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "PayView.h"
#import "PasswordInputView.h"
@interface PayView ()
//260 40
@property (weak, nonatomic) IBOutlet PasswordInputView *inputView;

@property (nonatomic,copy) PayViewCompletion completion;
@property (nonatomic,copy) NSString *cardMessage;
@property (nonatomic,assign) CGFloat money;
@property (nonatomic,strong) UIView *cover;
@end

@implementation PayView
- (instancetype)initWithMoney:(CGFloat)money cardMessage:(NSString *)cardMessage completion:(PayViewCompletion)completion{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"PayView" owner:nil options:nil] lastObject];
    
    if (self == nil) {
        return nil;
    }
    
    _cardMessage = cardMessage;
    _completion = completion;
    
    [self setupContents];
    
    return self;
}
- (void)awakeFromNib{
    self.layer.cornerRadius = 10;
    // 默认6位
    self.inputView.places = 6;
}

- (void)setupContents{

    __weak typeof(self) weakSelf = self;
    self.inputView.InputViewDidCompletion = ^(NSString *text){
        if (weakSelf.completion) {
            weakSelf.completion(text);
        }
    };
}



- (IBAction)sureAction:(id)sender {
    if (self.exitBtnClicked) {
        self.exitBtnClicked();
    }
}

- (void)show{
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.cover];
    [window addSubview:self];
    
    // 设置微信支付界面出现动画及位置
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.cover.alpha = 1;
        self.alpha = 1;
    }];
    self.center = CGPointMake(window.center.x, (window.frame.size.height - 216) * 0.5);
    
    // 适配小屏幕
    if (window.frame.size.width == 320) {
        self.bounds = CGRectMake(0, 0, self.bounds.size.width * 0.9, self.bounds.size.height);
    }
    
    // 弹出键盘
    [self.inputView beginInput];
}

- (void)hidden{
    
    // 设置微信支付界面消失动画
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeScale(0.6, 0.6);
        self.alpha = 0;
        self.cover.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.cover removeFromSuperview];
    }];
    
    // 退下键盘
    [self.inputView endInput];
}

- (UIView *)cover{
    if (_cover == nil) {
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        _cover = [[UIView alloc] initWithFrame:window.bounds];
        CGFloat rgb = 83 / 255.0;
        _cover.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.7];
        _cover.alpha = 0;
    }
    return _cover;
}



@end
