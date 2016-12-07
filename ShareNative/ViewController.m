//
//  ViewController.m
//  ShareNative
//
//  Created by yxhe on 16/12/6.
//  Copyright © 2016年 tashaxing. All rights reserved.
//
// ---- 原生分享和被分享 ---- //

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)shareBtn:(id)sender
{
    // 分享
    
    // 分享的文字
    NSString *textToShare = _textView.text;
    // 图片预览
    UIImage *imageToShare = _imageView.image;
    // url
    NSURL *urlToShare = [NSURL URLWithString:@"https://www.baidu.com"];
    // 拼起来一个组
    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    
    // 构造activity(这个界面可以自定义)
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                                         applicationActivities:nil];
    activityViewController.modalInPopover = true; // 模态或者非模态
    
    // 可以设置分享到的选项规则
//    activityViewController.excludedActivityTypes = @[
//                                                     UIActivityTypePostToFacebook,
//                                                     UIActivityTypePostToTwitter,
//                                                     UIActivityTypePostToWeibo,
//                                                     UIActivityTypeMessage,
//                                                     UIActivityTypeMail,
//                                                     UIActivityTypePrint,
//                                                     UIActivityTypeCopyToPasteboard,
//                                                     UIActivityTypeAssignToContact,
//                                                     UIActivityTypeSaveToCameraRoll,
//                                                     UIActivityTypeAddToReadingList,
//                                                     UIActivityTypePostToFlickr,
//                                                     UIActivityTypePostToVimeo,
//                                                     UIActivityTypePostToTencentWeibo,
//                                                     UIActivityTypeAirDrop,
//                                                     UIActivityTypeOpenInIBooks];
    
    [self presentViewController:activityViewController animated:YES completion:nil]; // 调起
    
    // 设置回调
    activityViewController.completionWithItemsHandler = ^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        
        // 显示选中的分享类型
        NSLog(@"act type %@",activityType);
        
        if (completed)
        {
            NSLog(@"share success");
        }
        else
        {
            NSLog(@"share cancel");
        }
        
    };


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
