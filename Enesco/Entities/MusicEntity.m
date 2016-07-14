//
//  MusicEntity.m
//  Ting
//
//  Created by Aufree on 11/13/15.
//  Copyright © 2015 Ting. All rights reserved.
//

#import "MusicEntity.h"
#import "LocalMusicModel.h"
#import "ZFDownloadManager.h"

@implementation MusicEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"musicId" : @"id",
             @"name" : @"title",
             @"musicDescription" : @"description",
             @"cover" : @"artwork_url",
             @"musicUrl" : @"url",//[[MusicAPI defaultManager].apiURL stringByAppendingString:@"url"],
             @"artistName" : @"user.username",
             @"fileName" : @"file_name"
             };
}

-(void)setMusicUrl:(NSString *)musicUrl {
    _musicUrl = [[MusicAPI defaultManager].apiURL stringByAppendingString:musicUrl];
}

-(NSString *)localPath {
    return ZFFileFullpath(_musicUrl);
}

-(NSString *)coverLocal {
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath= [documentsDirectory stringByAppendingPathComponent:@"/cover"];
    return [NSString stringWithFormat:@"%@%ld.jpg", filePath, (long)self.musicId];
}
@end
