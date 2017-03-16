//
//  UIControl+BlockSupport.m
//  testFreeOpenIM
//
//  Created by sidian on 15/11/19.
//  Copyright © 2015年 taobao. All rights reserved.
//

#import "UIControl+BlockSupport.h"
#import <objc/runtime.h>

const char *switchBlockSupportKey = "controlBlockSupportKey";

@implementation UIControl (BlockSupport)

- (void)addblock:(void(^)())block forControlEvents:(UIControlEvents)controlEvents
{
    objc_setAssociatedObject(self, switchBlockSupportKey, block, OBJC_ASSOCIATION_COPY);
    [self addTarget:self action:@selector(handleSwitch) forControlEvents:controlEvents];
}

- (void)handleSwitch
{
    void(^block)() = objc_getAssociatedObject(self, switchBlockSupportKey);
    if (block) {
        block();
    }
}


@end
