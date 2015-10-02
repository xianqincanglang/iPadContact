//
//  ShowContactViewController.m
//  iPadTXL
//
//  Created by marchsoft on 15/9/30.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "ShowContactViewController.h"
#import "ShowContactFirstCell.h"
#import "AlertContactViewController.h"

@interface ShowContactViewController ()

@end

@implementation ShowContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(alertContact)];
    self.navigationItem.rightBarButtonItem = leftBarButton;
    
    
    self.showTabelView.delegate = self;
    self.showTabelView.dataSource = self;
    self.showTabelView.tableFooterView = [UIView new];
    
    
    model = [[[DatabaseUsage alloc] init] selectDataByUserId:self.userId];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - 修改联系人信息
- (void)alertContact
{
    [self performSegueWithIdentifier:@"alertContactSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"alertContactSegue"]) {
        AlertContactViewController *alert = (AlertContactViewController *)[[segue destinationViewController] topViewController];
        alert.userModel = model;
        alert.userId = self.userId;
        
    }
}

//设置表视图每节有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
//设置表视图单元格的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ShowContactFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showContactFirstCell"];
        cell.nameLabel.text = model.family;
        return cell;
    }else
    {
        return [UITableViewCell new];
        
    }
}

//设置表视图单元的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 70;
    }else{
        return 44;
    }
}



@end
