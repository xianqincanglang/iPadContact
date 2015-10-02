//
//  MasterViewController.m
//  iPadTXL
//
//  Created by marchsoft on 15/9/24.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "MasterViewController.h"
#import "DatabaseUsage.h"

#import "UserModel.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"所有联系人";
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContactPerson:)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshContactPerson:)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _masterTableView.tableFooterView = [UIView new];
    

    

    [self getDataList];
    
    [self getContoller];
    
    
    [self initControl];
    //初次进入页面，查询所有数据
    [self filterContentByName:@""];
}

//初始化控件
- (void)initControl
{

    self.masterSearchBar.placeholder = @"Search by name";
    self.masterSearchBar.delegate = self;

    
}

- (void)filterContentByName:(NSString *)name
{
    if ([name length]==0) {
        //查询所有
        self.dataList = [[NSMutableArray alloc] init];
        [self.dataList removeAllObjects];
        
        NSArray *tempArray = [[[DatabaseUsage alloc] init] selectData];
        [self.dataList addObjectsFromArray:tempArray];
            [_masterTableView reloadData];
        return;
    }
    else{
        NSPredicate *predicate;
        NSArray *tempArray;
        predicate = [NSPredicate predicateWithFormat:@"SELF.family contains[c] %@",name];
        tempArray = [self.dataList filteredArrayUsingPredicate:predicate];
        self.dataList = [[NSMutableArray alloc] init];
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:tempArray];
            [_masterTableView reloadData];
        
    }
    
}
- (void)getContoller
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.show = (ShowContactViewController *)[storyboard instantiateViewControllerWithIdentifier:@"showContactScene"];
//    self.create = (CreateContactPersonViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CreateContactScene"];
}


-(void)getDataList
{
    self.dataList = [[NSMutableArray alloc] init];
    [self.dataList removeAllObjects];

    NSArray *tempArray = [[[DatabaseUsage alloc] init] selectData];
    [self.dataList addObjectsFromArray:tempArray];
    

    NSLog(@"------------");
    [_masterTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showContactSegue"]) {
        NSIndexPath *indexPath = [self.masterTableView indexPathForSelectedRow];
        UserModel *userModel = [UserModel new];
        userModel = [self.dataList objectAtIndex:indexPath.row];

        
        self.show = (ShowContactViewController *)[[segue destinationViewController] topViewController];
        self.show.userId = userModel.userId;        
    }
    if ([[segue identifier] isEqualToString:@"createContactSegue"]) {
        NSLog(@"start create contact");
    }
}

#pragma mark - 表视图数据源委托
//设置表视图每一节有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserModel *model = [[UserModel alloc] init];
    model = [self.dataList objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"masterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@·%@",model.family,model.name];
    return cell;
    
}

//表视图单元格单击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [self performSegueWithIdentifier:@"showContactSegue" sender:self];
}

#pragma mark - 添加联系人
- (void)addContactPerson:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"createContactSegue" sender:self];
}

- (void)refreshContactPerson:(UIBarButtonItem *)sender
{
    NSLog(@"刷新联系人");
}

#pragma mark - UISearchDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentByName:searchText];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self filterContentByName:@""];
}

@end
