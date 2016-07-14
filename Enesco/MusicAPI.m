//
//  MusicAPI.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/5.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "MusicAPI.h"

@interface MusicAPI()
@end
@implementation MusicAPI
+ (MusicAPI *)defaultManager
{
    static MusicAPI *muusicAPIManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        muusicAPIManager = [[MusicAPI alloc] init];
    });
    return muusicAPIManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _apiURL = @"http://peeping.cc";
        _musicClassifys = @[@"indie", @"electronic", @"hiphop", @"pop", @"rock", @"deephouse", @"house", @"rbsoul", @"jazzblues", @"trap", @"country", @"dancehall", @"dubstep"];
    }
    return self;
}

/**
 *  登陆
 *
 *  @param username      用户名
 *  @param password      密码
 *  @param completeBlock 返回成功与否
 */
- (void)loginWithUsername:(NSString *)username password:(NSString *)password completeBlock:(void (^)(bool isSuccess,NSError *error)) completeBlock {
    NSString *urlString = [_apiURL stringByAppendingString:[NSString stringWithFormat:@"/signup/%@?page=%@", username, password]];
    NSString *transString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:transString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:120];
    //    [request setValue:self.settings.token forHTTPHeaderField:@"Soundlife-Token"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completeBlock(true, error);
    }];
    [task resume];
}

/**
 *  获得所有音乐类型
 *
 *  @param completeBlock 音乐类型数组
 */
- (void)getMusicClassifysWithcompleteBlock:(void (^)(NSArray *musicClassifys,NSError *error)) completeBlock {
    
}

/**
 *  根据音乐类型返回音乐列表
 *
 *  @param MusicClassify 音乐类型
 *  @param page 分页
 *  @param completeBlock 音乐列表数组
 */
- (void)getMusicListWithMusicClassify:(NSString *)musicClassify page:(NSUInteger)page completeBlock:(void (^)(NSDictionary * musicList,NSError *error)) completeBlock {
    NSString *transString = [musicClassify stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlString = [_apiURL stringByAppendingString:[NSString stringWithFormat:@"/charts/%@?page=%ld", transString, (unsigned long)page]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:120];
//    [request setValue:self.settings.token forHTTPHeaderField:@"Soundlife-Token"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completeBlock(dic, error);
    }];
    [task resume];
}

/**
 *  搜索音乐
 *
 *  @param string        搜索字段
 *  @param page          分页
 *  @param completeBlock 音乐列表数组
 */
- (void)searchMusicWithString:(NSString *)string page:(NSUInteger)page completeBlock:(void (^)(NSArray * musicList,NSError *error)) completeBlock{
    NSString *transString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlString = [_apiURL stringByAppendingString:[NSString stringWithFormat:@"/tracks/search?query=%@&page=%ld", transString, (unsigned long)page]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:120];
    //    [request setValue:self.settings.token forHTTPHeaderField:@"Soundlife-Token"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completeBlock(dic, error);
    }];
    [task resume];
}

/**
 *  检查网络
 *
 *  @param block 是否继续
 */
- (void)checkNetworkWithBlock:(void (^)(bool isWork))block {
    [GLobalRealReachability reachabilityWithBlock:^(ReachabilityStatus status) {
        switch (status)
        {
            case RealStatusNotReachable:
            {
                //  case NotReachable handler
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"网络出现故障，请检查网络情况！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    block(false);
                }];
                [alert addAction:ok];
                [[Tools getPresentedViewController].navigationController presentViewController:alert animated:true completion:nil];
                break;
            }
                
            case RealStatusViaWiFi:
            {
                //  case WiFi handler
                block(true);
                break;
            }
                
            case RealStatusViaWWAN:
            {
                //  case WWAN handler
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"正在使用数据流量，这可能会产生额外费用，是否继续？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    block(true);
                }];
                [alert addAction:ok];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    block(false);
                }];
                [alert addAction:cancel];
                [[Tools getPresentedViewController].navigationController presentViewController:alert animated:true completion:nil];
                break;
            }
            default:
                break;
        }
    }];
}
@end
