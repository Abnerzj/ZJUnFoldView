//
//  DetailViewController.m
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import "DetailViewController.h"
#import "ZJUnFoldView.h"
#import "ZJUnFoldView+Untils.h"

static NSString *const testContent = @"人生，如一幅春夏秋冬的景象，岁月，像一趟穿越四季的列车，我们都在路上。际遇是沿途的风光，无论我们是无视或是欣赏，终究都成为匆匆的过往。珍惜吧，珍惜会让生命中的美好增加一些重量。豁然吧，豁然是因为明白一切的风霜仅仅是过场。";

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lineSpacingLabel;
@property (weak, nonatomic) IBOutlet UILabel *foldLinesLabel;
@property (weak, nonatomic) IBOutlet UILabel *isDefaultUnFoldLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.dict[@"title"];
    
    CGFloat lineSpacing = ((NSNumber *)self.dict[@"lineSpacing"]).floatValue;
    NSInteger foldLines = ((NSNumber *)self.dict[@"foldLines"]).integerValue;
    BOOL isDefaultUnFold = ((NSNumber *)self.dict[@"isDefaultUnFold"]).boolValue;
    NSInteger locationValue = ((NSNumber *)self.dict[@"location"]).integerValue;
    self.lineSpacingLabel.text = [NSString stringWithFormat:@"行间距：%.1f", lineSpacing];
    self.foldLinesLabel.text = [NSString stringWithFormat:@"默认折叠：%ld", (long)foldLines];
    self.isDefaultUnFoldLabel.text = [NSString stringWithFormat:@"是否展开：%@", isDefaultUnFold ? @"展开" : @"不展开"];
    self.locationLabel.text = [NSString stringWithFormat:@"展开按钮位置：%@", (locationValue == 0) ? @"左边" : ((locationValue == 1) ? @"中间" : @"右边")];
    
    
    ZJUnFoldAttributedString *unFoldAttrStr = nil;
    NSMutableString *content = [[NSMutableString alloc] initWithString:testContent];
    if ([self.title isEqualToString:@"默认配置初始化"]) {
        // 1.获取属性字符串：默认配置
        unFoldAttrStr = [ZJUnFoldAttributedString defaultConficAttributedString:content];
    } else {
        
        // 注意：在4.7寸屏幕下由于测试文字内容长度不够，故增加一段字符来模拟这种情景，仅仅只用于测试
        if ([self.title isEqualToString:@"展开时展开按钮位置：左边"]) {
            [content appendString:@"豁然是因为明白一切的风霜仅仅"];
        }
        
        // 1.获取属性字符串：自定义内容和属性
        unFoldAttrStr = [[ZJUnFoldAttributedString alloc] initWithContent:content
                                                              contentFont:[UIFont systemFontOfSize:12.0f]
                                                             contentColor:[ZJUnFoldView colorWithHexString:@"#8b8b8b"]
                                                             unFoldString:@"[显示全文]"
                                                               foldString:@"[收回]"
                                                               unFoldFont:[UIFont systemFontOfSize:12.0f]
                                                              unFoldColor:[ZJUnFoldView colorWithHexString:@"#dd4991"]
                                                              lineSpacing:lineSpacing];
    }
    
    // 2.添加展开视图
    ZJUnFoldView *unFoldView = [[ZJUnFoldView alloc] initWithAttributedString:unFoldAttrStr maxWidth:[UIScreen mainScreen].bounds.size.width - 60.0f isDefaultUnFold:isDefaultUnFold foldLines:foldLines location:locationValue];
    unFoldView.frame = CGRectMake(30, CGRectGetMaxY(self.locationLabel.frame) + 30.0f, unFoldView.frame.size.width, unFoldView.frame.size.height);
    unFoldView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:unFoldView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
