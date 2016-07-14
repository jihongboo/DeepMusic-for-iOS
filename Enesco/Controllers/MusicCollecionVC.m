//
//  MusicCollecionVC.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/6.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "MusicCollecionVC.h"
#import "MusicCollectionCell.h"
#import "MusicIndicator.h"
#import "MusicViewController.h"
#import "MusicListViewController.h"
#import "MJRefresh.h"
#import "MusicTypeTV.h"

@interface MusicCollecionVC ()<UICollectionViewDelegateFlowLayout, MusicViewControllerDelegate, MusicTypeTVDelegate>
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) NSString *musicClassify;
@property (nonatomic, copy) NSString *searchString;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) MusicTypeTV *listVC;
@end

@implementation MusicCollecionVC

static NSString * const reuseIdentifier = @"MusicCollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _musicClassify = @"trending";
    _currentPage = 0;
    _musicEntities = [NSMutableArray array];
    
    [self setHeader];
    [self loadMusicTypeView];
    
    UINib *nib = [UINib nibWithNibName:@"MusicCollectionCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setHeader {
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self headerRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = true;
    [header setTitle:@"Loading" forState:MJRefreshStateRefreshing];
    self.collectionView.mj_header = header;
    
    self.collectionView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [self loadMoreWithPage:_currentPage];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
}

# pragma mark - Load data from server

- (void)headerRefreshing {
    //    NSDictionary *musicsDict = [self dictionaryWithContentsOfJSONString:@"music_list.json"];
    [[MusicAPI defaultManager] getMusicListWithMusicClassify:_musicClassify page:0 completeBlock:^(NSDictionary *musicList, NSError *error) {
        NSArray *tracks = [musicList valueForKey:@"songs"];
        self.musicEntities = [NSMutableArray arrayWithArray:[MusicEntity arrayOfEntitiesFromArray:tracks]];
        dispatch_async(dispatch_get_main_queue(),^{
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            _currentPage++;
        });
    }];
}

- (void)search {
    //    NSDictionary *musicsDict = [self dictionaryWithContentsOfJSONString:@"music_list.json"];
    [[MusicAPI defaultManager] searchMusicWithString:_searchString page:0 completeBlock:^(NSArray *musicList, NSError *error) {
        self.musicEntities = [NSMutableArray arrayWithArray:[MusicEntity arrayOfEntitiesFromArray:musicList]];
        dispatch_async(dispatch_get_main_queue(),^{
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            _currentPage++;
        });
    }];
}

- (void)loadMoreWithPage:(NSInteger)page {
    //    NSDictionary *musicsDict = [self dictionaryWithContentsOfJSONString:@"music_list.json"];
    [[MusicAPI defaultManager] getMusicListWithMusicClassify:_musicClassify page:page completeBlock:^(NSDictionary *musicList, NSError *error) {
        NSArray *tracks = [musicList valueForKey:@"songs"];
        [self.musicEntities addObjectsFromArray:[MusicEntity arrayOfEntitiesFromArray:tracks].mutableCopy];
        dispatch_async(dispatch_get_main_queue(),^{
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            _currentPage++;
        });
    }];
}

- (void)loadMusicTypeView {
    _listVC = [MusicTypeTV sharedInstance];
    _listVC.myDelegate = self;
    [self.view addSubview:_listVC];
}

- (IBAction)showMusicTypeView:(UIBarButtonItem *)sender {
    if (_listVC.isShow) {
        [_listVC dismissMusicTypeTV];
    }else {
        [_listVC showMusicTypeTV];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _musicEntities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MusicEntity *music = _musicEntities[indexPath.row];
    cell.musicEntity = music;
    [self updatePlaybackIndicatorOfCell:cell];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(playMusicWithSpecialIndex:)]) {
        [_delegate playMusicWithSpecialIndex:indexPath.row];
    } else {
        MusicViewController *musicVC = [MusicViewController sharedInstance];
        musicVC.musicTitle = self.navigationItem.title;
        musicVC.musicEntities = _musicEntities;
        musicVC.specialIndex = indexPath.row;
        musicVC.delegate = self;
        [self presentToMusicViewWithMusicVC:musicVC];
    }
    [self updatePlaybackIndicatorWithIndexPath:indexPath];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

# pragma mark - Jump to music view

- (void)presentToMusicViewWithMusicVC:(MusicViewController *)musicVC {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:musicVC];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

# pragma mark - Update music indicator state
- (void)updatePlaybackIndicatorWithIndexPath:(NSIndexPath *)indexPath {
    for (MusicCollectionCell *cell in self.collectionView.visibleCells) {
        cell.state = NAKPlaybackIndicatorViewStateStopped;
    }
    MusicCollectionCell * musicsCell = (MusicCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    musicsCell.state = NAKPlaybackIndicatorViewStatePlaying;
}

- (void)updatePlaybackIndicatorOfCell:(MusicCollectionCell *)cell {
    MusicEntity *music = cell.musicEntity;
    if (music.musicId == [[MusicViewController sharedInstance] currentPlayingMusic].musicId) {
        cell.state = NAKPlaybackIndicatorViewStateStopped;
        cell.state = [MusicIndicator sharedInstance].state;
    } else {
        cell.state = NAKPlaybackIndicatorViewStateStopped;
    }
}

- (void)updatePlaybackIndicatorOfVisisbleCells {
    for (MusicCollectionCell *cell in self.collectionView.visibleCells) {
        [self updatePlaybackIndicatorOfCell:cell];
    }
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KScreenWidth / 2 - 0.5, KScreenWidth/ 2 - 0.5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}


#pragma mark <MusicTypeTVDelegate>
- (void)choosedType:(NSString *)typeString {
    _musicClassify = typeString;
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header.refreshingBlock =^{
        [weakSelf headerRefreshing];
    };
    [self.collectionView.mj_header beginRefreshing];
}

-(void)searchWithString:(NSString *)string {
    _searchString = string;
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header.refreshingBlock =^{
        [weakSelf search];
    };
    [self.collectionView.mj_header beginRefreshing];
}

@end
