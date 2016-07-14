//
//  MusicCollecionVC.h
//  Enesco
//
//  Created by 纪洪波 on 16/7/6.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicCollecionVCDelegate <NSObject>
- (void)playMusicWithSpecialIndex:(NSInteger)index;
@end

@interface MusicCollecionVC : UICollectionViewController
@property (nonatomic, weak) id <MusicCollecionVCDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *musicEntities;

@end
