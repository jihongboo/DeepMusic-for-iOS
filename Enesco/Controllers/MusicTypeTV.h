//
//  MusicTypeTV.h
//  Enesco
//
//  Created by 纪洪波 on 16/7/12.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicTypeTVDelegate <NSObject>

- (void)choosedType:(NSString *)typeString;
- (void)searchWithString:(NSString *)string;

@end

@interface MusicTypeTV : UITableView<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) id<MusicTypeTVDelegate> myDelegate;
@property(nonatomic, assign) BOOL isShow;

+ (instancetype)sharedInstance;
- (void)showMusicTypeTV;
- (void)dismissMusicTypeTV;
@end
