//
//  AppDelegate.m
//  WidgetLearn
//
//  Created by 孙道慧 on 2016/10/26.
//  Copyright © 2016年 孙道慧. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "AllClassViewController.h"
#import "MyViewController.h"
#import "ListViewController.h"
#import "DetailViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    // 初始化tabbar
    UITabBarController *tabbarVc = [[UITabBarController alloc] init];
    // 创建子试图
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    homeVc.title = @"首页";
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:homeVc];
    nav1.navigationBar.translucent = NO;
    nav1.tabBarItem.title = @"首页";
    nav1.tabBarItem.image = [UIImage imageNamed:@"icon_home"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_home_select"];
    
    AllClassViewController *classVc = [[AllClassViewController alloc] init];
    classVc.title = @"全部分类";

    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:classVc];
    nav2.navigationBar.translucent = NO;
    nav2.tabBarItem.title = @"分类";
    nav2.tabBarItem.image = [UIImage imageNamed:@"icon_allService"];
    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_allService_selected"];
    
    MyViewController *myVc = [[MyViewController alloc] init];
    myVc.title = @"个人中心";
    
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:myVc];
    nav3.tabBarItem.title = @"我的";
    nav3.tabBarItem.image = [UIImage imageNamed:@"icon_my"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_my_select"];
    nav3.navigationBar.translucent = NO;
    
    tabbarVc.viewControllers = @[nav1,nav2,nav3];
    tabbarVc.delegate = self;
    tabbarVc.tabBar.tintColor = [UIColor orangeColor];
    self.currentTabbar = tabbarVc;
    
    self.window.rootViewController = tabbarVc;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    NSString *prefix = @"TodayTest://action=";
    NSString *urlStr = [url absoluteString];
    UIViewController *tempVc = [self currentViewController];
    
    if ([urlStr containsString:prefix]) {
        NSLog(@"host = %@",url.host);
        NSString *tempStr = [urlStr substringFromIndex:[urlStr rangeOfString:prefix].length];
        if ([tempStr isEqualToString:@"homeVc1"]) {
            // 跳转到第一个vc
            ListViewController *vc = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
            tempVc.hidesBottomBarWhenPushed = YES;
            [tempVc.navigationController pushViewController:vc animated:YES];
            
        } else if ([tempStr isEqualToString:@"homeVc2"]){
            // 跳转到第二个vc
            self.currentTabbar.selectedIndex = 1;
        } else if ([tempStr isEqualToString:@"homeVc3"]){
            // 跳转到第三个vc
            DetailViewController *vc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
            tempVc.hidesBottomBarWhenPushed = YES;
            [tempVc.navigationController pushViewController:vc animated:YES];
        }
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
}

-(UIViewController *)currentViewController{
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}


@end
