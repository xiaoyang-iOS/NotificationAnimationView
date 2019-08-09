//
//  NotificationAnimationView.h
//  NotificationAnimationView
//
//  Created by xiāo yáng on 2019/8/9.
//  Copyright © 2019 ccb. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// 判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_X_PHONE IS_IPHONE_X||IS_IPHONE_Xr||IS_IPHONE_Xs||IS_IPHONE_Xs_Max
#define XNavHeight     (CGFloat)(IS_X_PHONE?(88.0):(64.0))

@protocol NotificationAnimationViewDelegate <NSObject>

@optional
-(void)StartNotificationAnimation;
-(void)EndNotificationAnimation;

@end



@interface NotificationAnimationView : UIVisualEffectView<CAAnimationDelegate>

@property (nonatomic , weak) id<NotificationAnimationViewDelegate> delegate;

@property (nonatomic, strong) UIView *NotificationView;

@property (nonatomic , strong) UILabel *TitleLabel;

@property (nonatomic , strong) UILabel *ContentLabel;

@property (nonatomic , strong) UIImageView *IconImg;

@property (nonatomic , assign) CGRect ContentRect;

-(void)ShowNoticeAnimationView:(NSString *)noticeTitle NoticeContent:(NSString *)content AnimationTime:(CGFloat)animationTime FixedHeight:(BOOL)fixHeight;

@end

