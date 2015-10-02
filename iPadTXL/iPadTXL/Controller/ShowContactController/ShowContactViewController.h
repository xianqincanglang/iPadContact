//
//  ShowContactViewController.h
//  iPadTXL
//
//  Created by marchsoft on 15/9/30.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "BaseViewController.h"
#import "UserModel.h"
#import "DatabaseUsage.h"

@interface ShowContactViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UserModel *model;
}
@property (weak, nonatomic) IBOutlet UITableView *showTabelView;


@property int userId;

@end
