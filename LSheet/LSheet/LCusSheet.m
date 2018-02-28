//
//  LCusSheet.m
//  LSheet
//
//  Created by ponted on 2018/2/28.
//  Copyright © 2018年 Shenzhen Blood Link Medical Technology Co., Ltd. All rights reserved.
//

#import "LCusSheet.h"

#define SheetBgWidth [[UIScreen mainScreen] bounds].size.width
#define SheetBgHeight [[UIScreen mainScreen] bounds].size.height
#define sheetScale(x) (x*SheetBgWidth/320.0)

@implementation titleModel

@end

@interface LCusSheet()
{
    sheetClickBlock clickSheetBlock;
    CGFloat titleheight;
    titleModel *TableTitleModel;
}

@property (nonatomic, strong)NSArray *titleModelArray;

@property (nonatomic, strong)UITableView *sheetTableView;

@end

@implementation LCusSheet

- (instancetype)initSheetText:(NSArray *)textArray frame:(CGRect)frame sheetTitleModel:(titleModel *)sheetTitleModel clickBlock:(sheetClickBlock)block
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (block) {
            clickSheetBlock = block;
        }
        TableTitleModel = sheetTitleModel;
        _titleModelArray = [NSArray arrayWithArray:textArray];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self createView:sheetTitleModel];
    }
    
    return self;
}

- (void)createView:(titleModel *)sheetTitleModel
{
    titleheight = 0;
    if (sheetTitleModel.modelText.length)
    {
        CGSize sheetTitleSize = [sheetTitleModel.modelText boundingRectWithSize:CGSizeMake(SheetBgWidth-sheetScale(20), MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:sheetTitleModel.modelFont?sheetTitleModel.modelFont:[UIFont systemFontOfSize:16]} context:nil].size;
        titleheight = sheetTitleSize.height+sheetScale(20);
    }
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SheetBgHeight, SheetBgWidth, sheetScale(60)*(_titleModelArray.count)+titleheight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.scrollEnabled = NO;
    tableview.separatorColor = [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:1.0];
    tableview.tableFooterView = [UIView new];
    if (_sheetTableView == nil) {
        _sheetTableView = tableview;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:1.0];;
    }
    titleModel *model = [_titleModelArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = model.modelFont?model.modelFont:[UIFont systemFontOfSize:16] ;
    cell.textLabel.textColor = model.modelColor?model.modelColor:[UIColor blackColor];
    cell.textLabel.text = model.modelText;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return sheetScale(60);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!_titleModelArray.count)
    {
        return;
    }
    titleModel *model = [_titleModelArray objectAtIndex:indexPath.row];
    clickSheetBlock(model.modelText);
    [self hide];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!TableTitleModel.modelText.length) {
        return nil;
    }
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SheetBgWidth, titleheight)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(sheetScale(10), sheetScale(10), SheetBgWidth-sheetScale(20), titleheight-sheetScale(20))];
    label.text = TableTitleModel.modelText;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = TableTitleModel.modelColor?TableTitleModel.modelColor:[UIColor blackColor];
    label.font = TableTitleModel.modelFont?TableTitleModel.modelFont:[UIFont systemFontOfSize:16];
    [bgview addSubview:label];
    
    return bgview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!TableTitleModel.modelText.length) {
        return 0.00001f;
    }
    return titleheight;
}

- (void)show
{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [self addSubview:_sheetTableView];
    __block LCusSheet *weakSelf = self;
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        weakSelf->_sheetTableView.transform = CGAffineTransformMakeTranslation(0, -_sheetTableView.frame.size.height);
    } completion:^(BOOL finished) {}];
}

- (void)hide
{
     __block LCusSheet *weakSelf = self;
    CGRect frame = _sheetTableView.frame;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
        weakSelf->_sheetTableView.transform = CGAffineTransformMakeTranslation(0, frame.size.height);
    } completion:^(BOOL finished) {
        [weakSelf->_sheetTableView removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

- (void)dealloc
{
    NSLog(@"释放");
}

@end
