//
//  NotificationAnimationView.m
//  NotificationAnimationView
//
//  Created by xiāo yáng on 2019/8/9.
//  Copyright © 2019 ccb. All rights reserved.
//

#import "NotificationAnimationView.h"

@implementation NotificationAnimationView

-(instancetype)initWithEffect:(UIVisualEffect *)effect
{
    
    if (self = [super initWithEffect:effect]) {
        self.frame=CGRectMake(7.5, -80, SCREEN_WIDTH-15, 80);
        //添加阴影效果
        self.layer.shadowRadius=0.5f;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowOpacity = 0.7;
        //self.layer.shadowColor=[[UIColor whiteColor] CGColor];
        [self.contentView addSubview:self.NotificationView];
        for (UIView *subview in self.subviews) {
            subview.layer.cornerRadius = 10.0f;
        }
    }
    return self;
}
-(UIView *)NotificationView
{
    if (!_NotificationView) {
        _NotificationView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-15, 80)];
    }
    _NotificationView.backgroundColor=[UIColor clearColor];
    _NotificationView.layer.cornerRadius=10.0f;
    UILabel *appName=[[UILabel alloc]initWithFrame:CGRectMake(35, 13, 100, 10)];
    appName.text=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    appName.textColor=[UIColor darkTextColor];
    appName.font=[UIFont fontWithName:@"STHeitiSC-Light" size:12];
    [_NotificationView addSubview:appName];
    
    UILabel *nowBtn=[[UILabel alloc]initWithFrame:CGRectMake(_NotificationView.frame.size.width-40, 13, 30, 10)];
    nowBtn.text=@"现在";
    nowBtn.textColor=[UIColor darkTextColor];
    nowBtn.font=[UIFont fontWithName:@"STHeitiSC-Light" size:12];
    [_NotificationView addSubview:nowBtn];
    [_NotificationView addSubview:self.IconImg];
    [_NotificationView addSubview:self.TitleLabel];
    [_NotificationView addSubview:self.ContentLabel];
    return _NotificationView;
}
-(UIImageView *)IconImg
{
    if (!_IconImg) {
        _IconImg=[[UIImageView alloc]init];
    }
    _IconImg.image=[UIImage imageNamed:@"AppIcon"];
    _IconImg.frame=CGRectMake(10, 9, 18, 18);
    _IconImg.layer.cornerRadius=2.0f;
    return _IconImg;
}
-(UILabel *)TitleLabel
{
    if(!_TitleLabel)
    {
        _TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 200, 20)];
    }
    _TitleLabel.font=[UIFont boldSystemFontOfSize:14];
    
    return _TitleLabel;
    
}

-(UILabel *)ContentLabel
{
     if(!_ContentLabel)
     {
         _ContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-35, 20)];
     }
    _ContentLabel.font=[UIFont systemFontOfSize:14];
    return _ContentLabel;
}
-(void)ShowNoticeAnimationView:(NSString *)noticeTitle NoticeContent:(NSString *)content AnimationTime:(CGFloat)animationTime FixedHeight:(BOOL)fixHeight{
    self.TitleLabel.text=noticeTitle;
    [self ReSetAllFramesWith:content FixedHeight:fixHeight];
    [self NoticeViewAnimation:animationTime];
    
}
//动态计算高度
-(void)ReSetAllFramesWith:(NSString *)content FixedHeight:(BOOL)fixHeight
{
    _ContentLabel.text=content;
    if (fixHeight) {
        _ContentLabel.lineBreakMode=NSLineBreakByCharWrapping;
        _ContentLabel.numberOfLines=0;
        NSRange allRange = [_ContentLabel.text rangeOfString:_ContentLabel.text];
        NSMutableParagraphStyle *tempParagraph = [[NSMutableParagraphStyle alloc] init];
        tempParagraph.lineSpacing = 0;
        tempParagraph.firstLineHeadIndent = 0.f;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_ContentLabel.text];
        [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:tempParagraph} range:allRange];
        _ContentRect = [attrStr boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        _ContentLabel.frame = CGRectMake(10, 50, SCREEN_WIDTH-35, _ContentRect.size.height);
        _ContentLabel.attributedText = attrStr;
        self.frame=CGRectMake(7.5, -(60+_ContentRect.size.height), SCREEN_WIDTH-15, 60+_ContentRect.size.height);
        _NotificationView.frame=CGRectMake(0, 0, SCREEN_WIDTH-15, 60+_ContentRect.size.height);
    }
}

-(void)NoticeViewAnimation:(CGFloat)animationTime{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, -(60+_ContentRect.size.height))];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, XNavHeight)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, XNavHeight)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, XNavHeight)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, XNavHeight)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, -(60+_ContentRect.size.height))];
    anima.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    anima.duration = animationTime;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//设置动画的节奏
    anima.delegate = self;//设置代理，可以检测动画的开始和结束
    [self.layer addAnimation:anima forKey:@"keyFrameAnimation"];
    
}
#pragma mark - 通知动画delegate方法
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"开始动画");
    [self.delegate StartNotificationAnimation];
   
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"结束动画");
    [self.delegate EndNotificationAnimation];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
