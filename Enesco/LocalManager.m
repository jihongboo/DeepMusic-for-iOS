//
//  LocalManager.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/7.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "LocalManager.h"
#import "SDWebImageManager.h"
#import "RLMRealm.h"
#import "LocalMusicModel.h"

@implementation LocalManager
+ (LocalManager *)manager
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSArray *)getLocalMusics {
    RLMResults * results =[LocalMusicModel allObjects];
    NSMutableArray * localMusics = [NSMutableArray array];
    for (RLMResults *result in results) {
        LocalMusicModel *localMusicModel = (LocalMusicModel *)result;
        if (localMusicModel.isDownloaded) {
            [localMusics addObject:localMusicModel];
        }
    }
    return localMusics;
}

- (MusicEntity *)getLocalMusicWithURL:(NSString *)URL {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"musicUrl = %@ AND isDownloaded = true",
                         URL];
    RLMResults *r = [LocalMusicModel objectsWithPredicate:pred];
    LocalMusicModel* localMusicModel = r.firstObject;
    
    return [localMusicModel getMusicEntity];
}

- (void)addMusic:(MusicEntity *)music {
//    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:music.cover] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        NSString *filePath= [documentsDirectory stringByAppendingPathComponent:@"cover"];
//        NSLog(@"%@", filePath);
//        NSString *fileName = [NSString stringWithFormat:@"%ld", music.musicId];
//        [self saveImage:image withFileName:fileName ofType:@"jpg" inDirectory:filePath];
//    }];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"musicUrl = %@",
                         music.musicUrl];
    RLMResults *r = [LocalMusicModel objectsWithPredicate:pred];
    LocalMusicModel* localMusicModel = r.firstObject;
    RLMRealm *realm = [RLMRealm defaultRealm];
    if (localMusicModel) {
        [realm transactionWithBlock:^{
            [localMusicModel setValueWithMusicEntity:music];
        }];
    }else {
        LocalMusicModel *model = [[LocalMusicModel alloc]init];
        [model setValueWithMusicEntity:music];
        [realm transactionWithBlock:^{
            [realm addObject:model];
        }];
    }
    
    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    LocalMusicModel *model = [[LocalMusicModel alloc]init];
//    [model setValueWithMusicEntity:music];
//    [realm transactionWithBlock:^{
//        [realm addObject:model];
//    }];
}

- (void)setDownloadedWithMusicURL:(NSString *)musicURL {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"musicUrl = %@",
                         musicURL];
    RLMResults *r = [LocalMusicModel objectsWithPredicate:pred];
    LocalMusicModel* localMusicModel = r.firstObject;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        localMusicModel.isDownloaded = true;
    }];
}

- (void)saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        NSLog(@"文件后缀不认识");
    }
}

@end
