//
//  DownloadCell.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/6.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "DownloadCell.h"

@interface DownloadCell()

@end

@implementation DownloadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    _downloadButton.delegate = _downloadButton;
    // Initialization code
}

//- (void)setData:(TYDownloadModel *)downloadModel {
//    _musicName.text = downloadModel.musicEntity.name;
//    [_downloadButton refreshDowloadInfoWithDownloadModel:downloadModel];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
