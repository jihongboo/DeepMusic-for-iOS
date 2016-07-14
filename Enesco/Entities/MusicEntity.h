//
//  MusicEntity.h
//  Ting
//
//  Created by Aufree on 11/13/15.
//  Copyright © 2015 Ting. All rights reserved.
//

#import "BaseEntity.h"

@interface MusicEntity : BaseEntity
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
@end