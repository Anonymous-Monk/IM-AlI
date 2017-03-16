//
//  UIBarButtonItem+BlockSupport.h
//  testFreeOpenIM
//
//  Created by sidian on 15/11/19.
//  Copyright © 2015年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BlockSupport)

- (nullable instancetype)initWithTitle:(nullable NSString *)title style:(UIBarButtonItemStyle)style andBlock:(void(^)())clickBlock;

@end
