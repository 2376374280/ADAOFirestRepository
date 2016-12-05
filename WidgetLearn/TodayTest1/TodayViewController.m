//
//  TodayViewController.m
//  TodayTest1
//
//  Created by 孙道慧 on 2016/10/26.
//  Copyright © 2016年 孙道慧. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

// 屏幕的物理高度
#define  ScreenHeight  [UIScreen mainScreen].bounds.size.height

// 屏幕的物理宽度
#define  ScreenWidth   [UIScreen mainScreen].bounds.size.width

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation TodayViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    self.preferredContentSize = CGSizeMake(ScreenWidth, 110);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uploadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.adao.LearnWidget"];
    NSString *tempStr = [shared objectForKey:@"kDesc"];
    if (![self.topLabel.text isEqualToString:tempStr]) {
        completionHandler(NCUpdateResultNewData);
    } else {
        completionHandler(NCUpdateResultNoData);
    }

}

- (void)uploadData{
    // 方法一取出数据
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.adao.LearnWidget"];
    NSString *tempStr = [shared objectForKey:@"kDesc"];
    self.topLabel.text = tempStr;
    NSData *tempData = [shared objectForKey:@"kIcon"];
    UIImage *iconImg = [UIImage imageWithData:tempData];
    self.markImageView.image = iconImg;
    
    // 方法二取数据
    NSError *error = nil;
    NSURL *contrainerUrl = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.adao.LearnWidget"];
    contrainerUrl = [contrainerUrl URLByAppendingPathComponent:@"Library/Caches/test"];
    self.bottomLabel.text = [NSString stringWithContentsOfURL:contrainerUrl encoding:NSUTF8StringEncoding error:&error];
}

- (IBAction)jumpBtnAction:(id)sender {
    // 跳转vc1
    [self.extensionContext openURL:[NSURL URLWithString:@"TodayTest://action=homeVc1"] completionHandler:^(BOOL success){
        NSLog(@"====== open url result1: %d",success);
    }];
}

- (IBAction)bottomBtnAction:(id)sender {
    // 跳转vc2
    [self.extensionContext openURL:[NSURL URLWithString:@"TodayTest://action=homeVc2"] completionHandler:^(BOOL success){
        NSLog(@"====== open url result2: %d",success);
    }];
}

- (IBAction)jumpToVc3Action:(id)sender {
    // 跳转到vc3
    [self.extensionContext openURL:[NSURL URLWithString:@"TodayTest://action=homeVc3"] completionHandler:^(BOOL success){
        NSLog(@"====== open url result3: %d",success);
    }];
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        self.preferredContentSize = CGSizeMake(ScreenWidth, 160);
    } else {
        self.preferredContentSize = CGSizeMake(ScreenWidth, 110);
    }
}


@end
