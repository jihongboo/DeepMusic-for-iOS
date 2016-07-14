//
//  DownloadButton.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/7.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "DownloadButton.h"

@interface DownloadButton()

@end

@implementation DownloadButton
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.startDownloadButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.startDownloadButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self.startDownloadButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.startDownloadButton setAttributedTitle:nil forState:UIControlStateHighlighted];
    [self.startDownloadButton setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    [self.startDownloadButton setTitle:@"" forState:UIControlStateNormal];
    
    [self.downloadedButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.downloadedButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self.downloadedButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.downloadedButton setAttributedTitle:nil forState:UIControlStateHighlighted];
    [self.downloadedButton setImage:[UIImage imageNamed:@"downloaded"] forState:UIControlStateNormal];
    [self.downloadedButton setTitle:@"" forState:UIControlStateNormal];
    
    self.stopDownloadButton.tintColor = [UIColor whiteColor];
}

@end
