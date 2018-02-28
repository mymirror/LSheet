# LSheet
使用方法

titleModel *model1 = [[titleModel alloc]init];
model1.modelColor = [UIColor redColor];
model1.modelFont = [UIFont systemFontOfSize:20];
model1.modelText = @"hello1";

titleModel *model2 = [[titleModel alloc]init];
model2.modelColor = [UIColor orangeColor];
model2.modelFont = [UIFont boldSystemFontOfSize:10];
model2.modelText = @"hello2";

titleModel *model3 = [[titleModel alloc]init];
model3.modelColor = [UIColor blueColor];
model3.modelFont = [UIFont systemFontOfSize:15];
model3.modelText = @"hello3";

titleModel *sheetTitleModel =[[titleModel alloc]init];
sheetTitleModel.modelColor = [UIColor darkGrayColor];
sheetTitleModel.modelFont = [UIFont systemFontOfSize:20];
sheetTitleModel.modelText = @"titles";

LCusSheet *sheet = [[LCusSheet alloc]initSheetText:@[model1,model2,model3] frame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) sheetTitleModel:sheetTitleModel clickBlock:^(NSString *sheetTitle) {
NSLog(@"%@",sheetTitle);
}];
[sheet show];

