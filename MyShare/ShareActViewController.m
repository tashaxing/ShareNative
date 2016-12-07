//
//  ShareActViewController.m
//  ShareNative
//
//  Created by yxhe on 16/12/7.
//  Copyright © 2016年 tashaxing. All rights reserved.
//
// ---- 分享的列表自定义 ----

#import "ShareActViewController.h"

@interface ShareActViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) void (^selectedHandler) ();

@end

@implementation ShareActViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:tableView];
}

// 用于外部设置block回调
- (void)onSelected:(void(^)(NSIndexPath *indexPath))handler
{
    self.selectedHandler = handler;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.backgroundColor = [UIColor clearColor];
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"所有人";
            break;
        case 1:
            cell.textLabel.text = @"好友";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedHandler)
    {
        self.selectedHandler(indexPath);
    }
}

@end
