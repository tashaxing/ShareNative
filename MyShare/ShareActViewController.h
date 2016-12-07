//
//  ShareActViewController.h
//  ShareNative
//
//  Created by yxhe on 16/12/7.
//  Copyright © 2016年 tashaxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareActViewController : UIViewController

- (void)onSelected:(void (^)(NSIndexPath *indexPath))handler;

@end
