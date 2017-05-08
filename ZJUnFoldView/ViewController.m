//
//  ViewController.m
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import "ViewController.h"
#import "ZJUnFoldView.h"
#import "ZJUnFoldView+Untils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 1.获取属性字符串：自定义内容和属性
//    ZJUnFoldAttributedString *unFoldAttrStr = [[ZJUnFoldAttributedString alloc] initWithContent:@"港珠澳大桥。港珠澳大桥。珠澳大桥港珠澳大桥珠澳大桥港珠澳大桥港"
//                                                                                    contentFont:[UIFont systemFontOfSize:12.0f]
//                                                                                   contentColor:[ZJUnFoldView colorWithHexString:@"#8b8b8b"]
//                                                                                   unFoldString:@"[显示全文]"
//                                                                                     foldString:@"[收回]"
//                                                                                     unFoldFont:[UIFont systemFontOfSize:12.0f]
//                                                                                    unFoldColor:[ZJUnFoldView colorWithHexString:@"#dd4991"]
//                                                                                    lineSpacing:0.0f];
    // 1.获取属性字符串：默认配置
    ZJUnFoldAttributedString *unFoldAttrStr = [ZJUnFoldAttributedString defaultConficAttributedString:@"港珠澳大桥。港珠澳大桥。港珠gggggggghs澳大港珠澳大桥。港珠澳大桥。港珠澳大桥港珠澳大桥港珠澳ffff大桥港珠澳大桥港珠澳大桥珠澳大桥港珠澳大桥港珠澳大桥港珠澳大桥澳大桥港珠澳大桥珠澳大桥港珠澳大桥港珠澳大桥港珠澳大桥珠澳大桥港珠澳大桥港珠澳大桥港珠澳大桥澳大桥港珠澳大桥"];
    
    // 2.添加展开视图
    ZJUnFoldView *unFoldView = [[ZJUnFoldView alloc] initWithAttributedString:unFoldAttrStr maxWidth:200.0f isDefaultUnFold:NO foldLines:3 location:UnFoldButtonLocationRight];
    unFoldView.frame = CGRectMake(100, 100, unFoldView.frame.size.width, unFoldView.frame.size.height);
    unFoldView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:unFoldView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
