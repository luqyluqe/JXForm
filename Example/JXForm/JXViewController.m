//
//  JXViewController.m
//  JXForm
//
//  Created by luqyluqe on 05/03/2016.
//  Copyright (c) 2016 luqyluqe. All rights reserved.
//

#import "JXViewController.h"
#import "JXForm.h"

@interface JXViewController ()<JXFormDelegate,JXFormDataSource>

@end

@implementation JXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    JXForm* form=[[JXForm alloc] initWithFrame:self.view.bounds];
    form.delegate=self;
    form.dataSource=self;
    [self.view addSubview:form];
    UILabel* cell_1_2=(UILabel*)[form cellAtRow:1 column:2];
    NSString* text=cell_1_2.text;
    NSLog(@"%@",text);
}

-(NSInteger)numberOfRowsInForm:(JXForm *)form
{
    return 10;
}
-(NSInteger)numberOfColumnsInForm:(JXForm *)form
{
    return 10;
}
-(CGFloat)form:(JXForm *)form heightForRow:(NSInteger)row
{
    return 20;
}
-(CGFloat)form:(JXForm *)form widthForColumn:(NSInteger)column
{
    return 30;
}
-(CGFloat)paddingLeftForForm:(JXForm *)form
{
    return 10;
}
-(CGFloat)paddingTopForForm:(JXForm *)form
{
    return 20;
}
-(UIView*)form:(JXForm *)form contentViewForRow:(NSInteger)row column:(NSInteger)column
{
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:6];
    label.text=[NSString stringWithFormat:@"[%ld,%ld]",(long)row,(long)column];
    return label;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
