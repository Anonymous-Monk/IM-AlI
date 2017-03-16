//
//  ViewController.m
//  IMSample-阿里百川
//
//  Created by zero on 2017/3/14.
//  Copyright © 2017年 zero-zhou. All rights reserved.
//

#import "ViewController.h"
#import <WXOUIModule/YWConversationListViewController.h>
#import "SPKitManager.h"
#import <WXOpenIMSDKFMWK/YWConversation.h>
@interface ViewController ()
@property(nonatomic,strong) SPKitManager *spkit; //
@property(nonatomic,strong) UIView *msgListView; //
@end

@implementation ViewController{
    NSString *currentId;
    YWConversationListViewController *conversationListController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupIMList];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setupIMList{
//    BOOL isLogin = [YISUserManager shareInstance].isLogin;
//    if (!isLogin) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotification object:nil];
//        return;
//    }
//    NSString *uid = [YISUserManager shareInstance].user.user.id;
//    if(currentId != nil && ![currentId isEqualToString: uid]){
//        [self.msgListView removeFromSuperview];
//        [conversationListController removeFromParentViewController];
//        DDLogDebug(@"currentId%@--userid:%@",currentId,uid);
//    }else if (currentId != nil){
//        return;
//    }
    self.spkit = [SPKitManager sharedInstance];
    [self.spkit checkLoginRun:^{
        [self _setupIMList];
    }];
    
}
-(void)_setupIMList{
    conversationListController = [self.spkit.ywIMKit makeConversationListViewController];
    conversationListController.view.frame = [UIScreen mainScreen].bounds;
    conversationListController.view.backgroundColor =[UIColor clearColor];
    
    __weak __typeof(conversationListController) weakConversationListController;
    weakConversationListController = conversationListController;
    YWConversationsListDidSelectItemBlock selectItemBlock;
    selectItemBlock = ^(YWConversation *aConversation) {
        if ([aConversation isKindOfClass:[YWCustomConversation class]]) {
            YWCustomConversation *customConversation = (YWCustomConversation *)aConversation;
            [customConversation markConversationAsRead];
        }
        else {
            [[SPKitManager sharedInstance] exampleOpenConversationViewControllerWithConversation:aConversation
                                                                 fromNavigationController:weakConversationListController.navigationController];
        }    };
    
    [conversationListController setDidSelectItemBlock:selectItemBlock];
    
    [self.spkit exampleCustomizeConversationCellWithConversationListController:conversationListController];
    
    conversationListController.didDeleteItemBlock = ^ (YWConversation *aConversation) {};
    self.msgListView = conversationListController.view;
    
    
    [self.view addSubview:self.msgListView];
    [self addChildViewController:conversationListController];
    [self didMoveToParentViewController:conversationListController];
    
    __weak typeof(self.navigationController) weakController = self.navigationController;
    [self.spkit.ywIMKit setUnreadCountChangedBlock:^(NSInteger aCount) {
        NSString *badgeValue = aCount > 0 ?[ @(aCount) stringValue] : nil;
        weakController.tabBarItem.badgeValue = badgeValue;
    }];
    
    
}

- (UIView *)msgListView{
    if (!_msgListView) {
        _msgListView = [[UIView alloc]initWithFrame:self.view.bounds];
    }
    return _msgListView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
