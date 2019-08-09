//
//  FirstViewController.m
//  NotificationAnimationView
//
//  Created by xiāo yáng on 2019/8/8.
//  Copyright © 2019 ccb. All rights reserved.
//

#import "FirstViewController.h"
#import "CoreStatus.h"
#import "NotificationAnimationView.h"

@interface FirstViewController ()<CoreStatusProtocol,NotificationAnimationViewDelegate>
@property (nonatomic , strong) NotificationAnimationView *notificationAnimationView;

@end

@implementation FirstViewController
@synthesize currentStatus;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [CoreStatus beginNotiNetwork:self];
}
-(void)coreNetworkChangeNoti:(NSNotification *)noti{
    
    NSString * statusString = [CoreStatus currentNetWorkStatusString];
    if([statusString isEqualToString:@"无网络"]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.notificationAnimationView ShowNoticeAnimationView:@"当前网络中断" NoticeContent:@"请检查你的网络连接，打开无线网络或者移动数据网络" AnimationTime:4.0 FixedHeight:NO];
        });
        
    }else
    {
        //do...
    }
  NSLog(@"%@\n\n\n\n=========================\n\n\n\n%@",noti,statusString);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor purpleColor];
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
    
    CoreNetWorkStatus currentNetStatus=[CoreStatus currentNetWorkStatus];
    NSLog(@"当前网络状态：======= %u",currentNetStatus);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.notificationAnimationView ShowNoticeAnimationView:@"苹果官方通知" NoticeContent:@"你好，你做的通知和我们的通知相似度接近100%,中国民生银行，招商银行，河北银行，包商银行，大家保险以及21世纪不动产送来贺电！" AnimationTime:4.0 FixedHeight:NO];
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
