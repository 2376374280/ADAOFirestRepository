//
//  HomeViewController.m
//  WidgetLearn
//
//  Created by 孙道慧 on 2016/10/27.
//  Copyright © 2016年 孙道慧. All rights reserved.
//

#import "HomeViewController.h"
#import "ListViewController.h"

@interface HomeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sureAction:(id)sender {
    
    if ([self.inputTextField canResignFirstResponder]) {
        [self.inputTextField resignFirstResponder];
        if (self.inputTextField.text.length) {
            
            NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.adao.LearnWidget"];
            [shared setObject:@"10" forKey:@"kDesc"];
            UIImage *tempImage = [UIImage imageNamed:@"girl_head"];
            [shared setObject:UIImagePNGRepresentation(tempImage) forKey:@"kIcon"];
            [shared synchronize];
            
            // 通过 NSFileManager共享数据
            NSError *error = nil;
            NSURL *containerUrl = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.adao.LearnWidget"];
            containerUrl = [containerUrl URLByAppendingPathComponent:@"Library/Caches/test"];
            
            NSString *tempStr = self.inputTextField.text;
            BOOL result = [tempStr writeToURL:containerUrl atomically:YES encoding:NSUTF8StringEncoding error:&error];
            NSLog(@"--- %d",result);
        }
    }
    
}

- (IBAction)goNextVcAction:(id)sender {
    // 进入下一页
    ListViewController *lVc = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
    lVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lVc animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}


@end
