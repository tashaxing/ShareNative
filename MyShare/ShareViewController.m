//
//  ShareViewController.m
//  MyShare
//
//  Created by yxhe on 16/12/6.
//  Copyright © 2016年 tashaxing. All rights reserved.
//
// ---- 分享被插件网页图片书签什么都可以 ---- //

#import "ShareViewController.h"
#import "ShareActViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

// 如果是return No, 那么发送按钮就无法点击, 如果return YES, 那么发送按钮就可以点击
- (BOOL)isContentValid
{
    // Do validation of contentText and/or NSExtensionContext attachments here
    
    // 这里可以对内容做一下过滤，比如限制字数
    if (self.contentText.length > 140)
    {
        return NO;
    }

    return YES;
}

// 发送按钮的Action事件
- (void)didSelectPost
{
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    
    // 此处可以替换分享界面
    
    // 此处有两种方法
    // 1，把分享的内容上传到服务器，需要发网络请求
    // 2，在宿主程序和插件里面都打开app groups选项，共享沙盒存储
    
    
//    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}


// 这个方法是用来返回items的一个方法, 而且返回值是数组，比如微信分享选择联系人还是朋友圈
- (NSArray *)configurationItems
{
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    
    static BOOL isPublic = NO;
    static NSInteger actOption = 0;
    
    NSMutableArray *items = [NSMutableArray array];
    
    // 开关选项
    SLComposeSheetConfigurationItem *item1 = [[SLComposeSheetConfigurationItem alloc] init];
    item1.title = @"public or private";
    item1.value = isPublic ? @"yes" : @"no";
    
    __weak typeof(self) weakSelf = self;
    __weak SLComposeSheetConfigurationItem *weakItem = item1;
    item1.tapHandler = ^{
        isPublic = !isPublic;
        weakItem.value = isPublic ? @"yes" : @"no";
        
        // 重刷 UI
        [weakSelf reloadConfigurationItems];
    };
    
    [items addObject:item1];
    
    if (isPublic)
    {
        SLComposeSheetConfigurationItem *actItem = [[SLComposeSheetConfigurationItem alloc] init];
        actItem.title = @"公开权限";
        
        // 根据选项设置title
        switch (actOption)
        {
            case 0:
                actItem.value = @"所有人";
                break;
            case 1:
                actItem.value = @"好友";
                break;
            default:
                break;
        }
        
        actItem.tapHandler = ^{
            
            //设置分享权限时弹出选择界面
            ShareActViewController *actVC = [[ShareActViewController alloc] init];
            [weakSelf pushConfigurationViewController:actVC];
            
            [actVC onSelected:^(NSIndexPath *indexPath) {
                
                //当选择完成时退出选择界面并刷新配置项。
                
                // 配置用户后续post中参数
                actOption = indexPath.row;
                [weakSelf popConfigurationViewController];
                [weakSelf reloadConfigurationItems];
                
            }];
            
        };
        
        [items addObject:actItem];
    }
    
    return items;
}

@end
