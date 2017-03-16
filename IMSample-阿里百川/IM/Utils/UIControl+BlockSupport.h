//
//  UIControl+BlockSupport.h
//  testFreeOpenIM
//
//  Created by sidian on 15/11/19.
//  Copyright © 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIControl (BlockSupport)

- (void)addblock:(void(^)())block forControlEvents:(UIControlEvents)controlEvents;

@end
