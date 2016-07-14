//
//  MusicAPI.h
//  Enesco
//
//  Created by 纪洪波 on 16/7/5.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicAPI : NSObject
@property (strong, nonatomic) NSString *apiURL;
@property (strong, nonatomic) NSArray *musicClassifys;

+ (MusicAPI *)defaultManager;
- (void)getMusicClassifysWithcompleteBlock:(void (^)(NSArray *musicClassifys,NSError *error)) completeBlock;
- (void)getMusicListWithMusicClassify:(NSString *)musicClassify page:(NSUInteger)page completeBlock:(void (^)(NSDictionary * musicList,NSError *error)) completeBlock;
- (void)searchMusicWithString:(NSString *)string page:(NSUInteger)page completeBlock:(void (^)(NSArray * musicList,NSError *error)) completeBlock;
- (void)checkNetworkWithBlock:(void (^)(bool isWork))block;
- (void)loginWithUsername:(NSString *)username password:(NSString *)password completeBlock:(void (^)(bool isSuccess,NSError *error)) completeBlock;
@end
