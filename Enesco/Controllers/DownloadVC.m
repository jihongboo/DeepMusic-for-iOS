//
//  DownloadVC.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/6.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "DownloadVC.h"
#import "DownloadCell.h"
#import "LocalManager.h"
#import "MusicEntity.h"
#import "ZFDownloadManager.h"
#import "LocalMusicModel.h"

@interface DownloadVC ()<ZFDownloadDelegate>
//@property (nonatomic, strong) TYDownloadSessionManager *downloadManager;
@property (nonatomic, strong) NSMutableArray *downloadingList;
@property (nonatomic, strong) NSMutableArray *waitingList;
//@property (atomic, strong) NSMutableArray *downloadObjectArr;
@end

@implementation DownloadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

- (void)initData
{
    _downloadingList = [ZFDownloadManager sharedInstance].downloadingArray;
//    _waitingList = [ZFDownloadManager sharedInstance].;
//    _downloadObjectArr = @[].mutableCopy;
//    [_downloadObjectArr addObject:downladed];
//    [_downloadObjectArr addObject:downloading];
    
    [self.tableView reloadData];
}

#pragma mark - ZFDownloadDelegate

- (void)downloadResponse:(ZFSessionModel *)sessionModel
{
    if (self.downloadingList) {
        // 取到对应的cell上的model
        if ([_downloadingList containsObject:sessionModel]) {
            
            NSInteger index = [_downloadingList indexOfObject:sessionModel];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            __block DownloadCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            __weak typeof(self) weakSelf = self;
            sessionModel.progressBlock = ^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.downloadButton.stopDownloadButton.progress = progress;
                });
            };
            
            sessionModel.stateBlock = ^(DownloadState state){
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 更新数据源
                    if (state == DownloadStateCompleted) {
                        [weakSelf initData];
                        cell.downloadButton.state = kPKDownloadButtonState_Downloaded;
                    }
                    // 暂停
                    if (state == DownloadStateSuspended) {
                        
                    }
                    if (state == DownloadStateStart) {
                        if (cell.downloadButton.state != kPKDownloadButtonState_Downloading) {
                            cell.downloadButton.state = kPKDownloadButtonState_Downloading;
                        }
                    }
                });
            };
        }
    }
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSArray *sectionArray = self.downloadObjectArr[section];
    return _downloadingList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block ZFSessionModel *downloadObject = _downloadingList[indexPath.row];
//    if (indexPath.section == 0) {
//        DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadedCell"];
//        cell.sessionModel = downloadObject;
//        return cell;
//    }else if (indexPath.section == 1) {
        DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadCell"];
    for (LocalMusicModel * music in [[LocalManager manager] getLocalMusics]) {
        if ([music.musicUrl isEqualToString:downloadObject.url]) {
            cell.musicName.text = music.name;
        }
    }
        [ZFDownloadManager sharedInstance].delegate = self;
//        cell.downloadBlock = ^(UIButton *sender) {
//            [[ZFDownloadManager sharedInstance] download:downloadObject.url progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {} state:^(DownloadState state) {}];
//        };
        return cell;
//    }
//    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *downloadArray = _downloadingList[indexPath.section];
    ZFSessionModel * downloadObject = downloadArray[indexPath.row];
    // 根据url删除该条数据
    [[ZFDownloadManager sharedInstance] deleteFile:downloadObject.url];
    [downloadArray removeObject:downloadObject];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}
@end
