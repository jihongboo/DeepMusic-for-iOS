//
//  MusicCollectionCell.h
//  Enesco
//
//  Created by 纪洪波 on 16/7/6.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicEntity.h"
#import "NAKPlaybackIndicatorView.h"

@interface MusicCollectionCell : UICollectionViewCell
@property (nonatomic, assign) NSInteger musicNumber;
@property (nonatomic, strong) MusicEntity *musicEntity;
//@property (nonatomic, weak) id<MusicListCellDelegate> delegate;
@property (nonatomic, assign) NAKPlaybackIndicatorViewState state;
@end
