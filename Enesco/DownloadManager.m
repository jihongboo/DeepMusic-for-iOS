//
//  DownloadManager.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/8.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "DownloadManager.h"

@implementation DownloadManager
+ (DownloadManager *)manager
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
@end
