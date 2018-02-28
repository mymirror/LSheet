//
//  LCusSheet.h
//  LSheet
//
//  Created by ponted on 2018/2/28.
//  Copyright © 2018年 Shenzhen Blood Link Medical Technology Co., Ltd. All rights reserved.
//
/*
 *   加入字体大小
        字体颜色
 */

#import <UIKit/UIKit.h>

typedef void(^sheetClickBlock)(NSString *sheetTitle);


@interface  titleModel:NSObject

@property (nonatomic, strong) UIFont *modelFont;//字体  字体系统默认 大小系统默认16

@property (nonatomic, copy) NSString *modelText;//文字内容

@property (nonatomic, strong) UIColor *modelColor;//字体颜色。 默认黑色


@end

@interface LCusSheet : UIView<UITableViewDelegate,UITableViewDataSource>


- (instancetype)initSheetText:(NSArray *)textArray frame:(CGRect)frame sheetTitleModel:(titleModel *)sheetTitleModel clickBlock:(sheetClickBlock)block;

- (void)show;

- (void)hide;

@end
