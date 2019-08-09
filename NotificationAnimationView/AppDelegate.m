//
//  AppDelegate.m
//  NotificationAnimationView
//
//  Created by xiāo yáng on 2019/8/8.
//  Copyright © 2019 ccb. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController=[[FirstViewController alloc]init];
    return YES;
}




@end
