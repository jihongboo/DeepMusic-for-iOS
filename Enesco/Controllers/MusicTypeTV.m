//
//  MusicTypeTV.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/12.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "MusicTypeTV.h"

@interface MusicTypeTV()<UITextFieldDelegate>
@property(nonatomic, strong) NSArray *typeList;
@property(nonatomic, strong) NSArray *musicClassifys;
@property(nonatomic, assign) BOOL isFirstShow;
@end

@implementation MusicTypeTV

+ (instancetype)sharedInstance {
    static MusicTypeTV *_sharedMusicVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedMusicVC = [[MusicTypeTV alloc]initWithFrame:CGRectMake(- KScreenWidth / 2, 64, KScreenWidth / 2, KScreenHeight - 64) style:UITableViewStyleGrouped];
    });
    
    return _sharedMusicVC;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        _typeList = @[@"trending", @"Search"];
        _musicClassifys = [MusicAPI defaultManager].musicClassifys;
        
        self.backgroundColor = [UIColor blackColor];
        self.separatorColor = [UIColor blackColor];
    }
    return self;
}

- (void)showMusicTypeTV{
    _isShow = true;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, 64, KScreenWidth / 2, KScreenHeight - 64);
    }];
    if (!_isFirstShow) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self cellForRowAtIndexPath:indexPath].selected = true;
        _isFirstShow = true;
    }
}

- (void)dismissMusicTypeTV{
    _isShow = false;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(- KScreenWidth / 2, 64, KScreenWidth / 2, KScreenHeight - 64);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [_typeList[indexPath.row] capitalizedString];
        }else if (indexPath.row == 1){
            UITextField *searchField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth / 2 - 30, 44)];
            searchField.textColor = [UIColor whiteColor];
            searchField.delegate = self;
            searchField.placeholder = [_typeList[indexPath.row] capitalizedString];
            [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
            [cell.contentView addSubview:searchField];
        }
    }else if (indexPath.section == 1) {
        cell.textLabel.text = [_musicClassifys[indexPath.row] capitalizedString];
    }
    cell.backgroundColor = [UIColor colorWithRed:15 / 255.0 green:15 / 255.0 blue:15 / 255.0 alpha:1];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIView *selectedView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
    selectedView.backgroundColor = [UIColor colorWithRed:64 / 255.0 green:228 / 255.0 blue:145 / 255.0 alpha:1];
    cell.selectedBackgroundView = selectedView;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.myDelegate choosedType:_typeList[indexPath.row]];
            [self dismissMusicTypeTV];
        }else {
        }
    }else {
        [self.myDelegate choosedType:_musicClassifys[indexPath.row]];
        [self dismissMusicTypeTV];
    }
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    if (indexPath != index) {
        [self cellForRowAtIndexPath:index].selected = false;
    }
    [self cellForRowAtIndexPath:indexPath].selected = true;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.myDelegate searchWithString:textField.text];
    [textField resignFirstResponder];
    [self dismissMusicTypeTV];
    return true;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _typeList.count;
    }else if (section == 1) {
        return _musicClassifys.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
