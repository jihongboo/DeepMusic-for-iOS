//
//  LocalMusicVC.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/7.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "LocalMusicVC.h"
#import "LocalManager.h"
#import "ZFDownloadManager.h"
#import "MJRefresh.h"
#import "MusicCollectionCell.h"
#import "LocalMusicModel.h"

@interface LocalMusicVC ()

@end

@implementation LocalMusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setHeader {
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self reloadLocalMusic];
    }];
    header.lastUpdatedTimeLabel.hidden = true;
    [header setTitle:@"Loading" forState:MJRefreshStateRefreshing];
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)loadMusicTypeView {
}

- (void)reloadLocalMusic {
    NSMutableArray *downloadModels = [ZFDownloadManager sharedInstance].downloadedArray;
    NSMutableArray *musics = [NSMutableArray array];
    for (ZFSessionModel *downloadModel in downloadModels) {
        for (LocalMusicModel * music in [[LocalManager manager] getLocalMusics]) {
            if ([music.musicUrl isEqualToString:downloadModel.url]) {
                [musics addObject:[music getMusicEntity]];
            }
        }
    }
    self.musicEntities = musics;
    [self.collectionView reloadData];
    [self.collectionView.mj_header endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
