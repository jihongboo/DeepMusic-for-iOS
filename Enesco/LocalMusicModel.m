//
//  LocalMusicModel.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/8.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "LocalMusicModel.h"

@implementation LocalMusicModel
- (void)setValueWithMusicEntity:(MusicEntity *)music {
    self.musicId = music.musicId;
    self.name = music.name;
    self.musicDescription = music.musicDescription;
    self.cover = music.cover;
    self.coverLocal = music.coverLocal;
    self.musicUrl = music.musicUrl;
    self.artistName = music.artistName;
    self.fileName = music.fileName;
    self.localPath = music.localPath;
    self.isFavorited = music.isFavorited;
    self.isDownloaded = music.isDownloaded;
}

- (MusicEntity *)getMusicEntity {
    MusicEntity *musicEntity = [[MusicEntity alloc]init];
    musicEntity.musicId = self.musicId;
    musicEntity.name = self.name;
    musicEntity.musicDescription = self.musicDescription;
    musicEntity.cover = self.cover;
    musicEntity.coverLocal = self.coverLocal;
    musicEntity.musicUrl = self.musicUrl;
    musicEntity.artistName = self.artistName;
    musicEntity.fileName = self.fileName;
    musicEntity.localPath = self.localPath;
    musicEntity.isFavorited = self.isFavorited;
    musicEntity.isDownloaded = self.isDownloaded;
    return musicEntity;
}
@end
