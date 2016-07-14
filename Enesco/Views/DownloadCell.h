//
//  DownloadCell.h
//  Enesco
//
//  Created by 纪洪波 on 16/7/6.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadButton.h"

@interface DownloadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PKDownloadButton *downloadButton;
@property (weak, nonatomic) IBOutlet UILabel *musicName;

//- (void)setData:(TYDownloadModel *)downloadModel;
@end
