//
//  RadioTableController.h
//  Checkauto
//
//  Created by Wang keke on 12-6-21.
//  Copyright (c) 2012年 Uxin. All rights reserved.
//

#import <UIKit/UIKit.h>

/*****************************************************/

/*
 *数据源需要实现的协议
 */
@protocol provideTableDataDelegate <NSObject>

-(NSDictionary*)provideData;

@end
//----------------------------------------------------

/*
 *需要单选列表的对象需要实现的协议
 */
@protocol SelectTableDelegate <NSObject>

-(void)selectItem:(NSDictionary *)dic Sender:(id)sender;//选择列表向委托传输数据

@optional

-(id *)SelectedObjectName:(NSString*)objectName;//用于联动选择,选择列表向委托对象索要已经选择过的信息

@end
/*********************end****************************/




@interface RadioTableController : UIViewController
{
    id<SelectTableDelegate>delegate;//此委托为需要单选列表视图控制器
    id<provideTableDataDelegate>dataSource;//此委托为提供列表数据的控制器
    
    BOOL isNeedIndex;//是否需要索引
    NSMutableArray *indexArray;//索引数组
    NSMutableArray *contentArray;//内容数组
    
    CGSize size;
    UIActivityIndicatorView *indicator;
    
}
@property(retain,nonatomic) UIActivityIndicatorView *indicator;
@property (retain, nonatomic) IBOutlet UILabel *TitleLabel;
@property (retain, nonatomic) IBOutlet UITableView *contentTable;
@property(retain,nonatomic) id<SelectTableDelegate>delegate;//此委托为需要单选列表视图控制器
@property(retain,nonatomic) id<provideTableDataDelegate>dataSource;//此委托为提供列表数据的控制器
@property(retain,nonatomic) NSMutableArray *indexArray;//索引数组
@property(retain,nonatomic) NSMutableArray *contentArray;//内容数组
@property(assign,nonatomic) BOOL isNeedIndex;
@property(assign,nonatomic) CGSize size;

-(void)configeWithDelegate:(id<SelectTableDelegate>)t_delegate 
                DataSource:(id<provideTableDataDelegate>)t_dataS 
                      SIZE:(CGSize)t_size
                  HasIndex:(BOOL)t_isIndex;


@end
