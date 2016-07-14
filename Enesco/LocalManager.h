//
//  LocalManager.h
//  Enesco
//
//  Created by 纪洪波 on 16/7/7.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicEntity.h"

@interface LocalManager : NSObject

+ (LocalManager *)manager;

- (NSArray *)getLocalMusics;
- (void)addMusic:(MusicEntity *)music;
- (void)setDownloadedWithMusicURL:(NSString *)musicURL;
- (MusicEntity *)getLocalMusicWithURL:(NSString *)URL;
@end
