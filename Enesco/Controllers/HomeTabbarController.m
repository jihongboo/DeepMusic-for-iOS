//
//  HomeTabbarController.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/12.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "HomeTabbarController.h"

@interface HomeTabbarController ()

@end

@implementation HomeTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (UITabBarItem *item in self.tabBar.items) {
        item.selectedImage = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:64 / 255.0 green:228 / 255.0 blue:145 / 255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
