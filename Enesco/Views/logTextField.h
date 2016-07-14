//
//  logTextField.h
//  Enesco
//
//  Created by 纪洪波 on 16/7/14.
//  Copyright © 2016年 aufree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface logTextField : UIView
@property (nonatomic, copy, readonly) IBInspectable NSString *placeholder;
@property (nonatomic, strong, readonly) IBInspectable UIImage *image;
@property (nonatomic, assign, readonly) IBInspectable BOOL isPass;
@property (nonatomic, copy, readonly) NSString *text;
@end
