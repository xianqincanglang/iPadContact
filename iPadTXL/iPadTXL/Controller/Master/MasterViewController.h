//
//  MasterViewController.h
//  iPadTXL
//
//  Created by marchsoft on 15/9/24.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "BaseViewController.h"
#import "DetailViewController.h"
#import "CreateContactPersonViewController.h"

#import "ShowContactViewController.h"


@interface MasterViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *masterTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *masterSearchBar;
@property (strong,nonatomic)NSMutableArray *dataList;


@property(nonatomic,strong)NSMutableArray *fliterDataList;//存储查询后的数据
-(void)getDataList;


@property(nonatomic,strong)ShowContactViewController *show;
@property(nonatomic,strong)CreateContactPersonViewController *create;


- (void)filterContentByName:(NSString *)name;
@end
