//
//  MusicCollectionCell.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/6.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "MusicCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface MusicCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet NAKPlaybackIndicatorView *musicIndicator;

@end

@implementation MusicCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMusicEntity:(MusicEntity *)musicEntity {
    _musicEntity = musicEntity;
    [_cover sd_setImageWithURL:[NSURL URLWithString:_musicEntity.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
    _title.text = _musicEntity.name;
    _name.text = _musicEntity.artistName;
}

- (NAKPlaybackIndicatorViewState)state {
    return self.musicIndicator.state;
}

- (void)setState:(NAKPlaybackIndicatorViewState)state {
    self.musicIndicator.state = state;
//    self.musicNumberLabel.hidden = (state != NAKPlaybackIndicatorViewStateStopped);
}
@end
