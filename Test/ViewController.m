//
//  ViewController.m
//  Test
//
//  Created by admin on 16/1/28.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#define kScreen_Width      [UIScreen mainScreen].bounds.size.width
#define kScreen_Height      [UIScreen mainScreen].bounds.size.height


#import "ViewController.h"
#import "PayView.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    PayView *view = [[PayView alloc] initWithMoney:188.88 cardMessage:@"使用XX银行支付." completion:^(NSString *password) {
        
        NSLog(@"输入的密码是%@",password); // 密码输入完成回调
        // doSomething....
        }];
    
    __weak PayView *weakView = view;
    view.exitBtnClicked = ^{ // 点击了退出按钮
        NSLog(@"点击了退出按钮");
        [weakView hidden];
    };
    
    
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
