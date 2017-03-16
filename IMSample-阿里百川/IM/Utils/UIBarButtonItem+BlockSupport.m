//
//  UIBarButtonItem+BlockSupport.m
//  testFreeOpenIM
//
//  Created by sidian on 15/11/19.
//  Copyright © 2015年 taobao. All rights reserved.
//

#import "UIBarButtonItem+BlockSupport.h"
#import <objc/runtime.h>

const char *barbuttonItemBlockKey = "barbuttonItemBlockKey";

@implementation UIBarButtonItem (BlockSupport)

- (instancetype)initWithTitle:(nullable NSString *)title style:(UIBarButtonItemStyle)style andBlock:(void(^)())clickBlock
{
    self = [self initWithTitle:title style:style target:self action:@selector(handleClick)];
    if (self) {
        objc_setAssociatedObject(self, barbuttonItemBlockKey, clickBlock, OBJC_ASSOCIATION_COPY);
    }
    return self;
}

- (void)handleClick
{
    void (^block)() = objc_getAssociatedObject(self, barbuttonItemBlockKey);
    if (block ) {
        block();
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
