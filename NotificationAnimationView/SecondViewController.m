//
//  SecondViewController.m
//  NotificationAnimationView
//
//  Created by xiāo yáng on 2019/8/8.
//  Copyright © 2019 ccb. All rights reserved.
//

#import "SecondViewController.h"
#import "NotificationAnimationView.h"

@interface SecondViewController ()<NotificationAnimationViewDelegate>
@property (nonatomic , strong) NotificationAnimationView *notificationAnimationView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor systemGreenColor];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    if (!_notificationAnimationView) {
        _notificationAnimationView = [[NotificationAnimationView alloc]initWithEffect:effect];
    }
    _notificationAnimationView.delegate=self;
    [self.view addSubview:_notificationAnimationView];
    
    // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.notificationAnimationView ShowNoticeAnimationView:@"苹果官方通知" NoticeContent:@"你好，你做的通知和我们的通知相似度接近100%,中国民生银行，招商银行，河北银行，包商银行，大家保险以及21世纪不动产送来贺电！" AnimationTime:4.0 FixedHeight:YES];
    });
    
}
#pragma mark - delegate
-(void)StartNotificationAnimation
{
    NSLog(@"+++++++++++++++++++++++");
}
-(void)EndNotificationAnimation
{
    NSLog(@"-----------------------");
}
@end
