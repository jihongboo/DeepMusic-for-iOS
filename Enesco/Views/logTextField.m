//
//  logTextField.m
//  Enesco
//
//  Created by 纪洪波 on 16/7/14.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import "logTextField.h"

@interface logTextField()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextField *input;
@end

@implementation logTextField

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logUser"]];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView sizeToFit];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(20);
    }];
    
    _input = [[UITextField alloc]init];
    _input.borderStyle = UITextBorderStyleNone;
    _input.textColor = [UIColor whiteColor];
    [self addSubview:_input];
    [_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_right).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(10);
        make.centerY.equalTo(self);
    }];
}

-(void)setPlaceholder:(NSString *)placeholder {
    UIColor *color = [UIColor lightGrayColor];
    _input.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: color}];
}

-(void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)setIsPass:(BOOL)isPass {
    _input.secureTextEntry = true;
}

-(NSString *)text {
    return self.input.text;
}
@end
