//
//  LocalMusicModel.h
//  Enesco
//
//  Created by 纪洪波 on 16/7/8.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import <Realm/Realm.h>
#import "MusicEntity.h"

@interface LocalMusicModel : RLMObject
@property (nonatomic, assign) NSInteger musicId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *musicDescription;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *coverLocal;
@property (nonatomic, copy) NSString *musicUrl;
@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *localPath;
@property (nonatomic, assign) BOOL isFavorited;
@property (nonatomic, assign) BOOL isDownloaded;

- (void)setValueWithMusicEntity:(MusicEntity *)music;
- (MusicEntity *)getMusicEntity;
@end
